import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class recsList extends StatelessWidget {
  const recsList({super.key});

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          recs(
            title: 'عداء الطائرة الورقية',
            author: 'خالد حسيني',
            coverUrl:
                'https://i.pinimg.com/736x/c8/24/3a/c8243a6cbde58d4c2aa0465e08e26c7a.jpg',
            price: '60,00 SAR',
          ),
          SizedBox(height: 12),
          recs(
            title: 'The Laws of Human Nature',
            author: 'Robert Greene',
            coverUrl:
                'https://i.pinimg.com/736x/1f/ed/83/1fed83beca4ae44a58361c0964b5021c.jpg',
            price: '71,00 SAR',
          ),
          SizedBox(height: 12),
          recs(
            title: 'كافكا على الشاطئ',
            author: 'هاروكي موراكامي',
            coverUrl:
                'https://i.pinimg.com/736x/32/30/47/32304772b1a4c68be65f05e71b95b9ce.jpg',
            price: '51,00 SAR',
          ),
        ],
      ),
    );
  }
}

class recs extends StatelessWidget {
  final String title;
  final String author;
  final String coverUrl;
  final String price;

  const recs({
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              coverUrl,
              width: 64,
              height: 86,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.onest(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  author,
                  style: GoogleFonts.onest(
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green[600],
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
