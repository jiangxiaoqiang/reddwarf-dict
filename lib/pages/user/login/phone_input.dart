import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:reddwarf_dict/themes/global_style.dart';
import 'package:wheel/wheel.dart';

import 'login_controller.dart';

class PhoneInput extends StatelessWidget {
  const PhoneInput({
    Key key,
    this.controller,
    this.selectedRegion,
    this.onPrefixTap,
    this.onDone,
  }) : super(key: key);

  final TextEditingController controller;

  final RegionFlag selectedRegion;

  final VoidCallback onPrefixTap;

  final VoidCallback onDone;

  Color _textColor(BuildContext context) {
    if (controller.text.isEmpty) {
      return Theme.of(context).disabledColor;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyText2.copyWith(
      fontSize: 16,
      color: _textColor(context),
    );
    return TextField(
      autofocus: true,
      style: style,
      controller: controller,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      onSubmitted: (text) => onDone(),
      decoration: InputDecoration(
        prefix: InkWell(
          onTap: onPrefixTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              "${selectedRegion.emoji} ${selectedRegion.dialCode}",
              style: style,
            ),
          ),
        ),
      ),
    );
  }
}
