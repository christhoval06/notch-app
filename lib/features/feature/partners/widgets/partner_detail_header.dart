import 'package:flutter/material.dart';
import 'package:notch_app/data/models/partner.dart';
import 'package:notch_app/features/feature/partners/widgets/partner_avatar.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class PartnerDetailHeader extends StatelessWidget {
  const PartnerDetailHeader({
    super.key,
    required this.partner,
    required this.onEditAvatar,
  });

  final Partner partner;
  final VoidCallback onEditAvatar;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SliverAppBar(
      expandedHeight: 250,
      pinned: true,
      backgroundColor: scheme.surface,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          partner.name,
          style: TextStyle(
            shadows: [Shadow(color: scheme.scrim, blurRadius: 10)],
          ),
        ),
        background: GestureDetector(
          onTap: onEditAvatar,
          child: Stack(
            fit: StackFit.expand,
            children: [
              PartnerAvatar(partner: partner, radius: 125),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      scheme.scrim.withValues(alpha: 0.7),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context).partnerEdit,
                      style: TextStyle(
                        color: scheme.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.edit,
                      color: scheme.onSurfaceVariant,
                      size: 14,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
