import 'package:machine_test_new/features/auth/domain/repositories/auth_repository.dart';

class UserLogout {
  final AuthRepository authRepository;
  UserLogout(this.authRepository);

  call() {
    authRepository.logoutUserFromApp();
  }
}
