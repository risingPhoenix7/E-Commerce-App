// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mini_item_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MiniItemDetails _$MiniItemDetailsFromJson(Map<String, dynamic> json) =>
    MiniItemDetails(
      name: json['name'] as String?,
      id: json['id'] as int?,
      seller_name: json['seller_name'] as String?,
      image: json['image'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      price: json['price'] as int?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$MiniItemDetailsToJson(MiniItemDetails instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'seller_name': instance.seller_name,
      'image': instance.image,
      'rating': instance.rating,
      'price': instance.price,
      'status': instance.status,
    };
