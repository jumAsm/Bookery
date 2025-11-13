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
  String? coverUrl;
  @HiveField(6)
  String? bookurl;
  @HiveField(7)
  String? category;
  @HiveField(8)
  String? language;
  @HiveField(9)
  String? createdAt;
  @HiveField(10)
  int? pages;
  @HiveField(11)
  int? price;
  @HiveField(12)
  bool? isInBasket;
  @HiveField(13)
  bool? isBookmarked;
  @HiveField(14)
  bool? isOwned;
  @HiveField(15)
  bool? isOnSale;
  @HiveField(16)
  String? note;
  @HiveField(17)
  bool? isFavorite;
  @HiveField(18)
  String? readingStatus;
  @HiveField(19)
  String? bookmarkDate;
  @HiveField(20)
  String? favoriteDate;

  BookModel({
    this.id,
    this.title,
    this.description,
    this.rating,
    this.author,
    this.coverUrl,
    this.bookurl,
    this.category,
    this.language,
    this.createdAt,
    this.pages,
    this.price,
    this.isInBasket = false,
    this.isBookmarked = false,
    this.isOwned = false,
    this.isOnSale = false,
    this.note,
    this.isFavorite = false,
    this.readingStatus = 'On Going',
    this.bookmarkDate,
    this.favoriteDate,
  });
}