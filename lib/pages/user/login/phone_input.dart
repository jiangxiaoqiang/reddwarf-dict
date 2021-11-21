import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wheel/wheel.dart';

class PhoneInput extends StatelessWidget {
  PhoneInput({Key? key,
    this.selectedRegion,
    this.onPrefixTap,
    this.onDone,
    this.onPhoneChanged,
    this.controller
  }) : super(key: key);

  final controller;

  final RegionFlag? selectedRegion;

  final VoidCallback? onPrefixTap;

  final VoidCallback? onDone;

  final VoidCallback? onPhoneChanged;

  Color? _textColor(BuildContext context) {
    if (controller.text.isEmpty) {
      return Theme.of(context).disabledColor;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyText2!.copyWith(
          fontSize: 16,
          color: _textColor(context),
        );
    return TextField(
      autofocus: true,
      style: style,
      onChanged: (text) => onPhoneChanged!(),
      controller: controller,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      onSubmitted: (text) => onDone!(),
      decoration: InputDecoration(
        prefix: InkWell(
          onTap: onPrefixTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              "${selectedRegion!.emoji} ${selectedRegion!.dialCode}",
              style: style,
            ),
          ),
        ),
      ),
    );
  }
}
