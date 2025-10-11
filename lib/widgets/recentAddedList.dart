import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/books_cubit.dart';
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
          if (state.allBooks.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: Text("No Recent Books Added")),
            );
          }
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: state.allBooks.map((book) {
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
                      title: book.title ?? 'No Title',
                      author: book.author ?? 'No Author',
                      coverUrl:
                          book.coverUrl ??
                          'https://via.placeholder.com/140x180',
                      price: '${book.price ?? 0},00 SAR',
                      language: book.language ?? 'English',
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
