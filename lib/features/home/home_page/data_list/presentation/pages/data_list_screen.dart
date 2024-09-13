import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test_new/core/common/widgets/loader.dart';
import 'package:machine_test_new/core/utils/show_snackbar.dart';
import '../bloc/data_bloc.dart';

class DataListScreen extends StatelessWidget {
  const DataListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DataBloc, DataState>(listener: (context, state) {
        if (state is DataLoadFailure) {
          showSnackbar(context, state.message);
        }
      }, builder: (context, state) {
        if (state is DataInitial) {
          Future.microtask(
            () {
              context.read<DataBloc>().add(DataButtonPressed());
            },
          );
        }
        if (state is DataLoading) {
          return Loader();
        }
        if (state is DataLoadSucess) {
          return ListView.builder(
            itemCount: state.data.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Text(
                  state.data[index].name,
                ),
                title: Text(state.data[index].email),
                subtitle: Text(state.data[index].body),
              );
            },
          );
        }
        return SizedBox();
      }),
    );
  }
}
