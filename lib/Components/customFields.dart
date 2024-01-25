import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String labelText;
  final bool isPassword;
  final IconData iconData;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;

  const CustomInputField({super.key, required this.labelText, this.isPassword = false, required this.iconData, this.validator, this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: TextFormField(
          controller: controller,
          validator: validator,
          obscureText: isPassword,
          autofocus: false,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 13),
              labelText: labelText,
              labelStyle: TextStyle(color: Colors.grey[600], fontSize: 13.0, letterSpacing: 1),
              prefixIcon: Icon(
                iconData,
                color: Colors.blue.shade800,
                size: 20,
              ),

              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue.shade800, width: 1.5),
                  borderRadius: BorderRadius.circular(7)
              ),

              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue.shade800, width: 1.0),
                  borderRadius: BorderRadius.circular(5)
              ),

            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red.shade800, width: 1.0),
                borderRadius: BorderRadius.circular(5),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red.shade800, width: 1.0),
              borderRadius: BorderRadius.circular(5),
            )
          ),
        ),
      ),
    );
  }
}
