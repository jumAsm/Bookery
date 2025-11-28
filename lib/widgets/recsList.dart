import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bookery/constants/colors.dart';
import '../models/BookModel.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/books_cubit.dart';
import '../pages/bookDetails.dart';

const double overlapHeight = 40.0;
const double cardHeight = 145.0;

class StackedRecommendations extends StatefulWidget {
  const StackedRecommendations({super.key});

  @override
  State<StackedRecommendations> createState() => _StackedRecommendationsState();
}

class _StackedRecommendationsState extends State<StackedRecommendations> {
  String? _tappedBookId;

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

  List<BookModel> _getRecommendations(List<BookModel> allBooks) {
    final Map<String, int> ownedCategoryCounts = {};
    for (final book in allBooks) {
      if (book.isOwned == true && book.category != null) {
        ownedCategoryCounts.update(
          book.category!,
              (count) => count + 1,
          ifAbsent: () => 1,
        );
      }
    }

    String? favoriteCategory;
    int maxCount = -1;

    for (final entry in ownedCategoryCounts.entries) {
      if (entry.value > maxCount) {
        maxCount = entry.value;
        favoriteCategory = entry.key;
      }
    }

    List<BookModel> recommendations = [];

    if (favoriteCategory != null) {
      final List<BookModel> preferredRecommendations = allBooks
          .where((book) =>
      book.category == favoriteCategory &&
          (book.isOwned == false) &&
          (book.isOnSale == false))
          .toList();
      preferredRecommendations.sort((a, b) {
        double ratingA = double.tryParse(a.rating ?? '0.0') ?? 0.0;
        double ratingB = double.tryParse(b.rating ?? '0.0') ?? 0.0;
        return ratingB.compareTo(ratingA);
      });

      recommendations.addAll(preferredRecommendations.take(3));
    }

    if (recommendations.length < 3) {
      final List<BookModel> fallbackBooks = allBooks
          .where((book) =>
      (book.isOwned == false) &&
          (book.isOnSale == false) &&
          (book.category != favoriteCategory))
          .toList();

      fallbackBooks.sort((a, b) {
        double ratingA = double.tryParse(a.rating ?? '0.0') ?? 0.0;
        double ratingB = double.tryParse(b.rating ?? '0.0') ?? 0.0;
        return ratingB.compareTo(ratingA);
      });

      final int neededCount = 3 - recommendations.length;
      recommendations.addAll(fallbackBooks.take(neededCount));
    }
    return recommendations.take(3).toList();
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> cardColors = [blues, yellows, greens];

    return BlocBuilder<BooksCubit, BooksState>(
      builder: (context, state) {
        if (state is BooksLoading) {
          return const Center(child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("Loading recommendations..."),
          ));
        }

        if (state is! BooksSuccess) {
          return const SizedBox.shrink();
        }

        final List<BookModel> recommendedBooks = _getRecommendations(state.allBooks);
        final List<BookModel> displayBooks = recommendedBooks;

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
        if (_tappedBookId != null) {
          final int tappedIndex = displayBooks.indexWhere((book) => book.id == _tappedBookId);
          if (tappedIndex != -1) {
            final entryToMoveIndexInReversed = orderedEntries.indexWhere((entry) => entry.key == tappedIndex);
            if(entryToMoveIndexInReversed != -1) {
              final entryToMove = orderedEntries.removeAt(entryToMoveIndexInReversed);
              orderedEntries.add(entryToMove);
            }
          }
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
                  final bool isTapped = book.id == _tappedBookId;

                  final double topPosition = (totalCards - 1 - index) * overlapHeight;
                  final double scaleFactor = isTapped ? 1.05 : 1.0;
                  final Color cardColor = cardColors[index % cardColors.length];

                  final Color textColor = cardColor == yellows
                      ? blacks
                      : backGroundClr;

                  final FontWeight titleFontWeight = book.language == 'Arabic'
                      ? FontWeight.bold
                      : FontWeight.w500;

                  const double currentCardHeight = cardHeight;

                  return Positioned(
                    top: topPosition,
                    left: 0,
                    right: 0,
                    child: Transform.scale(
                      scale: scaleFactor,
                      child: GestureDetector(
                        onDoubleTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookDetails(book: book),
                            ),
                          );
                        },
                        child: AnimatedContainer(
                          key: ValueKey(book.id),
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
                                _tappedBookId = isTapped ? null : book.id;
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
                                  SizedBox(
                                    height: (book.language == 'Arabic') ? 4 : 8,
                                  ),
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
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => BookDetails(book: book),
                                                  ),
                                                );
                                              },
                                              child: Icon(
                                                Icons.more_horiz_outlined,
                                                color: textColor,
                                                size: 18,
                                              ),
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
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        );
      },
    );
  }
}