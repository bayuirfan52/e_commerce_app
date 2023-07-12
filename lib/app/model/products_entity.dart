import 'dart:convert';

import 'package:e_commerce_app/generated/json/base/json_field.dart';
import 'package:e_commerce_app/generated/json/products_entity.g.dart';
import 'package:hive/hive.dart';

part 'products_entity.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class ProductsEntity extends HiveObject {

	ProductsEntity();

	factory ProductsEntity.fromJson(Map<String, dynamic> json) => $ProductsEntityFromJson(json);
	@HiveField(0)
	double? id;
	@HiveField(1)
	String? title;
	@HiveField(2)
	double? price;
	@HiveField(3)
	String? description;
	@HiveField(4)
	String? category;
	@HiveField(5)
	String? image;
	@HiveField(6)
	ProductsRating? rating;

	Map<String, dynamic> toJson() => $ProductsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@HiveType(typeId: 1)
@JsonSerializable()
class ProductsRating extends HiveObject {

	ProductsRating();

	factory ProductsRating.fromJson(Map<String, dynamic> json) => $ProductsRatingFromJson(json);
	@HiveField(7)
	double? rate;
	@HiveField(8)
	double? count;

	Map<String, dynamic> toJson() => $ProductsRatingToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
