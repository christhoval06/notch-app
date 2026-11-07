import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notch_app/core/constants/app_clip_config.dart';
import 'package:notch_app/core/constants/app_store_config.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class AppClipInstallButton extends StatelessWidget {
  const AppClipInstallButton({super.key});

  Future<void> _install(BuildContext context) async {
    try {
      await const MethodChannel(
        AppClipConfig.channel,
      ).invokeMethod<void>(AppClipConfig.installMethod, AppStoreConfig.url);
    } on PlatformException {
      if (context.mounted) _showUnavailable(context);
    } on MissingPluginException {
      if (context.mounted) _showUnavailable(context);
    }
  }

  void _showUnavailable(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context).appClipInstallUnavailable),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => SafeArea(
    minimum: const EdgeInsets.all(16),
    child: FilledButton.icon(
      onPressed: () => _install(context),
      icon: const Icon(Icons.download_outlined),
      label: Padding(
        padding: const EdgeInsets.all(14),
        child: Text(AppLocalizations.of(context).appClipGetApp),
      ),
    ),
  );
}
