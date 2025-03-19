import 'package:flutter/material.dart';

class TextFormDeco extends StatelessWidget {
  TextFormDeco(
      {required this.lableText,
      required this.hintText,
      // required this.validator,
      required this.icons,
      required this.inputType,
      required this.validator,
      required,
      required this.onSave});

  // const TextFormDeco(
  //   this.lableText,
  //   this.hintText,
  //   this.icons,
  //   this.inputType,
  //   this.validator
  // );

  final String? lableText;
  final String? hintText;
  // final FormFieldValidator<String> validator;
  final Icon icons;
  final TextInputType inputType;
  final String? Function(String?)?
      validator; // Validation function as an argument
  final String? Function(String) onSave;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: inputType,
      validator: validator,
      decoration: InputDecoration(
          prefixIcon: icons,
          hintText: hintText,
          label: Text(lableText!),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          )),
    );
  }
}
