import 'package:flutter/material.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class SharePreviewActionBar extends StatelessWidget {
  const SharePreviewActionBar({
    super.key,
    required this.isLoading,
    required this.onShare,
  });

  final bool isLoading;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHigh.withValues(alpha: 0.88),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: scheme.outlineVariant.withValues(alpha: 0.35),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: FilledButton.icon(
              onPressed: isLoading ? null : onShare,
              icon: isLoading
                  ? SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        color: scheme.onPrimary,
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(Icons.ios_share_rounded),
              label: Text(l10n.sharePreviewAction),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
