import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int? id;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final DateTime? birthDate;
  final String? address;
  final String? userBanner;
  final String? profilePicture;
  final DateTime? lastDonationDate;

  User({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.birthDate,
    this.address,
    this.userBanner,
    this.profilePicture,
    this.lastDonationDate,
  });

  /// Factory method pour générer une instance de `User` depuis un JSON.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Méthode pour convertir une instance de `User` en JSON.
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
