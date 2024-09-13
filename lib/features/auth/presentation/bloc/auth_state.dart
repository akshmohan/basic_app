part of 'auth_bloc.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoginLoading extends AuthState {}

final class AuthLoginSuccess extends AuthState {
  final UserEntity user;

  AuthLoginSuccess({required this.user});
}

final class AuthLoginFailure extends AuthState {
  final String message;

  AuthLoginFailure({required this.message});
}
