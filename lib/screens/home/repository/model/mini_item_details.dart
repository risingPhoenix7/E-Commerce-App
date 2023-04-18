import 'package:json_annotation/json_annotation.dart';

part 'mini_item_details.g.dart';

@JsonSerializable()
class MiniItemDetails {
  final String? name;
  final int? id;
  final String? seller_name;
   String? image;
  final double? rating;
  final int? price;

  MiniItemDetails({
    this.name,
    this.id,
    this.seller_name,
    this.image,
    this.rating,
    this.price,
  });

  factory MiniItemDetails.fromJson(Map<String, dynamic> json) =>
      _$MiniItemDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$MiniItemDetailsToJson(this);
}
