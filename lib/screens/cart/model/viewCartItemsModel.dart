import 'package:definitely_not_amazon/screens/home/repository/model/mini_item_details.dart';
import 'package:json_annotation/json_annotation.dart';

part 'viewCartItemsModel.g.dart';

@JsonSerializable()
class CartItem {
  String? name;
  String? image;
  int? quantity;
  String? description;
  int? item_id;
  double? price;

  CartItem({
    this.name,
    this.quantity,
    this.image,
    this.description,
    this.item_id,
    this.price,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}

@JsonSerializable()
class OrderItem {
  int? id;
  String? payment_uid;
  double? amount;
  String? created_at;

  OrderItem({
    this.id,
    this.payment_uid,
    this.amount,
    this.created_at,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}

@JsonSerializable()
class PostCartItem {
  int? item_id;
  int? quantity;

  PostCartItem({
    this.item_id,
    this.quantity,
  });

  factory PostCartItem.fromJson(Map<String, dynamic> json) =>
      _$PostCartItemFromJson(json);

  Map<String, dynamic> toJson() => _$PostCartItemToJson(this);
}

@JsonSerializable()
class PostOrderDetails {
  String payment_uid;
  String paymentType;
  String? coupon_code;

  PostOrderDetails({
    required this.payment_uid,
    required this.paymentType,
    this.coupon_code,
  });

  factory PostOrderDetails.fromJson(Map<String, dynamic> json) =>
      _$PostOrderDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$PostOrderDetailsToJson(this);
}

@JsonSerializable()
class SingleOrderDetails {
  SingleOrderDetails({
    required this.order,
    required this.order_items,
  });

  final Order order;
  final List<MiniItemDetails> order_items;

  factory SingleOrderDetails.fromJson(Map<String, dynamic> json) =>
      _$SingleOrderDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$SingleOrderDetailsToJson(this);
}

@JsonSerializable()
class Order {
  Order({
    this.id,
    this.paymentUid,
    this.amount,
    this.orderTime,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.country,
    this.pincode,
  });

  final int? id;
  final String? paymentUid;
  final int? amount;
  final String? orderTime;
  final String? addressLine1;
  final String? addressLine2;
  final String? city;
  final String? country;
  final String? pincode;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
