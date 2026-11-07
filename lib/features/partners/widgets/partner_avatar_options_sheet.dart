import 'package:flutter/material.dart';
import 'package:notch_app/core/theme/color_scheme_semantics.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class PartnerAvatarOptionsSheet extends StatelessWidget {
  const PartnerAvatarOptionsSheet({
    super.key,
    required this.onGalleryTap,
    required this.onEmojiTap,
  });

  final VoidCallback onGalleryTap;
  final VoidCallback onEmojiTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              l10n.partnerChangeAvatar,
              style: TextStyle(
                color: scheme.onSurface,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.photo_library, color: scheme.primary),
            title: Text(
              l10n.partnerChooseFromGallery,
              style: TextStyle(color: scheme.onSurface),
            ),
            onTap: onGalleryTap,
          ),
          ListTile(
            leading: Icon(Icons.emoji_emotions, color: scheme.warning),
            title: Text(
              l10n.partnerChooseEmoji,
              style: TextStyle(color: scheme.onSurface),
            ),
            onTap: onEmojiTap,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
