import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test_new/core/common/widgets/loader.dart';
import 'package:machine_test_new/core/utils/show_snackbar.dart';
import 'package:machine_test_new/features/auth/presentation/bloc/auth_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoginFailure) {
            showSnackbar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is AuthLoginLoading) {
            return const Loader();
          }
          if (state is AuthLoginSuccess) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.user.email),
                  Text(state.user.password),
                  Text(state.user.token),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
