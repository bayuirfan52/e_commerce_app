// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductsEntityAdapter extends TypeAdapter<ProductsEntity> {
  @override
  final int typeId = 0;

  @override
  ProductsEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductsEntity()
      ..id = fields[0] as double?
      ..title = fields[1] as String?
      ..price = fields[2] as double?
      ..description = fields[3] as String?
      ..category = fields[4] as String?
      ..image = fields[5] as String?
      ..rating = fields[6] as ProductsRating?;
  }

  @override
  void write(BinaryWriter writer, ProductsEntity obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.rating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductsEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProductsRatingAdapter extends TypeAdapter<ProductsRating> {
  @override
  final int typeId = 1;

  @override
  ProductsRating read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductsRating()
      ..rate = fields[7] as double?
      ..count = fields[8] as double?;
  }

  @override
  void write(BinaryWriter writer, ProductsRating obj) {
    writer
      ..writeByte(2)
      ..writeByte(7)
      ..write(obj.rate)
      ..writeByte(8)
      ..write(obj.count);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductsRatingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
