import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bookery/constants/colors.dart';
import '../cubits/books_cubit.dart';
import '../models/BookModel.dart';
import '../widgets/bookItemMarket.dart';
import '../widgets/categorySetting.dart';
import 'BasketPage.dart';

class BookMarket extends StatelessWidget {
  const BookMarket({super.key});

  @override
  Widget build(BuildContext context) {
    final booksCubit = BlocProvider.of<BooksCubit>(context);
    final List<String> categories = [
      'All',
      'Fiction',
      'Literature',
      'Psychology',
      'Art',
      'Poetry',
      'Biography',
      'History',
    ];
    final List<Color> categoryColors = [
      blacks,
      pinks,
      blues,
      yellows,
      greens,
      pinks,
    ];

    return BlocBuilder<BooksCubit, BooksState>(
      builder: (context, state) {
        List<BookModel> marketBooks = [];
        if (state is BooksSuccess) {
          marketBooks = state.allBooks
              .where((book) => book.isOwned == false)
              .toList();
        }

        List<BookModel> displayedBooks = [];
        if (state is BooksSuccess) {
          if (booksCubit.currentCategory == 'All') {
            displayedBooks = marketBooks;
          } else {
            displayedBooks = marketBooks
                .where((book) => book.category == booksCubit.currentCategory)
                .toList();
          }
        }

        bool isBasketNotEmpty = false;
        if (state is BooksSuccess) {
          isBasketNotEmpty = state.allBooks.any(
                (book) => book.isInBasket == true,
          );
        }
        final IconData basketIcon = isBasketNotEmpty
            ? Icons.shopping_bag_rounded
            : Icons.shopping_bag_outlined;

        final Color basketColor = isBasketNotEmpty ? pinks : blacks;

        final selectedCategory = booksCubit.currentCategory;

        return Scaffold(
          backgroundColor: backGroundClr,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      const Spacer(flex: 2),
                      Text(
                        'Book Market',
                        style: GoogleFonts.redRose(
                          fontSize: 22,
                          color: blacks,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(flex: 1),
                      IconButton(
                        icon: Icon(basketIcon, color: basketColor),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BasketPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Row(
                    children: categories.asMap().entries.map((entry) {
                      final index = entry.key;
                      final category = entry.value;
                      final Color borderClr =
                      categoryColors[index % categoryColors.length];
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Categorysetting(
                          label: category,
                          borderClr: borderClr,
                          selected: selectedCategory == category,
                          onTap: () => booksCubit.selectCategory(category),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: (state is BooksSuccess && displayedBooks.isEmpty)
                      ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "No books found in this category.",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.onest(
                              fontSize: 14,
                              color: blacks,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                      : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GridView.builder(
                      padding: const EdgeInsets.only(bottom: 70),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.53,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: displayedBooks.length,
                      itemBuilder: (context, index) {
                        final book = displayedBooks[index];
                        return bookItemMarket(book: book);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}