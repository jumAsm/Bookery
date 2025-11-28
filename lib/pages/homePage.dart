import 'package:flutter/material.dart';
import 'package:bookery/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/categorySetting.dart';
import '../widgets/recentAddedList.dart';
import '../widgets/recsList.dart';
import 'BasketPage.dart';
import 'addBook.dart';
import 'ProfilePage.dart';
import '../cubits/books_cubit.dart';
import '../models/BookModel.dart';
import 'BookMarket.dart';
import '../widgets/AnimatedBar.dart';
import 'bookDetails.dart';

class Homepage extends StatefulWidget {
  final int initialIndex;
  const Homepage({super.key, this.initialIndex = 0});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late int _currentIndex;
  final List<IconModel> _navIcons = [
    IconModel(id: 0, icon: Icons.home_filled),
    IconModel(id: 1, icon: Icons.add),
    IconModel(id: 2, icon: Icons.shopping_basket_outlined),
    IconModel(id: 3, icon: Icons.person_outline),
  ];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    BlocProvider.of<BooksCubit>(context).fetchAllBooks();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AddBook()),
      ).then((_) {
        BlocProvider.of<BooksCubit>(context).fetchAllBooks();
      });
    } else {
      setState(() {
        _currentIndex = index;
        if (index == 2) {
          BlocProvider.of<BooksCubit>(context).selectCategory('All');
        } else {
          BlocProvider.of<BooksCubit>(context).selectCategory('All');
        }
      });
    }
  }

  Widget _getPageBody(BooksCubit booksCubit) {
    if (_currentIndex == 2) {
      return const BookMarket();
    }
    if (_currentIndex == 3) {
      return const ProfilePage();
    }

    return BlocBuilder<BooksCubit, BooksState>(
      buildWhen: (previous, current) => true,
      builder: (context, state) {
        bool isBasketNotEmpty = false;
        List<BookModel> searchResults = [];
        final bool isSearching = booksCubit.currentSearchQuery.isNotEmpty;

        if (state is BooksSuccess) {
          isBasketNotEmpty = state.allBooks.any(
                (book) => book.isInBasket == true,
          );

          if (isSearching) {
            final query = booksCubit.currentSearchQuery;
            searchResults = state.allBooks.where((book) {
              return (book.title?.toLowerCase().contains(query) ?? false) ||
                  (book.author?.toLowerCase().contains(query) ?? false) ||
                  (book.category?.toLowerCase().contains(query) ?? false);
            }).toList();
          }
        }

        final IconData basketIcon = isBasketNotEmpty
            ? Icons.shopping_bag_rounded
            : Icons.shopping_bag_outlined;

        final Color basketColor = isBasketNotEmpty ? pinks : blacks;

        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
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
                      const SizedBox(height: 8),
                      TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          booksCubit.setSearchQuery(value);
                        },
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
                          suffixIcon: isSearching
                              ? IconButton(
                            icon: const Icon(Icons.clear, size: 18),
                            onPressed: () {
                              _searchController.clear();
                              booksCubit.setSearchQuery('');
                            },
                          )
                              : null,
                        ),
                      ),
                      const SizedBox(height: 20),

                      if (!isSearching) ...[
                        Text(
                          'Geners',
                          style: GoogleFonts.unbounded(
                            fontSize: 14,
                            color: blacks,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                      ],
                    ],
                  ),
                ),

                if (!isSearching)
                  Container(
                    color: backGroundClr,
                    padding: const EdgeInsets.only(bottom: 16),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
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
                              label: 'Art',
                              borderClr: greens,
                              selected: false,
                              onTap: () {},
                            ),
                            const SizedBox(width: 8),
                            Categorysetting(
                              label: 'Poetry',
                              borderClr: pinks,
                              selected: false,
                              onTap: () {},
                            ),
                            const SizedBox(width: 8),
                            Categorysetting(
                              label: 'Biography',
                              borderClr: blues,
                              selected: false,
                              onTap: () {},
                            ),
                            const SizedBox(width: 8),
                            Categorysetting(
                              label: 'History',
                              borderClr: yellows,
                              selected: false,
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 2),

                if (isSearching)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Search Results for "${booksCubit.currentSearchQuery}"',
                          style: GoogleFonts.unbounded(
                            fontSize: 14,
                            color: blacks,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (searchResults.isEmpty)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(50.0),
                              child: Text(
                                "No books found matching your search.",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.onest(
                                  fontSize: 14,
                                  color: blacks,
                                ),
                              ),
                            ),
                          )
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: searchResults.length,
                            itemBuilder: (context, index) {
                              final book = searchResults[index];
                              return ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookDetails(book: book),
                                    ),
                                  );
                                },
                                title: Text(book.title ?? 'No Title'),
                                subtitle: Text(book.author ?? 'No Author'),
                              );
                            },
                          ),
                      ],
                    ),
                  )
                else
                  ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: InkWell(
                        onTap: () {
                          booksCubit.selectCategory('All');
                          setState(() {
                            _currentIndex = 2;
                          });
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
                            'You May Like',
                            style: GoogleFonts.unbounded(
                              fontSize: 14,
                              color: blacks,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                    const StackedRecommendations(),
                  ],
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final booksCubit = BlocProvider.of<BooksCubit>(context);
    final bool shouldShowBar =
    (_currentIndex == 0 || _currentIndex == 2 || _currentIndex == 3);

    return Scaffold(
      backgroundColor: backGroundClr,
      body: _getPageBody(booksCubit),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: shouldShowBar
          ? AnimatedBar(
        currentIcon: _currentIndex,
        icons: _navIcons,
        onTabTap: _onTabTapped,
      )
          : null,
    );
  }
}