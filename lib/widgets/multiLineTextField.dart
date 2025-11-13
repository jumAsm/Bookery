import 'package:bookery/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MultiLineTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final void Function(String? value)? onSaved;
  final String? initialValue;

  const MultiLineTextField({
    super.key,
    required this.hintText,
    required this.icon,
    this.onSaved,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onSaved: onSaved,
      style: GoogleFonts.onest(
        color: blues,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      minLines: 1,
      maxLines: null,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        fillColor: lightGreens,
        filled: false,
        hintText: hintText,
        hintStyle: GoogleFonts.onest(
          color: blacks,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: Icon(icon, color: blacks, size: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: blacks, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: blacks, width: 1.5),
        ),
      ),
    );
  }
}
