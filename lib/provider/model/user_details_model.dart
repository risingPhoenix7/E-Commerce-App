import 'package:json_annotation/json_annotation.dart';

part 'user_details_model.g.dart';

@JsonSerializable()
class UserDetailsModel {
  String? first_name;
  String? last_name;
  String? sex;
  String? mobile;
  String? email;
  String? delivery_address1;
  String? delivery_address2;
  String? delivery_city;
  String? delivery_country;
  String? delivery_pincode;
  String? store_address1;
  String? store_address2;
  String? store_city;
  String? store_country;
  String? store_pincode;
  int? age;
  int? id;
  int? cart_count;
  String? access;

  UserDetailsModel({
    this.first_name,
    this.last_name,
    this.sex,
    this.mobile,
    this.email,
    this.delivery_address1,
    this.delivery_address2,
    this.delivery_city,
    this.delivery_country,
    this.delivery_pincode,
    this.store_address1,
    this.store_address2,
    this.store_city,
    this.store_country,
    this.store_pincode,
    this.age,
    this.id,
    this.cart_count,
    this.access,
  });

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailsModelToJson(this);
}

@JsonSerializable()
class LoginPostRequestModel {
  String? email;
  String? password;

  LoginPostRequestModel({this.email, this.password});

  factory LoginPostRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LoginPostRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginPostRequestModelToJson(this);
}

@JsonSerializable()
class UserLimitedDetailsModel {
  String? first_name;
  String? last_name;
  String? mobile;
  String? email;
  String? password;
  String? confirm_password;

  UserLimitedDetailsModel({
    this.first_name,
    this.last_name,
    this.mobile,
    this.email,
    this.password,
    this.confirm_password,
  });

  factory UserLimitedDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$UserLimitedDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserLimitedDetailsModelToJson(this);
}
