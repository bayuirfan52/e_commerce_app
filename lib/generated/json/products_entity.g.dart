import 'package:e_commerce_app/generated/json/base/json_convert_content.dart';
import 'package:e_commerce_app/app/model/products_entity.dart';

ProductsEntity $ProductsEntityFromJson(Map<String, dynamic> json) {
	final ProductsEntity productsEntity = ProductsEntity();
	final double? id = jsonConvert.convert<double>(json['id']);
	if (id != null) {
		productsEntity.id = id;
	}
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		productsEntity.title = title;
	}
	final double? price = jsonConvert.convert<double>(json['price']);
	if (price != null) {
		productsEntity.price = price;
	}
	final String? description = jsonConvert.convert<String>(json['description']);
	if (description != null) {
		productsEntity.description = description;
	}
	final String? category = jsonConvert.convert<String>(json['category']);
	if (category != null) {
		productsEntity.category = category;
	}
	final String? image = jsonConvert.convert<String>(json['image']);
	if (image != null) {
		productsEntity.image = image;
	}
	final ProductsRating? rating = jsonConvert.convert<ProductsRating>(json['rating']);
	if (rating != null) {
		productsEntity.rating = rating;
	}
	return productsEntity;
}

Map<String, dynamic> $ProductsEntityToJson(ProductsEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['title'] = entity.title;
	data['price'] = entity.price;
	data['description'] = entity.description;
	data['category'] = entity.category;
	data['image'] = entity.image;
	data['rating'] = entity.rating?.toJson();
	return data;
}

ProductsRating $ProductsRatingFromJson(Map<String, dynamic> json) {
	final ProductsRating productsRating = ProductsRating();
	final double? rate = jsonConvert.convert<double>(json['rate']);
	if (rate != null) {
		productsRating.rate = rate;
	}
	final double? count = jsonConvert.convert<double>(json['count']);
	if (count != null) {
		productsRating.count = count;
	}
	return productsRating;
}

Map<String, dynamic> $ProductsRatingToJson(ProductsRating entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['rate'] = entity.rate;
	data['count'] = entity.count;
	return data;
}