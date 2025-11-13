import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bookery/constants/colors.dart';
import '../models/BookModel.dart';
import 'dart:io';

class BookItem extends StatelessWidget {
  final BookModel book;
  const BookItem({super.key, required this.book});

  ImageProvider<Object> _getImageProvider(String? coverUrl) {
    if (coverUrl == null || coverUrl.isEmpty) {
      return const AssetImage('assets/placeholder.png');
    }

    if (coverUrl.startsWith('http') || coverUrl.startsWith('https')) {
      return NetworkImage(coverUrl);
    } else {
      return FileImage(File(coverUrl));
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isArabic = book.language == 'Arabic';
    final crossAlignment = isArabic
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;
    final textAlignment = isArabic ? TextAlign.right : TextAlign.left;

    final ImageProvider<Object> imageProvider = _getImageProvider(
      book.coverUrl,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: 120,
        child: Column(
          crossAxisAlignment: crossAlignment,
          children: [
            Stack(
              children: [
                Container(
                  width: 120,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 55,
              child: Column(
                crossAxisAlignment: crossAlignment,
                children: [
                  Text(
                    book.title ?? 'No Title',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: textAlignment,
                    style: GoogleFonts.onest(
                      fontSize: 12,
                      fontWeight: isArabic ? FontWeight.bold : FontWeight.w600,
                      color: blacks,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Text(
                          '${book.price ?? 0},00 SAR',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.onest(
                            fontSize: 10,
                            color: priceGr,
                            fontWeight: FontWeight.w600,
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
