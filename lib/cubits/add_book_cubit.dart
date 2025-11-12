import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import '../../models/BookModel.dart';
part 'add_book_state.dart';

const String kBookBox = 'books_for_sale_box';

class AddBookCubit extends Cubit<AddBookState> {
  AddBookCubit() : super(AddBookInitial());

  String? title, author, description, rating, language, category;
  String? coverUrl, bookUrl, price;
  String? pages;
  bool? isOnSale = false;
  String? existingId;

  void initializeWithBook(BookModel book) {
    existingId = book.id;
    title = book.title;
    author = book.author;
    description = book.description;
    rating = book.rating;
    language = book.language;
    category = book.category;
    coverUrl = book.coverUrl;
    bookUrl = book.bookurl;
    price = book.price.toString();
    pages = book.pages.toString();
    isOnSale = book.isOnSale;
    emit(AddBookInitial());
  }

  void updateCoverUrl(String? path) {
    coverUrl = path;
    emit(AddBookInitial());
  }

  void updateBookUrl(String? path) {
    bookUrl = path;
    emit(AddBookInitial());
  }

  void updateOnSaleStatus(bool status) {
    isOnSale = status;
    emit(AddBookInitial());
  }

  void pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      coverUrl = image.path;
      emit(AddBookInitial());
    }
  }

  void pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      bookUrl = result.files.single.path;
      emit(AddBookInitial());
    }
  }

  void saveBook({BookModel? existingBook}) async {
    emit(AddBookLoading());
    try {
      var box = Hive.box<BookModel>(kBookBox);

      if (existingBook != null && existingBook.key != null) {
        existingBook.title = title;
        existingBook.author = author;
        existingBook.description = description;
        existingBook.category = category;
        existingBook.pages = int.tryParse(pages ?? '0') ?? 0;
        existingBook.rating = rating;
        existingBook.language = language;
        existingBook.price = int.tryParse(price!) ?? 0;
        existingBook.coverUrl = coverUrl;
        existingBook.bookurl = bookUrl;
        existingBook.isOnSale = isOnSale;

        await existingBook.save();
      } else {
        BookModel newBook = BookModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: title,
          author: author,
          description: description,
          category: category,
          pages: int.tryParse(pages ?? '0') ?? 0,
          rating: rating,
          language: language,
          price: int.tryParse(price!) ?? 0,
          coverUrl: coverUrl,
          bookurl: bookUrl,
          createdAt: DateTime.now().toString(),
          isBookmarked: false,
          isOwned: false,
          isOnSale: isOnSale,
        );
        await box.add(newBook);
      }

      clearForm();
      emit(AddBookSuccess());
    } catch (e) {
      emit(AddBookFailure(e.toString()));
    }
  }

  void clearForm() {
    existingId = null;
    title = null;
    author = null;
    description = null;
    rating = null;
    language = null;
    category = null;
    coverUrl = null;
    bookUrl = null;
    price = null;
    pages = null;
    isOnSale = false;
    emit(AddBookInitial());
  }
}