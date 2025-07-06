import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets/custom_snackbar.dart';
import '../../core/models/category_model.dart';
import 'category_view_model.dart';

class ManageCategoriesView extends ConsumerStatefulWidget {
  const ManageCategoriesView({super.key});

  @override
  ConsumerState<ManageCategoriesView> createState() =>
      _ManageCategoriesViewState();
}

class _ManageCategoriesViewState extends ConsumerState<ManageCategoriesView> {
  final _controller = TextEditingController();

  void _addCategory() {
    final name = _controller.text.trim();
    if (name.isEmpty) {
      showCustomSnackbar(context, 'O nome da categoria não pode ser vazio');
      return;
    }
    ref.read(categoryViewModelProvider.notifier).addCategory(name);
    _controller.clear();
    showCustomSnackbar(context, 'Categoria adicionada');
  }

  void _editCategory(CategoryModel category) {
    final controller = TextEditingController(text: category.name);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Editar Categoria'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Nome da Categoria'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              final newName = controller.text.trim();
              if (newName.isNotEmpty) {
                final updated = CategoryModel(id: category.id, name: newName);
                ref
                    .read(categoryViewModelProvider.notifier)
                    .updateCategory(updated);
                Navigator.pop(context);
                showCustomSnackbar(context, 'Categoria atualizada');
              }
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  void _deleteCategory(int id) {
    ref.read(categoryViewModelProvider.notifier).deleteCategory(id);
    showCustomSnackbar(context, 'Categoria deletada');
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Categorias')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Nova categoria',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: _addCategory,
                  icon: const Icon(Icons.add),
                  label: const Text('Adicionar'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.separated(
                itemCount: categories.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (_, index) {
                  final cat = categories[index];
                  return ListTile(
                    title: Text(cat.name),
                    trailing: Wrap(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _editCategory(cat),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteCategory(cat.id!),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
