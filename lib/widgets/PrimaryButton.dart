import 'package:bookery/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryButton extends StatelessWidget {
  final String btnName;
  final Function ontap;

  const PrimaryButton({super.key, required this.btnName, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => ontap(),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(blues),
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 2)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      child: Text(
        btnName,
        style: GoogleFonts.unbounded(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: backGroundClr,
        ),
      ),
    );
  }
}
