// criar um botão personalizado com efeito neumórfico usando o pacote clay_containers

import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';

class CustomNeumorphicButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const CustomNeumorphicButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ClayContainer(
      height: 60,
      width: 200,
      borderRadius: 30,
      depth: 50,
      spread: 1,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 24, color: Theme.of(context).primaryColor),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
