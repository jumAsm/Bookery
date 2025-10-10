import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:bookery/constants/colors.dart';

class BookItem extends StatelessWidget {
  final String title;
  final String author;
  final String coverUrl;
  final String price;
  final String language;

  const BookItem({
    super.key,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.price,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    final bool isArabic = language == 'Arabic';
    final crossAlignment = isArabic
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;
    final textAlignment = isArabic ? TextAlign.right : TextAlign.left;

    final ImageProvider<Object> imageProvider =
        coverUrl.startsWith('http') || coverUrl.startsWith('https')
        ? NetworkImage(coverUrl)
        : FileImage(File(coverUrl));

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: 120,
        child: Column(
          crossAxisAlignment: crossAlignment,
          children: [
            Container(
              width: 120,
              height: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),

            const SizedBox(height: 8),

            SizedBox(
              height: 55,
              child: Column(
                crossAxisAlignment: crossAlignment,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: textAlignment,
                    style: GoogleFonts.onest(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Text(
                          price,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 11,
                            color: greens,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Icon(Icons.more_horiz_rounded, size: 14, color: blacks),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
