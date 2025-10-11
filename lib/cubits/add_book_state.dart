part of 'add_book_cubit.dart';

abstract class AddBookState {}

class AddBookInitial extends AddBookState {}

class AddBookLoading extends AddBookState {}

class AddBookSuccess extends AddBookState {}

class AddBookFailure extends AddBookState {
  final String errorMessage;
  AddBookFailure(this.errorMessage);
}
