import 'package:bookery/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MultiLineTextField extends StatelessWidget {
  final String hintText;

  const MultiLineTextField({
    super.key,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 5,
      decoration: InputDecoration(
        fillColor: lightGreens,
        filled: false,
        hintText: hintText,
        hintStyle: GoogleFonts.zain(
            color: blacks,
            fontSize: 20
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: lightGreens, width: 2)
        ),
        focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: lightGreens, width: 2),
      ),
      ),
    );
  }
}
