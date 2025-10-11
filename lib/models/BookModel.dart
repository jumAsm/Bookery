import 'package:hive/hive.dart';
part 'BookModel.g.dart';

@HiveType(typeId: 0)
class BookModel extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? description;
  @HiveField(3)
  String? rating;
  @HiveField(4)
  String? author;
  @HiveField(5)
  String? aboutAuthor;
  @HiveField(6)
  String? coverUrl;
  @HiveField(7)
  String? bookurl;
  @HiveField(8)
  String? category;
  @HiveField(9)
  String? language;
  @HiveField(10)
  String? createdAt;
  @HiveField(11)
  int? pages;
  @HiveField(12)
  int? price;
  @HiveField(13)
  bool? isInBasket;
  BookModel({
    this.id,
    this.title,
    this.description,
    this.rating,
    this.author,
    this.aboutAuthor,
    this.coverUrl,
    this.bookurl,
    this.category,
    this.language,
    this.createdAt,
    this.pages,
    this.price,
    this.isInBasket = false,

  });
}
