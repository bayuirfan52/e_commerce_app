import 'dart:convert';

import 'package:e_commerce_app/generated/json/base/json_field.dart';
import 'package:e_commerce_app/generated/json/products_entity.g.dart';

@JsonSerializable()
class ProductsEntity {

	ProductsEntity();

	factory ProductsEntity.fromJson(Map<String, dynamic> json) => $ProductsEntityFromJson(json);
	double? id;
	String? title;
	double? price;
	String? description;
	String? category;
	String? image;
	ProductsRating? rating;

	Map<String, dynamic> toJson() => $ProductsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ProductsRating {

	ProductsRating();

	factory ProductsRating.fromJson(Map<String, dynamic> json) => $ProductsRatingFromJson(json);
	double? rate;
	double? count;

	Map<String, dynamic> toJson() => $ProductsRatingToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
