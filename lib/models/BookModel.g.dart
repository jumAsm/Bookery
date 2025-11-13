// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BookModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookModelAdapter extends TypeAdapter<BookModel> {
  @override
  final int typeId = 0;

  @override
  BookModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookModel(
      id: fields[0] as String?,
      title: fields[1] as String?,
      description: fields[2] as String?,
      rating: fields[3] as String?,
      author: fields[4] as String?,
      coverUrl: fields[5] as String?,
      bookurl: fields[6] as String?,
      category: fields[7] as String?,
      language: fields[8] as String?,
      createdAt: fields[9] as String?,
      pages: fields[10] as int?,
      price: fields[11] as int?,
      isInBasket: fields[12] as bool?,
      isBookmarked: fields[13] as bool?,
      isOwned: fields[14] as bool?,
      isOnSale: fields[15] as bool?,
      note: fields[16] as String?,
      isFavorite: fields[17] as bool?,
      readingStatus: fields[18] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BookModel obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.rating)
      ..writeByte(4)
      ..write(obj.author)
      ..writeByte(5)
      ..write(obj.coverUrl)
      ..writeByte(6)
      ..write(obj.bookurl)
      ..writeByte(7)
      ..write(obj.category)
      ..writeByte(8)
      ..write(obj.language)
      ..writeByte(9)
      ..write(obj.createdAt)
      ..writeByte(10)
      ..write(obj.pages)
      ..writeByte(11)
      ..write(obj.price)
      ..writeByte(12)
      ..write(obj.isInBasket)
      ..writeByte(13)
      ..write(obj.isBookmarked)
      ..writeByte(14)
      ..write(obj.isOwned)
      ..writeByte(15)
      ..write(obj.isOnSale)
      ..writeByte(16)
      ..write(obj.note)
      ..writeByte(17)
      ..write(obj.isFavorite)
      ..writeByte(18)
      ..write(obj.readingStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
