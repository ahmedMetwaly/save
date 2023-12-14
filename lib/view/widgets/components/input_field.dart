import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.withMaxLines,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final String hint;
  final bool withMaxLines;

  @override
  Widget build(BuildContext context) {
    final outLineInputBorderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: Theme.of(context).primaryColor),
    );

    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.multiline,
      style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 20),
      minLines: 1,
      maxLines: withMaxLines ? 25 : 1,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter a $label";
        } else if (value.contains("[") ||
            value.contains("]") ||
            value.contains("{") ||
            value.contains("}") ||
            value.contains(",") ||
            value.contains(";") 
       ) {
          return "Please enter an input\nwithout special character";
        }
        return null;
      },
      decoration: InputDecoration(
        label: Text(label),
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).primaryColor.withOpacity(0.5),
              fontSize: 18,
            ),
        labelStyle:
            Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20),
        errorStyle: TextStyle(color: Theme.of(context).primaryColor),
        contentPadding: const EdgeInsets.all(10),
        errorBorder: outLineInputBorderStyle,
        focusedErrorBorder: outLineInputBorderStyle,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Theme.of(context).indicatorColor),
        ),
        focusedBorder: outLineInputBorderStyle,
        border: outLineInputBorderStyle,
      ),
    );
  }
}
