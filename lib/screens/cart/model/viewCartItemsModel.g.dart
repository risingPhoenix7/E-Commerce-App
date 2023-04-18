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

PostOrderDetails _$PostOrderDetailsFromJson(Map<String, dynamic> json) =>
    PostOrderDetails(
      payment_uid: json['payment_uid'] as String,
      paymentType: json['paymentType'] as String,
      coupon_code: json['coupon_code'] as String?,
    );

Map<String, dynamic> _$PostOrderDetailsToJson(PostOrderDetails instance) =>
    <String, dynamic>{
      'payment_uid': instance.payment_uid,
      'paymentType': instance.paymentType,
      'coupon_code': instance.coupon_code,
    };

SingleOrderDetails _$SingleOrderDetailsFromJson(Map<String, dynamic> json) =>
    SingleOrderDetails(
      order: Order.fromJson(json['order'] as Map<String, dynamic>),
      order_items: (json['order_items'] as List<dynamic>)
          .map((e) => MiniItemDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SingleOrderDetailsToJson(SingleOrderDetails instance) =>
    <String, dynamic>{
      'order': instance.order,
      'order_items': instance.order_items,
    };

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['id'] as int?,
      paymentUid: json['paymentUid'] as String?,
      amount: json['amount'] as int?,
      orderTime: json['orderTime'] as String?,
      addressLine1: json['addressLine1'] as String?,
      addressLine2: json['addressLine2'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      pincode: json['pincode'] as String?,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'paymentUid': instance.paymentUid,
      'amount': instance.amount,
      'orderTime': instance.orderTime,
      'addressLine1': instance.addressLine1,
      'addressLine2': instance.addressLine2,
      'city': instance.city,
      'country': instance.country,
      'pincode': instance.pincode,
    };
