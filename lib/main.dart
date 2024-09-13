import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test_new/core/common/cubit/logged_in/logged_in_cubit.dart';
import 'package:machine_test_new/core/common/cubit/selected/selected_cubit.dart';
import 'package:machine_test_new/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:machine_test_new/features/home/home_page/home_screen.dart';
import 'package:machine_test_new/init_dependencies.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/home/home_page/data_list/presentation/bloc/data_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<AuthBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<LoggedInCubit>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<DataBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<SelectedCubit>(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    context.read<AuthBloc>().add(IsLoggedIn());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocSelector<LoggedInCubit, LoggedInState, bool>(
        selector: (state) {
          return state is UserLoggedIn;
        },
        builder: (context, state) {
          if (state) {
            return HomePage();
          }
          return const LoginPage(
            fromSplash: true,
          );
        },
      ),
    );
  }
}
