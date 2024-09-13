import 'package:hive/hive.dart';
import '../models/user_model.dart';

abstract interface class AuthLocalDataSource {
  UserModel? checkUserLoggedIn();
  void uploadUserData(UserModel user);
  Future<void> logoutUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final Box box;

  AuthLocalDataSourceImpl(this.box);

  @override
  void uploadUserData(UserModel user) {
    box.write(
      () {
        box.put('user', user.toJson());
      },
    );
  }

  @override
  UserModel? checkUserLoggedIn() {
    final result = box.get('user');
    if (result != null) {
      return UserModel.fromJson(result);
    }
    return null;
  }

  @override
  Future<void> logoutUser() async {
    box.clear();
  }
}
