import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../../core/models/category_model.dart';
import '../../core/services/local_db_service.dart';

final categoryViewModelProvider =
    StateNotifierProvider<CategoryViewModel, List<CategoryModel>>(
      (ref) => CategoryViewModel(),
    );

class CategoryViewModel extends StateNotifier<List<CategoryModel>> {
  final _db = GetIt.I<LocalDbService>();

  CategoryViewModel() : super([]) {
    loadCategories();
  }

  Future<void> loadCategories() async {
    final data = await _db.getAllCategories();
    state = data;
  }

  Future<void> addCategory(String name) async {
    final exists = state.any(
      (cat) => cat.name.toLowerCase() == name.toLowerCase(),
    );
    if (exists) return;
    final newCategory = CategoryModel(name: name);
    await _db.insertCategory(newCategory);
    await loadCategories();
  }

  Future<void> deleteCategory(int id) async {
    await _db.deleteCategory(id);
    await loadCategories();
  }

  Future<void> updateCategory(CategoryModel updated) async {
    await _db.updateCategory(updated);
    await loadCategories();
  }
}
