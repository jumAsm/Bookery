import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import '../../models/BookModel.dart';
part 'add_book_state.dart';

const String kBookBox = 'books_for_sale_box';

class AddBookCubit extends Cubit<AddBookState> {
  AddBookCubit() : super(AddBookInitial());

  String? title, author, description, aboutAuthor, rating, language, category;
  String? coverUrl, bookUrl, price;
  String? pages;

  void updateCoverUrl(String? path) {
    coverUrl = path;
    emit(AddBookInitial());
  }

  void updateBookUrl(String? path) {
    bookUrl = path;
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

  void saveBook() async {
    BookModel newBook = BookModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      author: author,
      description: description,
      aboutAuthor: aboutAuthor,
      category: category,
      pages: int.tryParse(pages ?? '0') ?? 0,
      rating: rating,
      language: language,
      price: int.tryParse(price!) ?? 0,
      coverUrl: coverUrl,
      bookurl: bookUrl,
      createdAt: DateTime.now().toString(),
    );

    emit(AddBookLoading());
    try {
      var box = Hive.box<BookModel>(kBookBox);
      await box.add(newBook);

      clearForm();
      emit(AddBookSuccess());
    } catch (e) {
      emit(AddBookFailure(e.toString()));
    }
  }

  void clearForm() {
    title = null;
    author = null;
    description = null;
    aboutAuthor = null;
    rating = null;
    language = null;
    category = null;
    coverUrl = null;
    bookUrl = null;
    price = null;
    pages = null;
    emit(AddBookInitial());
  }
}
