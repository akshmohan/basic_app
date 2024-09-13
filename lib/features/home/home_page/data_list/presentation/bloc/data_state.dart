part of 'data_bloc.dart';

@immutable
sealed class DataState {}

final class DataInitial extends DataState {}

final class DataLoading extends DataState {}

final class DataLoadSucess extends DataState {
  final List<DataEntity> data;

  DataLoadSucess({required this.data});
}

final class DataLoadFailure extends DataState {
  final String message;

  DataLoadFailure({required this.message});
}
