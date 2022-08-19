import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveTextField extends StatelessWidget {
  final String? labelText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final void Function(String)? onSubmitted;

  const AdaptiveTextField({
    Key? key,
    this.labelText,
    this.keyboardType,
    this.controller,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CupertinoTextField(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 12,
              ),
              controller: controller,
              keyboardType: keyboardType,
              placeholder: labelText,
              onSubmitted: onSubmitted,
            ),
          )
        : TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              labelText: labelText,
            ),
            onSubmitted: onSubmitted,
          );
  }
}
