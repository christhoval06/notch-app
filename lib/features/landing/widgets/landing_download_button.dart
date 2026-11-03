import 'package:flutter/material.dart';
import 'package:notch_app/core/constants/landing_config.dart';
import 'package:notch_app/features/landing/services/landing_link_service.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class LandingDownloadButton extends StatelessWidget {
  const LandingDownloadButton({super.key, required this.links});
  final LandingLinkService links;

  Future<void> _download(BuildContext context) async {
    final l = AppLocalizations.of(context);
    if (LandingConfig.appStoreUrl.isEmpty) {
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(l.landingStoreUnavailable),
          content: Text(l.landingStoreMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l.landingClose),
            ),
          ],
        ),
      );
      return;
    }
    final opened = await links.open(LandingConfig.appStoreUrl);
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l.landingLinkError)));
    }
  }

  @override
  Widget build(BuildContext context) => FilledButton.icon(
    onPressed: () => _download(context),
    icon: const Icon(Icons.download_outlined, size: 20),
    label: Text(AppLocalizations.of(context).landingDownload),
  );
}
