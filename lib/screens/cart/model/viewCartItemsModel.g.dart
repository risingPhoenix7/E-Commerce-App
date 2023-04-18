// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'viewCartItemsModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
      name: json['name'] as String?,
      quantity: json['quantity'] as int?,
      image: json['image'] as String?,
      description: json['description'] as String?,
      item_id: json['item_id'] as int?,
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'quantity': instance.quantity,
      'description': instance.description,
      'item_id': instance.item_id,
      'price': instance.price,
    };

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
      id: json['id'] as int?,
      payment_uid: json['payment_uid'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      created_at: json['created_at'] as String?,
    );

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'id': instance.id,
      'payment_uid': instance.payment_uid,
      'amount': instance.amount,
      'created_at': instance.created_at,
    };

PostCartItem _$PostCartItemFromJson(Map<String, dynamic> json) => PostCartItem(
      item_id: json['item_id'] as int?,
      quantity: json['quantity'] as int?,
    );

Map<String, dynamic> _$PostCartItemToJson(PostCartItem instance) =>
    <String, dynamic>{
      'item_id': instance.item_id,
      'quantity': instance.quantity,
    };
