import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const CustomNavigationBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      elevation: 2,
      selectedIndex: currentIndex,
      destinations: const [
        NavigationDestination(icon: Icon(Icons.dashboard), label: 'Dashboard'),
        NavigationDestination(icon: Icon(Icons.list), label: 'Despesas'),
        NavigationDestination(icon: Icon(Icons.bar_chart), label: 'Graficos'),
        NavigationDestination(
          icon: Icon(Icons.settings),
          label: 'Configurações',
        ),
      ],
      onDestinationSelected: (value) {
        // futura logica de navegação
      },
    );
  }
}
