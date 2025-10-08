import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookItem extends StatelessWidget {
  final String title;
  final String author;
  final String coverUrl;
  final String price;

  const BookItem({
    super.key,
    required this.title,
    required this.author,
    required this.coverUrl,
     required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 140,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(coverUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style:  GoogleFonts.onest(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            'by $author',
            style: GoogleFonts.onest(
              fontSize: 12,
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 4),
          Text(
            price,
            style: TextStyle(
              fontSize: 14,
              color: Colors.green[600],
            ),
          ),
        ],
      ),
    );
  }
}
