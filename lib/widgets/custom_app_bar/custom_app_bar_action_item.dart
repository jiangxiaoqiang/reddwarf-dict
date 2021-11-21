import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBarActionItem extends StatelessWidget {
  final IconData? icon;
  final String? text;
  final Widget? child;
  final EdgeInsets? padding;
  final VoidCallback? onPressed;

  const CustomAppBarActionItem({
    Key? key,
    this.icon,
    this.text,
    this.child,
    this.padding,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: padding ?? EdgeInsets.only(right: 12),
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
          return;
        }
        Navigator.maybePop(context);
      },
      child: Container(),
    );
  }
}
