import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  final String buttonText;
  final Gradient? gradient;
  final Border? border;
  final Color textColor;
  final VoidCallback onTap;


  const CustomButton({super.key, required this.buttonText, this.gradient, this.border, required this.textColor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 40.0),
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(5),
            border: border
        ),
        child: Center(
          child: Text(buttonText,
            style: TextStyle(color: textColor, fontSize: 15.0, fontWeight: FontWeight.bold, letterSpacing: 2),),
        ),
      ),
    );;
  }
}
