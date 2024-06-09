import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyMacroWidget extends StatelessWidget {
  final String title;
  final int value;
  final IconData icon;

  const MyMacroWidget({
    required this.title,
    required this.value,
    required this.icon,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              offset: const Offset(2, 2),
              blurRadius: 5
            )
          ]
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              FaIcon(
                icon, 
                color: Colors.redAccent,
              ),
              const SizedBox(height: 4),
              Text(
                title == "Calories"
                  ? '$value $title'
                  : '${value}g $title',
                style: const TextStyle(
                  fontSize: 10
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}

class MyMacroWidgetEdit extends StatelessWidget {
  final String title;
  final int value;
  final IconData icon;
  final TextEditingController controller;

  const MyMacroWidgetEdit({
    required this.title,
    required this.value,
    required this.icon,
    required this.controller,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow,
              offset: const Offset(2, 2),
              blurRadius: 5
            )
          ]
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              FaIcon(
                icon, 
                color: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(height: 4),
              TextField(
                controller: controller,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12
                ),
                decoration: InputDecoration(
                  isDense: true,
                  suffixText: title == "Calories"
                    ? ''
                    : 'g',
                  contentPadding: const EdgeInsets.symmetric(vertical: 8)
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}