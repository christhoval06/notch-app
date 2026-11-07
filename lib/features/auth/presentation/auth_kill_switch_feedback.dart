import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:notch_app/features/auth/services/auth_kill_switch_service.dart';
import 'package:flutter/material.dart';
import 'package:notch_app/l10n/app_localizations.dart';

void showAuthKillSwitchFeedback(BuildContext context) {
  final scheme = Theme.of(context).colorScheme;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: scheme.onError),
          const SizedBox(width: 10),
          Expanded(
            child: Text(AppLocalizations.of(context).authKillSwitchExecuted),
          ),
        ],
      ),
      backgroundColor: scheme.error,
      duration: const Duration(seconds: 5),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

Future<bool> performAuthKillSwitch(
  BuildContext context,
  FlutterSecureStorage storage,
) async {
  try {
    await AuthKillSwitchService.execute(storage);
    return true;
  } catch (_) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).watchResetUnavailable),
        ),
      );
    }
    return false;
  }
}
