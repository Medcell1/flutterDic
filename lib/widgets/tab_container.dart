import 'package:flutter/material.dart';

class TabContainer extends StatelessWidget {
  final String text;
  final bool isSelected;

  const TabContainer({required this.text, required this.isSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? Colors.white : Colors.grey),
      ),

      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 16, color: isSelected ? Colors.white : Colors.grey),
        ),
      ),
    );
  }
}