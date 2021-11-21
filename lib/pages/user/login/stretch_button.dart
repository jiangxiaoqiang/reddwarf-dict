import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StretchButton extends StatelessWidget {
  const StretchButton({
    Key? key,
     this.onTap,
     this.text,
    this.primary = true,
  }) : super(key: key);

  final VoidCallback? onTap;

  final String? text;

  final bool primary;

  @override
  Widget build(BuildContext context) {
    Color background = Theme.of(context).primaryColor;
    var foreground = Theme.of(context).primaryTextTheme.bodyText2!.color;
    if (primary) {
      final temp = background;
      background = foreground!;
      foreground = temp;
    }
    final border = primary
        ? BorderSide.none
        : BorderSide(color: foreground!.withOpacity(0.5), width: 0.5);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: background,
        textStyle: TextStyle(
          color: foreground,
        ),
        shape: RoundedRectangleBorder(
            side: border, borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      onPressed: onTap,
      child: Center(child: Text(text!)),
    );
  }
}
