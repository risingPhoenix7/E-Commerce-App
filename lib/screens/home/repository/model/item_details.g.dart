// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemDetails _$ItemDetailsFromJson(Map<String, dynamic> json) => ItemDetails(
      name: json['name'] as String?,
      id: json['id'] as int?,
      store_name: json['store_name'] as String?,
      description: json['description'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      rating: (json['rating'] as num?)?.toDouble(),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => ReviewDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      mrp: (json['mrp'] as num?)?.toDouble(),
      price: json['price'] as int?,
      discount: (json['discount'] as num?)?.toDouble(),
      quantity: json['quantity'] as int?,
    );

Map<String, dynamic> _$ItemDetailsToJson(ItemDetails instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'description': instance.description,
      'store_name': instance.store_name,
      'images': instance.images,
      'rating': instance.rating,
      'mrp': instance.mrp,
      'reviews': instance.reviews,
      'price': instance.price,
      'discount': instance.discount,
      'quantity': instance.quantity,
    };

ReviewDetails _$ReviewDetailsFromJson(Map<String, dynamic> json) =>
    ReviewDetails(
      title: json['title'] as String?,
      description: json['description'] as String?,
      imageUrls: (json['imageUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      reviewer_name: json['reviewer_name'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ReviewDetailsToJson(ReviewDetails instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'reviewer_name': instance.reviewer_name,
      'rating': instance.rating,
      'imageUrls': instance.imageUrls,
    };
