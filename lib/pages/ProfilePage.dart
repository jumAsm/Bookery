import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:bookery/constants/colors.dart';
import '../cubits/books_cubit.dart';
import '../models/BookModel.dart';
import 'bookDetails.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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

  Widget _buildProfileBookCard(BuildContext context, BookModel book, {bool showPrice = true}) {
    const double cardWidth = 108;
    const double coverHeight = 160;

    final bool isArabic = book.language == 'Arabic';
    final crossAlignment = isArabic
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;
    final textAlignment = isArabic ? TextAlign.right : TextAlign.left;

    final ImageProvider<Object> imageProvider = _getImageProvider(
      book.coverUrl,
    );

    final String priceText = showPrice ? '${book.price ?? 0},00 SR' : '';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: cardWidth,
        child: Column(
          crossAxisAlignment: crossAlignment,
          children: [
            Container(
              width: cardWidth,
              height: coverHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: crossAlignment,
              children: [
                Text(
                  book.title ?? 'No Title',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: textAlignment,
                  style: GoogleFonts.onest(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: blacks,
                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Text(
                        priceText,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.onest(
                          fontSize: 11,
                          color: priceGr,
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
          ],
        ),
      ),
    );
  }

  Widget _buildBookSection(
      BuildContext context, {
        required String title,
        required List<BookModel> books,
        required String emptyMessage,
        required IconData icon,
        bool showPriceInCards = true,
        bool isOwnedSection = false,
      }) {
    const double newListViewHeight = 212;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: 8,
          ),
          child: Row(
            children: [
              Icon(icon, color: pinks, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.unbounded(
                  fontSize: 16,
                  color: blacks,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        if (books.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              emptyMessage,
              style: GoogleFonts.onest(
                fontSize: 14,
                color: blacks.withOpacity(0.7),
              ),
            ),
          )
        else
          SizedBox(
            height: newListViewHeight,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetails(
                            book: book,
                            isOwned: isOwnedSection,
                          ),
                        ),
                      );
                    },
                    child: _buildProfileBookCard(
                      context,
                      book,
                      showPrice: showPriceInCards,
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundClr,
      appBar: AppBar(
        backgroundColor: backGroundClr,
        elevation: 0,
        title: Text(
          'Personal Library',
          style: GoogleFonts.redRose(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: pinks,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<BooksCubit, BooksState>(
          builder: (context, state) {
            List<BookModel> allBooks = [];
            if (state is BooksSuccess) {
              allBooks = state.allBooks;
            }

            final List<BookModel> ownedBooks = allBooks
                .where((book) => book.isOwned == true)
                .toList();

            final List<BookModel> bookmarkedBooks = allBooks
                .where((book) => book.isBookmarked == true)
                .toList();

            final List<BookModel> favoriteBooks = allBooks
                .where((book) => book.isFavorite == true)
                .toList();

            final List<BookModel> onSaleBooks = allBooks
                .where((book) => book.isOnSale == true)
                .toList();

            return SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 70),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBookSection(
                    context,
                    title: 'Your Books',
                    books: ownedBooks,
                    emptyMessage:
                    'You haven\'t purchased any books yet. Books you buy will appear here to read.',
                    icon: Icons.menu_book_rounded,
                    showPriceInCards: false,
                    isOwnedSection: true,
                  ),
                  const Divider(
                    color: blacks,
                    height: 30,
                    thickness: 0.5,
                    indent: 16,
                    endIndent: 16,
                  ),
                  _buildBookSection(
                    context,
                    title: 'Bookmarks',
                    books: bookmarkedBooks,
                    emptyMessage: 'You haven\'t bookmarked any books yet.',
                    icon: Icons.bookmark_rounded,
                    showPriceInCards: true,
                  ),
                  const Divider(
                    color: blacks,
                    height: 30,
                    thickness: 0.5,
                    indent: 16,
                    endIndent: 16,
                  ),
                  _buildBookSection(
                    context,
                    title: 'Favorites',
                    books: favoriteBooks,
                    emptyMessage:
                    'You haven\'t added any books to favorites yet. Books you like will appear here.',
                    icon: Icons.favorite_rounded,
                    showPriceInCards: false,
                  ),
                  const Divider(
                    color: blacks,
                    height: 30,
                    thickness: 0.5,
                    indent: 16,
                    endIndent: 16,
                  ),
                  _buildBookSection(
                    context,
                    title: 'Books on sale',
                    books: onSaleBooks,
                    emptyMessage: 'You haven\'t listed any books for sale.',
                    icon: Icons.sell_rounded,
                    showPriceInCards: true,
                  ),
                  const Divider(
                    color: blacks,
                    height: 30,
                    thickness: 0.5,
                    indent: 16,
                    endIndent: 16,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}