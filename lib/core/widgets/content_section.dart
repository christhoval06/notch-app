import 'package:flutter/material.dart';

class ContentSection extends StatelessWidget {
  const ContentSection({
    super.key,
    required this.child,
    this.color,
    this.maxWidth = 1200,
    this.verticalPadding = 72,
  });
  final Widget child;
  final Color? color;
  final double maxWidth;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: color ?? Theme.of(context).scaffoldBackgroundColor,
    child: LayoutBuilder(
      builder: (context, constraints) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: constraints.maxWidth < 600 ? 20 : 40,
          vertical: constraints.maxWidth < 600
              ? verticalPadding * .7
              : verticalPadding,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: child,
          ),
        ),
      ),
    ),
  );
}
