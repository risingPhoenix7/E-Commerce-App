// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sellerItemDetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SellerItemDetails _$SellerItemDetailsFromJson(Map<String, dynamic> json) =>
    SellerItemDetails(
      name: json['name'] as String?,
      item_id: json['item_id'] as int?,
      description: json['description'] as String?,
      mrp: (json['mrp'] as num?)?.toDouble(),
      price: (json['price'] as num?)?.toDouble(),
      quantity: json['quantity'] as int?,
      category_id: json['category_id'] as int?,
    );

Map<String, dynamic> _$SellerItemDetailsToJson(SellerItemDetails instance) =>
    <String, dynamic>{
      'item_id': instance.item_id,
      'name': instance.name,
      'description': instance.description,
      'mrp': instance.mrp,
      'price': instance.price,
      'quantity': instance.quantity,
      'category_id': instance.category_id,
    };
