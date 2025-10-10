part of 'BookModel.dart';

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
      aboutAuthor: fields[5] as String?,
      coverUrl: fields[6] as String?,
      bookurl: fields[7] as String?,
      category: fields[8] as String?,
      language: fields[9] as String?,
      createdAt: fields[10] as String?,
      pages: fields[11] as int?,
      price: fields[12] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, BookModel obj) {
    writer
      ..writeByte(13)
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
      ..write(obj.aboutAuthor)
      ..writeByte(6)
      ..write(obj.coverUrl)
      ..writeByte(7)
      ..write(obj.bookurl)
      ..writeByte(8)
      ..write(obj.category)
      ..writeByte(9)
      ..write(obj.language)
      ..writeByte(10)
      ..write(obj.createdAt)
      ..writeByte(11)
      ..write(obj.pages)
      ..writeByte(12)
      ..write(obj.price);
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
