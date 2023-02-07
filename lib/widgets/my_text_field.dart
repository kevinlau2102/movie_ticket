import 'package:flutter/material.dart';

import '../constants.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    required this.hintText,
    required this.inputType,
    required this.textController,
  }) : super(key: key);
  final String hintText;
  final TextInputType inputType;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: textController,
        style: kBodyText.copyWith(color: Colors.white),
        keyboardType: inputType,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20),
          hintText: hintText,
          hintStyle: kBodyText,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}
