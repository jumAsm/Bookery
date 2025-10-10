import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/books_cubit.dart';
//import '../cubits/books_state.dart';
import '../models/BookModel.dart';

class recsList extends StatelessWidget {
  const recsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BooksCubit, BooksState>(
      builder: (context, state) {
        if (state is BooksLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is BooksSuccess) {
          if (state.allBooks.isEmpty) {
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

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: state.allBooks.map((book) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: recs(
                    title: book.title ?? 'No Title',
                    author: book.author ?? 'No Author',
                    coverUrl:
                        book.coverUrl ?? 'https://via.placeholder.com/64x86',
                    price: '${book.price ?? 0},00 SAR',
                  ),
                );
              }).toList(),
            ),
          );
        }

        return const Center(child: Text("Error loading recommended books."));
      },
    );
  }
}

class recs extends StatelessWidget {
  final String title;
  final String author;
  final String coverUrl;
  final String price;

  const recs({
    super.key,
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
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: TextStyle(fontSize: 12, color: Colors.green[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
