part of 'data_bloc.dart';

@immutable
sealed class DataEvent {}

final class DataButtonPressed extends DataEvent {}
