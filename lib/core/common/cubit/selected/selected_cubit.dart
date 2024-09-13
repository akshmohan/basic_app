import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'selected_state.dart';

class SelectedCubit extends Cubit<SelectedState> {
  SelectedCubit() : super(SelectedInitial(0));

  void onSelection(int select) {
    emit(SelectedInitial(select));
  }
}
