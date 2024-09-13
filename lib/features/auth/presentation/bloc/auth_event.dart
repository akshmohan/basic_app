part of 'auth_bloc.dart';

sealed class AuthEvent {}

class AuthLoginPressed extends AuthEvent {
  final String email;
  final String password;

  AuthLoginPressed({required this.email, required this.password});
}

class AuthLogoutPressed extends AuthEvent {}

class IsLoggedIn extends AuthEvent {}

class LoadFromHive extends AuthEvent {}
