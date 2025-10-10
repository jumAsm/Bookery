part of 'books_cubit.dart';

abstract class BooksState {}

class BooksInitial extends BooksState {}

class BooksLoading extends BooksState {}

class BooksSuccess extends BooksState {
  final List<BookModel> allBooks;
  BooksSuccess(this.allBooks);
}

class BooksFailure extends BooksState {
  final String errorMessage;
  BooksFailure(this.errorMessage);
}
