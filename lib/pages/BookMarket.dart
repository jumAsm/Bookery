import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bookery/constants/colors.dart';
import '../cubits/books_cubit.dart';
import '../models/BookModel.dart';
import '../widgets/bookItemMarket.dart';
import '../widgets/categorySetting.dart';

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
      'Business',
      'Literature',
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
        if (state is BooksLoading) {
          return const Scaffold(
            backgroundColor: backGroundClr,
            body: Center(child: CircularProgressIndicator()),
          );
        }
        List<BookModel> displayedBooks = [];
        if (state is BooksSuccess) {
          if (booksCubit.currentCategory == 'All') {
            displayedBooks = state.allBooks;
          } else {
            displayedBooks = state.allBooks
                .where((book) => book.category == booksCubit.currentCategory)
                .toList();
          }
        }

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
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_sharp,
                          size: 22,
                          color: blacks,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Spacer(flex: 1),
                      Text(
                        'Book Market',
                        style: GoogleFonts.unbounded(
                          fontSize: 18,
                          color: pinks,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(flex: 2),
                    ],
                  ),
                ),

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
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 0.58,
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