import 'package:flutter/material.dart';

class IconLabel extends StatelessWidget {
  const IconLabel({
    super.key,
    required this.icon,
    required this.label,
    this.color,
    this.style,
    this.size = 14,
  });
  final IconData icon;
  final String label;
  final Color? color;
  final TextStyle? style;
  final double size;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: size, color: color),
      const SizedBox(width: 6),
      Flexible(child: Text(label, style: style)),
    ],
  );
}
