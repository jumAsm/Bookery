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
      coverUrl: fields[5] as String?,
      bookurl: fields[6] as String?,
      category: fields[7] as String?,
      language: fields[8] as String?,
      createdAt: fields[9] as String?,
      pages: fields[10] as int?,
      price: fields[11] as int?,
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
