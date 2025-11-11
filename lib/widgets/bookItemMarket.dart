import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';
import '../models/BookModel.dart';
import '../pages/bookDetails.dart';

class bookItemMarket extends StatelessWidget {
  final BookModel book;

  const bookItemMarket({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final bool isArabic = book.language == 'Arabic';
    final crossAlignment = isArabic
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;
    final textAlignment = isArabic ? TextAlign.right : TextAlign.left;
    final ImageProvider<Object> imageProvider =
        book.coverUrl != null &&
            (book.coverUrl!.startsWith('http') ||
                book.coverUrl!.startsWith('https'))
        ? NetworkImage(book.coverUrl!)
        : FileImage(File(book.coverUrl!)) as ImageProvider<Object>;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookDetails(book: book)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: crossAlignment,
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 3),
            Text(
              book.title ?? 'No Title',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: textAlignment,
              style: GoogleFonts.unbounded(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                color: blacks,
              ),
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                textAlign: TextAlign.left,
                '${book.price ?? 0},00 SAR',
                style: GoogleFonts.onest(
                  fontSize: 9,
                  color: priceGr,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
