import 'package:equatable/equatable.dart';

class Failures extends Equatable {
  final String message;

  const Failures({required this.message});

  @override
  List<Object?> get props => [message];
}
