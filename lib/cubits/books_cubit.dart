import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/BookModel.dart';
import '../../models/BookModel.dart';
part 'books_state.dart';

const String kBookBox = 'books_for_sale_box';

class BooksCubit extends Cubit<BooksState> {
  String currentCategory = 'All';

  BooksCubit() : super(BooksInitial()) {
    fetchAllBooks();
  }

  void fetchAllBooks() async {
    emit(BooksLoading());
    try {
      var booksBox = Hive.box<BookModel>(kBookBox);
      List<BookModel> books = booksBox.values.toList().reversed.toList();
      emit(BooksSuccess(books));
    } catch (e) {
      emit(BooksFailure(e.toString()));
    }
  }

  void selectCategory(String category) {
    currentCategory = category;
    if (state is BooksSuccess) {
      emit(BooksSuccess((state as BooksSuccess).allBooks));
    } else {
      emit(BooksInitial());
    }
  }

  void toggleFavoriteStatus(BookModel book) {
    book.isFavorite = !(book.isFavorite ?? false);
    book.save();
    if (state is BooksSuccess) {
      emit(BooksSuccess((state as BooksSuccess).allBooks));
    } else {
      fetchAllBooks();
    }
  }
}