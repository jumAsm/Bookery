import 'package:bookery/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormFieldSet extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool isNumber;
  final void Function(String? value)? onSaved;
  final String? Function(String? value)? validator;

  const TextFormFieldSet({
    super.key,
    required this.hintText,
    required this.icon,
    this.isNumber = false,
    this.onSaved,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      validator: validator,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      style: GoogleFonts.onest(
        color: pinks,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        fillColor: blacks,
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
