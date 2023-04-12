// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetailsModel _$UserDetailsModelFromJson(Map<String, dynamic> json) =>
    UserDetailsModel(
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      sex: json['sex'] as String?,
      mobile: json['mobile'] as String?,
      email: json['email'] as String?,
      delivery_address1: json['delivery_address1'] as String?,
      delivery_address2: json['delivery_address2'] as String?,
      delivery_city: json['delivery_city'] as String?,
      delivery_country: json['delivery_country'] as String?,
      delivery_pincode: json['delivery_pincode'] as String?,
      store_address1: json['store_address1'] as String?,
      store_address2: json['store_address2'] as String?,
      store_city: json['store_city'] as String?,
      store_country: json['store_country'] as String?,
      store_pincode: json['store_pincode'] as String?,
      age: json['age'] as int?,
      id: json['id'] as int?,
      cart_count: json['cart_count'] as int?,
      access: json['access'] as String?,
    );

Map<String, dynamic> _$UserDetailsModelToJson(UserDetailsModel instance) =>
    <String, dynamic>{
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'sex': instance.sex,
      'mobile': instance.mobile,
      'email': instance.email,
      'delivery_address1': instance.delivery_address1,
      'delivery_address2': instance.delivery_address2,
      'delivery_city': instance.delivery_city,
      'delivery_country': instance.delivery_country,
      'delivery_pincode': instance.delivery_pincode,
      'store_address1': instance.store_address1,
      'store_address2': instance.store_address2,
      'store_city': instance.store_city,
      'store_country': instance.store_country,
      'store_pincode': instance.store_pincode,
      'age': instance.age,
      'id': instance.id,
      'cart_count': instance.cart_count,
      'access': instance.access,
    };

LoginPostRequestModel _$LoginPostRequestModelFromJson(
        Map<String, dynamic> json) =>
    LoginPostRequestModel(
      email: json['email'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$LoginPostRequestModelToJson(
        LoginPostRequestModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

UserLimitedDetailsModel _$UserLimitedDetailsModelFromJson(
        Map<String, dynamic> json) =>
    UserLimitedDetailsModel(
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      mobile: json['mobile'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      confirm_password: json['confirm_password'] as String?,
    );

Map<String, dynamic> _$UserLimitedDetailsModelToJson(
        UserLimitedDetailsModel instance) =>
    <String, dynamic>{
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'mobile': instance.mobile,
      'email': instance.email,
      'password': instance.password,
      'confirm_password': instance.confirm_password,
    };
