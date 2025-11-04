import 'package:flutter/material.dart';

Widget buildNumberChip(int number, {
  bool isBonus = false,
  Color? primaryColor,
  bool isBall = true,
}) {
  const Color color = Colors.blue;
  const Color textColor = Colors.white;
  final Color actualColor = primaryColor ?? (isBonus ? Colors.orange : color);

  if (isBall) {
    // Kugel-Design für Lottozahlen
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: actualColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: actualColor.withOpacity(0.5),
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: const Center(
        child: Text(
          '0', // Wird dynamisch ersetzt
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  } else {
    // Rechteckiger Chip
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: actualColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        number.toString(),
        style: const TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
