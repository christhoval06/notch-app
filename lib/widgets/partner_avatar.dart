import 'dart:io';
import 'package:flutter/material.dart';
import '../models/partner.dart';

class PartnerAvatar extends StatelessWidget {
  final Partner partner;
  final double radius;

  const PartnerAvatar({Key? key, required this.partner, this.radius = 25})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    switch (partner.avatarType) {
      case AvatarType.image:
        return CircleAvatar(
          radius: radius,
          backgroundImage: FileImage(File(partner.avatarContent)),
          backgroundColor: scheme.surfaceContainerHighest,
        );
      case AvatarType.emoji:
        return CircleAvatar(
          radius: radius,
          backgroundColor: scheme.surface,
          child: Text(
            partner.avatarContent,
            style: TextStyle(fontSize: radius),
          ),
        );
      case AvatarType.initial:
      default:
        // El color se guarda como un String, lo convertimos a int
        final colorValue = int.tryParse(partner.avatarContent) ?? scheme.scrim.toARGB32();
        final color = Color(colorValue);

        return CircleAvatar(
          radius: radius,
          backgroundColor: color,
          child: Text(
            partner.name.isNotEmpty ? partner.name[0].toUpperCase() : '?',
            style: TextStyle(
              fontSize: radius * 0.9,
              color: scheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
    }
  }
}
