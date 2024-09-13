import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test_new/core/use_cases/use_case.dart';
import '../../domain/entities/data_entity.dart';
import '../../domain/use_cases/data_usecase.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final DataLoad _dataLoad;

  DataBloc(DataLoad dataLoad)
      : _dataLoad = dataLoad,
        super(DataInitial()) {
    on<DataButtonPressed>((event, emit) async {
      final data = await _dataLoad(NoParams());
      print(data);
      data.fold((l) => emit(DataLoadFailure(message: l.message)),
          (r) => emit(DataLoadSucess(data: r)));
    });
  }
}
