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

