import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bookery/constants/colors.dart';
import '../cubits/books_cubit.dart';
import '../models/BookModel.dart';
import '../widgets/BasketItem.dart';
import 'homePage.dart';

class BasketPage extends StatelessWidget {
  const BasketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BooksCubit, BooksState>(
      builder: (context, state) {
        if (state is BooksLoading) {
          return const Scaffold(
            backgroundColor: backGroundClr,
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is BooksSuccess) {
          final List<BookModel> basketItems = state.allBooks
              .where((book) => book.isInBasket == true)
              .toList();

          final totalItems = basketItems.length;
          final totalPrice = basketItems.fold<int>(
            0,
            (sum, item) => sum + (item.price ?? 0),
          );

          return Scaffold(
            backgroundColor: backGroundClr,
            appBar: AppBar(
              backgroundColor: backGroundClr,
              elevation: 0,
              title: Text(
                'Basket',
                style: GoogleFonts.unbounded(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: blacks,
                ),
              ),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(
                  Icons.keyboard_arrow_left,
                  color: blacks,
                  size: 22,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: totalItems == 0
                ? Center(
                    child: Text(
                      'Your basket is empty!',
                      style: GoogleFonts.onest(fontSize: 16, color: blacks),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: totalItems,
                    itemBuilder: (context, index) {
                      final book = basketItems[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: BasketItem(book: book),
                      );
                    },
                  ),

            bottomNavigationBar: totalItems > 0
                ? Container(
                    decoration: const BoxDecoration(color: backGroundClr),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 25,
                          right: 25,
                          top: 5,
                          bottom: 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total Price:',
                                  style: GoogleFonts.unbounded(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: blacks,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${totalPrice},00 SR',
                                  style: GoogleFonts.unbounded(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: priceGr,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: SizedBox(
                                width: 160,
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: () {
                                    for (var book in basketItems) {
                                      book.isInBasket = false;
                                      book.isOwned = true;
                                      book.createdAt = DateTime.now()
                                          .toIso8601String();
                                      book.save();
                                    }
                                    BlocProvider.of<BooksCubit>(
                                      context,
                                    ).fetchAllBooks();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Successfully purchased ${totalItems} books! You can now read them in your profile.',
                                              style: GoogleFonts.onest(),
                                            ),
                                            duration: const Duration(
                                              milliseconds: 250,
                                            ),
                                          ),
                                        )
                                        .closed
                                        .then((reason) {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const Homepage(
                                                    initialIndex: 3,
                                                  ),
                                            ),
                                          );
                                        });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: pinks,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                  ),
                                  child: Text(
                                    'Checkout',
                                    style: GoogleFonts.unbounded(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: backGroundClr,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : null,
          );
        }
        return const Center(child: Text("Error loading basket."));
      },
    );
  }
}
