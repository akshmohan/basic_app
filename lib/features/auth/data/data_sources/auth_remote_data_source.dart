import 'dart:convert';
import 'package:machine_test_new/core/errors/exceptions.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      var response = await http.post(
        Uri.parse('https://reqres.in/api/login'),
        body: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        var userData = UserModel(
          email: email,
          password: password,
          token: data['token'],
        );
        return userData;
      } else {
        throw ServerException('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
