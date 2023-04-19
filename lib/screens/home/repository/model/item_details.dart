import 'package:json_annotation/json_annotation.dart';

part 'item_details.g.dart';

@JsonSerializable()
class ItemDetails {
  final String? name;
  final int? id;
  final String? description;
  final String? store_name;
  final List<String>? images;
  final double? rating;
  final double? mrp;
  final List<ReviewDetails>? reviews;
  final int? price;
  final double? discount;
  final int? quantity;

  ItemDetails({
    this.name,
    this.id,
    this.store_name,
    this.description,
    this.images,
    this.rating,
    this.reviews,
    this.mrp,
    this.price,
    this.discount,
    this.quantity,
  });

  factory ItemDetails.fromJson(Map<String, dynamic> json) =>
      _$ItemDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemDetailsToJson(this);
}

@JsonSerializable()
class ReviewDetails {
  final String? title;
  final String? description;
  final String? reviewer_name;
  final double? rating;
  String? image;

  ReviewDetails({
    this.title,
    this.description,
    this.image,
    this.reviewer_name,
    this.rating,
  });

  factory ReviewDetails.fromJson(Map<String, dynamic> json) =>
      _$ReviewDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewDetailsToJson(this);
}
