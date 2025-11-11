import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'pages/homePage.dart';
import 'models/BookModel.dart';
import 'widgets/initial_data.dart';
import 'cubits/books_cubit.dart';
import 'cubits/add_book_cubit.dart';
const String kBookBox = 'books_for_sale_box';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(BookModelAdapter());
  var bookBox = await Hive.openBox<BookModel>(kBookBox);


  if (bookBox.isEmpty) {
    for (var book in initialBookData) {
      await bookBox.add(book);
    }
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BooksCubit()),
        BlocProvider(create: (context) => AddBookCubit()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bookery',
        home: Homepage(),
      ),
    );
  }
}
