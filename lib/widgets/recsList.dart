import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bookery/constants/colors.dart';
import '../models/BookModel.dart';
import 'dart:io';

const double overlapHeight = 40.0;
const double cardHeight = 145.0;

final List<BookModel> fixedRecommendedBooks = [
  BookModel(
    id: "14",
    title: "The Song of Achilles",
    author: "Madeline Miller",
    rating: "4.4",
    coverUrl:
    "https://i.pinimg.com/736x/35/0b/29/350b29b24856ef5d4b3d1b4e01dcf2bf.jpg",
    language: "English",
    pages: 408,
    price: 35,
  ),
  BookModel(
    id: "4",
    title: "كافكا على الشاطئ",
    author: "هاروكي موراكامي",
    rating: "4.6",
    coverUrl:
        "https://i.pinimg.com/736x/32/30/47/32304772b1a4c68be65f05e71b95b9ce.jpg",
    language: "Arabic",
    pages: 615,
    price: 51,
  ),
  BookModel(
    id: "7",
    title: "The Picture of Dorian Gray",
    author: "Oscar Wilde",
    rating: "4.6",
    coverUrl:
    "https://i.pinimg.com/736x/47/9b/9f/479b9fb3af662656dcec039de3c46486.jpg",
    language: "English",
    pages: 254,
    price: 52,
  ),
];

class StackedRecommendations extends StatefulWidget {
  const StackedRecommendations({super.key});

  @override
  State<StackedRecommendations> createState() => _StackedRecommendationsState();
}

class _StackedRecommendationsState extends State<StackedRecommendations> {
  int? _tappedIndex;

  Widget _buildDetailsColumn(BookModel book, Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'By ${book.author ?? 'No Author'}',
          style: GoogleFonts.onest(fontSize: 12, color: textColor),
        ),
        const SizedBox(height: 4),
        Text(
          '${book.price ?? 0},00 SR',
          style: GoogleFonts.onest(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: textColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${book.pages ?? 0} pages',
          style: GoogleFonts.onest(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: textColor,
          ),
        ),

        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(Icons.star, color: stars, size: 16),
            Text(
              ' ${book.rating ?? '0.0'} / 5.0',
              style: GoogleFonts.onest(fontSize: 11, color: textColor),
            ),
          ],
        ),
      ],
    );
  }

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
    final List<Color> cardColors = [blues, yellows, greens];

    final List<BookModel> displayBooks = fixedRecommendedBooks;

    if (displayBooks.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "No recommended books available.",
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    final double totalCards = displayBooks.length.toDouble();
    final double currentStackHeight =
        cardHeight + ((totalCards - 1) * overlapHeight);
    final List<MapEntry<int, BookModel>> orderedEntries = displayBooks
        .asMap()
        .entries
        .toList()
        .reversed
        .toList();
    if (_tappedIndex != null) {
      final entryToMove = orderedEntries.firstWhere(
        (entry) => entry.key == _tappedIndex,
      );

      orderedEntries.removeWhere((entry) => entry.key == _tappedIndex);
      orderedEntries.add(entryToMove);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SizedBox(
        height: currentStackHeight,
        child: Stack(
          children: [
            ...orderedEntries.map((entry) {
              int index = entry.key;
              BookModel book = entry.value;
              final bool isTapped = _tappedIndex == index;
              final double scaleFactor = isTapped ? 1.05 : 1.0;
              final Color cardColor = cardColors[index % cardColors.length];

              final Color textColor = cardColor == yellows
                  ? blacks
                  : backGroundClr;

              final FontWeight titleFontWeight = book.language == 'Arabic'
                  ? FontWeight.bold
                  : FontWeight.w500;

              final double topPosition =
                  (totalCards - 1 - index) * overlapHeight;
              const double currentCardHeight = cardHeight;

              return Positioned(
                top: topPosition,
                left: 0,
                right: 0,
                child: Transform.scale(
                  scale: scaleFactor,
                  child: AnimatedContainer(
                    key: ValueKey(index),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    height: currentCardHeight,
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: isTapped ? 10 : 3,
                          offset: isTapped
                              ? const Offset(0, 5)
                              : const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _tappedIndex = isTapped ? null : index;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              book.title ?? 'No Title',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.unbounded(
                                fontSize: book.language == 'Arabic' ? 16 : 14,
                                fontWeight: titleFontWeight,
                                color: textColor,
                              ),
                            ),
                             SizedBox(height: (book.language == 'Arabic') ? 4 :8),
                            AnimatedOpacity(
                              opacity: isTapped ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 300),
                              child: isTapped
                                  ? SizedBox(
                                      height: 90,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            child: Container(
                                              width: 65,
                                              height: 90,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: _getImageProvider(
                                                    book.coverUrl,
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              child:
                                                  book.coverUrl == null ||
                                                      book.coverUrl!.isEmpty
                                                  ? Center(
                                                      child: Icon(
                                                        Icons.book,
                                                        color: textColor,
                                                      ),
                                                    )
                                                  : null,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: _buildDetailsColumn(
                                              book,
                                              textColor,
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 70,
                                            ),
                                            child: Icon(
                                              Icons.more_horiz_outlined,
                                              color: textColor,
                                              size: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
