import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notch_app/l10n/app_localizations.dart';

import 'pin_pad.dart';

class PinSelectionSheet extends StatefulWidget {
  final String title;
  final Color color;

  const PinSelectionSheet({
    super.key,
    required this.title,
    required this.color,
  });

  @override
  _PinSelectionSheetState createState() => _PinSelectionSheetState();
}

class _PinSelectionSheetState extends State<PinSelectionSheet> {
  String _pin = "";

  void _onDigitPress(String digit) {
    if (_pin.length < 4) {
      setState(() => _pin += digit);

      // Si llegamos a 4 dígitos, devolvemos el valor y cerramos
      if (_pin.length == 4) {
        HapticFeedback.mediumImpact();
        Future.delayed(const Duration(milliseconds: 300), () {
          Navigator.pop(context, _pin);
        });
      }
    }
  }

  void _onDeletePress() {
    if (_pin.isNotEmpty) {
      setState(() => _pin = _pin.substring(0, _pin.length - 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Container(
      height: 600, // Altura suficiente para el teclado
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            widget.title,
            style: TextStyle(
              color: widget.color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            l10n.pinEnter4Digits,
            style: TextStyle(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: 40),

          // Usamos nuestro widget de Puntos
          PinDots(length: _pin.length, activeColor: widget.color),

          const Spacer(),

          // Usamos nuestro widget de Teclado
          Numpad(onDigitPress: _onDigitPress, onDeletePress: _onDeletePress),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
