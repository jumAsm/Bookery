import 'package:bookery/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool isNumber;

  const MyTextFormField({
    super.key,
    required this.hintText,
    required this.icon,
    this.isNumber = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        fillColor: lightGreens,
        filled: false,
        hintText: hintText,
        hintStyle: GoogleFonts.zain(
          color: blacks,
          fontSize: 20
        ),
        prefixIcon: Icon(icon, color: darkGreens),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: lightGreens, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: lightGreens, width: 2),
        ),
      ),
    );
  }
}
