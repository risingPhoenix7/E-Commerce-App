// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sellerItemDetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SellerItemDetails _$SellerItemDetailsFromJson(Map<String, dynamic> json) =>
    SellerItemDetails(
      name: json['name'] as String?,
      description: json['description'] as String?,
      mrp: (json['mrp'] as num?)?.toDouble(),
      price: (json['price'] as num?)?.toDouble(),
      quantity: json['quantity'] as int?,
    );

Map<String, dynamic> _$SellerItemDetailsToJson(SellerItemDetails instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'mrp': instance.mrp,
      'price': instance.price,
      'quantity': instance.quantity,
    };
