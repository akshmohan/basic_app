import 'package:machine_test_new/core/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.email,
    required super.password,
    required super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      token: map['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'token': token,
    };
  }

  UserModel copywith({String? email, String? password, String? token}) {
    return UserModel(
      email: email ?? this.email,
      password: password ?? this.password,
      token: token ?? this.token,
    );
  }
}
