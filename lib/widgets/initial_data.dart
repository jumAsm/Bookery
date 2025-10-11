import '../models/BookModel.dart';

List<BookModel> initialBookData = [
  BookModel(
    id: "1",
    title: "The Laws of Human Nature",
    author: "Robert Greene",
    description:
        "Comes the definitive new book on decoding the behavior of the people around you. .",
    rating: "4.7",
    coverUrl:
        "https://i.pinimg.com/736x/1f/ed/83/1fed83beca4ae44a58361c0964b5021c.jpg",
    bookurl: "placeholder_3.pdf",
    category: "Psychology",
    language: "English",
    createdAt: DateTime.now().toString(),
    pages: 624,
    price: 71,
    aboutAuthor: "The #1 New York Times-bestselling author",
    isInBasket: false,
  ),
  BookModel(
    id: "2",
    title: "عداء الطائرة الورقية",
    author: "خالد حسيني",
    description:
        "عداء الطائرة الورقية عمل روائي لا ينسى يصحبنا في رحلة إلى أفغانستان منذ أواخر العصر الملكي وحتى صعود حركة طالبان واستيلائها على الحكم."
        " إنها قصة صداقة تنشأ بين صبيين يشبان معًا في كابول، في دار واحدة، ولكن في عالمين مختلفين.",
    rating: "4.4",
    coverUrl:
        "https://i.pinimg.com/736x/c8/24/3a/c8243a6cbde58d4c2aa0465e08e26c7a.jpg",
    bookurl: "placeholder_1.pdf",
    category: "Literature",
    language: "Arabic",
    createdAt: DateTime.now().toString(),
    pages: 543,
    price: 60,
    aboutAuthor: "null",
    isInBasket: false,
  ),
  BookModel(
    id: "3",
    title: "The Bell Jar",
    author: "Sylvia Plath",
    description:
        "The Bell Jar, was originally published in 1963 under the pseudonym Victoria Lucas. "
        "The novel is partially based on Plath's own life.",
    rating: "4.0",
    coverUrl:
        "https://i.pinimg.com/1200x/1b/ae/22/1bae226df7df268d2ccb699ef134a811.jpg",
    bookurl: "placeholder_2.pdf",
    category: "Fiction",
    language: "English",
    createdAt: DateTime.now().toString(),
    pages: 294,
    price: 47,
    aboutAuthor: "he Bell Jar, Sylvia Plath's only novel.",
    isInBasket: false,
  ),
  BookModel(
    id: "4",
    title: "كافكا على الشاطئ",
    author: "هاروكي موراكامي",
    description: "ملحمة سحرية وغامضة.",
    rating: "4.6",
    coverUrl:
        "https://i.pinimg.com/736x/32/30/47/32304772b1a4c68be65f05e71b95b9ce.jpg",
    bookurl: "placeholder_3.pdf",
    category: "Literature",
    language: "Arabic",
    createdAt: DateTime.now().toString(),
    pages: 615,
    price: 51,
    aboutAuthor: "روائي ياباني شهير.",
    isInBasket: false,
  ),
  BookModel(
    id: "5",
    title: "No Longer Human",
    author: "Osamu Dazai",
    description:
        "No human being can smile with his fists doubled like that. It is a monkey. A grinning monkey-face. "
        "The smile is nothing more than a puckering of ugly wrinkles.",
    rating: "4.75",
    coverUrl:
        "https://i.pinimg.com/736x/d7/2b/21/d72b2135849f6a65a60a3afbe994551b.jpg",
    bookurl: "placeholder_1.pdf",
    category: "Literature",
    language: "English",
    createdAt: DateTime.now().toString(),
    pages: 271,
    price: 49,
    aboutAuthor: "null",
    isInBasket: false,
  ),
];
