import 'package:json_annotation/json_annotation.dart';

part 'sellerItemDetails.g.dart';

@JsonSerializable()
class SellerItemDetails {
  int? item_id;
  final String? name;
  String? description;
  final double? mrp;
  final double? price;
  final int? quantity;
  final int? category_id;

  SellerItemDetails({
    this.name,
    this.item_id,
    this.description,
    this.mrp,
    this.price,
    this.quantity,
    this.category_id,
  });

  factory SellerItemDetails.fromJson(Map<String, dynamic> json) =>
      _$SellerItemDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$SellerItemDetailsToJson(this);
}
