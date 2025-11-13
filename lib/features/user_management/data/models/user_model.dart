import 'package:betalyze_mobile/features/user_management/domain/entities/user.dart';

class UserModel extends User {
  const UserModel(
      {
        required super.id,
        required super.fullname,
        required super.email
      });
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] as int,
    fullname: json['fullname'] as String,
    email: json['email'] as String,
  );

  Map<String, dynamic> toJson() =>
      {'id': id, 'fullname': fullname, 'email': email};

  factory UserModel.fromEntity(User user) =>
      UserModel(id: user.id, fullname: user.fullname, email: user.email);
}
