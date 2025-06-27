// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num?)?.toInt(),
      username: json['username'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      birthDate: json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      address: json['address'] as String?,
      userBanner: json['userBanner'] as String?,
      profilePicture: json['profilePicture'] as String?,
      lastDonationDate: json['lastDonationDate'] == null
          ? null
          : DateTime.parse(json['lastDonationDate'] as String),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'birthDate': instance.birthDate?.toIso8601String(),
      'address': instance.address,
      'userBanner': instance.userBanner,
      'profilePicture': instance.profilePicture,
      'lastDonationDate': instance.lastDonationDate?.toIso8601String(),
    };
