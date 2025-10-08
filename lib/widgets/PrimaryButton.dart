import 'package:bookery/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryButton extends StatelessWidget {
  final String btnName;
  final Function ontap;

  const PrimaryButton({
    super.key,
    required this.btnName,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => ontap(),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(pinks),
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical:2)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        )),
      ),
      child: Text(
        btnName,
        style: GoogleFonts.unbounded(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}
