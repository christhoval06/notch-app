import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PinDots extends StatelessWidget {
  final int length;
  final int codeLength;
  final Color activeColor;

  const PinDots({
    Key? key,
    required this.length,
    this.codeLength = 4,
    this.activeColor = Colors.blueAccent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(codeLength, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index < length ? activeColor : Colors.grey[800],
            boxShadow: index < length
                ? [
                    BoxShadow(
                      color: activeColor.withOpacity(0.4),
                      blurRadius: 10,
                    ),
                  ]
                : null,
          ),
        );
      }),
    );
  }
}

// 2. EL TECLADO NUMÉRICO
class Numpad extends StatelessWidget {
  final Function(String) onDigitPress;
  final VoidCallback onDeletePress;

  const Numpad({
    Key? key,
    required this.onDigitPress,
    required this.onDeletePress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          _buildRow(['1', '2', '3']),
          _buildRow(['4', '5', '6']),
          _buildRow(['7', '8', '9']),
          _buildRow(['', '0', 'del']),
        ],
      ),
    );
  }

  Widget _buildRow(List<String> digits) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: digits.map((d) {
          if (d.isEmpty) return const SizedBox(width: 70, height: 70);
          if (d == 'del') {
            return IconButton(
              icon: const Icon(Icons.backspace_outlined, color: Colors.white),
              iconSize: 28,
              onPressed: () {
                HapticFeedback.selectionClick();
                onDeletePress();
              },
            );
          }
          return InkWell(
            onTap: () {
              HapticFeedback.selectionClick();
              onDigitPress(d);
            },
            borderRadius: BorderRadius.circular(40),
            child: Container(
              width: 70,
              height: 70,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[900],
              ),
              child: Text(
                d,
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
