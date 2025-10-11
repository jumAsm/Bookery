import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
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

  List<BookModel> getRecommendedBooks() {
    if (state is! BooksSuccess) {
      return [];
    }
    List<BookModel> allBooks = (state as BooksSuccess).allBooks;

    List<BookModel> originalOrder = allBooks.take(4).toList();

    if (originalOrder.length >= 4) {
      BookModel B0 = originalOrder[0];
      BookModel B1 = originalOrder[1];
      BookModel B2 = originalOrder[2];

      return [B1, B2, B0];
    }

    return originalOrder;
  }

  void selectCategory(String category) {
    currentCategory = category;
    if (state is BooksSuccess) {
      emit(BooksSuccess((state as BooksSuccess).allBooks));
    } else {
      emit(BooksInitial());
    }
  }
}
