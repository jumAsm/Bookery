import 'package:flutter/material.dart';
import 'package:bookery/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class Categorysetting extends StatelessWidget {
  final String label;
  final Color borderClr;
  final bool selected;
  final VoidCallback onTap;

  const Categorysetting({
    super.key,
    required this.label,
    this.borderClr = pinks,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 35,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: borderClr,
            width: 2.2,
          ),
          color: selected ? borderClr : backGroundClr,
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.onest(
              color: selected ? backGroundClr : blacks,
              fontSize: 17,
              fontWeight:  FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
