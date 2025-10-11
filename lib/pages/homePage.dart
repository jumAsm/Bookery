import 'package:flutter/material.dart';
import 'package:bookery/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/categorySetting.dart';
import '../widgets/recentAddedList.dart';
import '../widgets/recsList.dart';
import 'addBook.dart';
import '../cubits/books_cubit.dart';
import 'BookMarket.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final booksCubit = BlocProvider.of<BooksCubit>(context);
    return BlocBuilder<BooksCubit, BooksState>(
      buildWhen: (previous, current) => true,
      builder: (context, state) {
        final String selectedCategory = booksCubit.currentCategory;

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

        return Scaffold(
          backgroundColor: backGroundClr,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: backGroundClr,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Bookery',
                              style: GoogleFonts.redRose(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: pinks,
                              ),
                            ),
                            const Spacer(),
                            Icon(basketIcon, color: basketColor),
                          ],
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 6,
                            ),
                            hintText: 'Search books...',
                            hintStyle: GoogleFonts.onest(
                              color: blacks,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                            filled: false,
                            fillColor: blacks,
                            prefixIcon: const Icon(Icons.search, size: 18),
                            prefixIconColor: blacks,

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: blacks, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: blacks, width: 2),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        Text(
                          'Geners',
                          style: GoogleFonts.unbounded(
                            fontSize: 14,
                            color: blacks,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 4),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Categorysetting(
                                label: 'Fiction',
                                borderClr: pinks,
                                selected: false,
                                onTap: () {},
                              ),
                              const SizedBox(width: 8),
                              Categorysetting(
                                label: 'Literature',
                                borderClr: blues,
                                selected: false,
                                onTap: () {},
                              ),
                              const SizedBox(width: 8),
                              Categorysetting(
                                label: 'Psychology',
                                borderClr: yellows,
                                selected: false,
                                onTap: () {},
                              ),
                              const SizedBox(width: 8),
                              Categorysetting(
                                label: 'Business',
                                borderClr: greens,
                                selected: false,
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: InkWell(
                      onTap: () {
                        booksCubit.selectCategory('All');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BookMarket(),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            'New on the Market',
                            style: GoogleFonts.unbounded(
                              fontSize: 14,
                              color: blacks,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.keyboard_arrow_right,
                            size: 20,
                            color: blacks,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const recentAddedList(),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Text(
                          'Recommended',
                          style: GoogleFonts.unbounded(
                            fontSize: 14,
                            color: blacks,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.keyboard_arrow_right,
                          size: 20,
                          color: blacks,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 2),
                  StackedRecommendations(),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddBook()),
              );
            },
            backgroundColor: pinks,
            child: const Icon(Icons.add, color: backGroundClr),
          ),
        );
      },
    );
  }
}
