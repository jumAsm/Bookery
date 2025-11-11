import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/books_cubit.dart';
import '../models/BookModel.dart';
import '../pages/bookDetails.dart';
import 'BookItem.dart';

class recentAddedList extends StatelessWidget {
  const recentAddedList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BooksCubit, BooksState>(
      builder: (context, state) {
        if (state is BooksLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is BooksSuccess) {
          final List<BookModel> marketBooks = state.allBooks
              .where((book) => book.isOwned == false)
              .toList();

          if (marketBooks.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: Text("No Recent Books Added")),
            );
          }
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: marketBooks.map((book) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetails(book: book),
                        ),
                      );
                    },
                    child: BookItem(
                      book: book,
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }

        return const Center(child: Text("Error loading recently added books."));
      },
    );
  }
}