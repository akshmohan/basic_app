part of 'selected_cubit.dart';

@immutable
sealed class SelectedState {}

final class SelectedInitial extends SelectedState {
  final int index;

  SelectedInitial(this.index);
}
