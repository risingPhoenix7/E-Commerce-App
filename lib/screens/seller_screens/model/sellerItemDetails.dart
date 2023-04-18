import 'package:json_annotation/json_annotation.dart';

part 'sellerItemDetails.g.dart';

@JsonSerializable()
class SellerItemDetails {
  final String? name;
   String? description;
  final double? mrp;
  final double? price;
  final int? quantity;

  SellerItemDetails({
    this.name,
    this.description,
    this.mrp,
    this.price,
    this.quantity,
  });

  factory SellerItemDetails.fromJson(Map<String, dynamic> json) =>
      _$SellerItemDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$SellerItemDetailsToJson(this);
}


