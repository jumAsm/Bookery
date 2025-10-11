// lib/widgets/BasketItem.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import '../constants/colors.dart';
import '../models/BookModel.dart';
import '../cubits/books_cubit.dart';

class BasketItem extends StatelessWidget {
  final BookModel book;

  const BasketItem({super.key, required this.book});
  void _removeFromBasket(BuildContext context) {
    book.isInBasket = false;
    book.save();
    BlocProvider.of<BooksCubit>(context).fetchAllBooks();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Book "${book.title}" removed from basket!',
          style: GoogleFonts.onest(),
        ),
        duration: const Duration(milliseconds: 1000),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isArabic = book.language == 'Arabic';


    final ImageProvider<Object> imageProvider =
    book.coverUrl != null &&
        (book.coverUrl!.startsWith('http') ||
            book.coverUrl!.startsWith('https'))
        ? NetworkImage(book.coverUrl!)
        : FileImage(File(book.coverUrl!)) as ImageProvider<Object>;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 70,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        book.title ?? 'No Title',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.unbounded(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: blacks,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => _removeFromBasket(context),
                      child: Icon(Icons.delete_outline_rounded, size: 18, color: blacks),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'By ${book.author ?? 'No Author'}',
                  style: GoogleFonts.onest(
                    fontSize: 12,
                    color: blacks.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 37),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < (double.tryParse(book.rating ?? '0.0') ?? 0).round()
                              ? Icons.star
                              : Icons.star_border,
                          color: stars,
                          size: 16,
                        );
                      }),
                    ),

                    Text(
                      '${book.price ?? 0},00 SR',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.unbounded(
                        fontSize: 12,
                        color: priceGr,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}