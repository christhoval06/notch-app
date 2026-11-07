import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PinPadButton extends StatefulWidget {
  final String? label;
  final IconData? icon;
  final VoidCallback onPressed;

  const PinPadButton({
    super.key,
    this.label,
    this.icon,
    required this.onPressed,
  }) : assert(label != null || icon != null);

  @override
  State<PinPadButton> createState() => _PinPadButtonState();
}

class _PinPadButtonState extends State<PinPadButton> {
  bool _isPressed = false;

  void _setPressed(bool value) {
    if (_isPressed == value) return;
    setState(() => _isPressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final backgroundColor = _isPressed
        ? scheme.onSurface.withOpacity(0.10)
        : scheme.surface;

    return GestureDetector(
      onTapDown: (_) {
        _setPressed(true);
        HapticFeedback.selectionClick();
      },
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: widget.onPressed,
      child: AnimatedScale(
        scale: _isPressed ? 0.94 : 1,
        duration: const Duration(milliseconds: 90),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOut,
          width: 70,
          height: 70,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor,
            boxShadow: _isPressed
                ? null
                : [
                    BoxShadow(
                      color: scheme.shadow.withOpacity(0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: widget.icon != null
              ? Icon(widget.icon, color: scheme.onSurface, size: 28)
              : Text(
                  widget.label!,
                  style: TextStyle(
                    color: scheme.onSurface,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ),
      ),
    );
  }
}
