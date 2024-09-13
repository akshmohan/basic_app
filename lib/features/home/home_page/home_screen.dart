import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test_new/core/common/cubit/selected/selected_cubit.dart';
import 'package:machine_test_new/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:machine_test_new/features/auth/presentation/pages/login_page.dart';
import 'package:machine_test_new/features/home/home_page/data_list/presentation/pages/data_list_screen.dart';
import 'package:machine_test_new/features/home/home_page/profile/presentation/pages/profile_screen.dart';
import '../../../core/common/palette/app_palette.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Widget> _pages = [
    ProfileScreen(),
    DataListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppPalette.appBarColor,
        title: const Text(
          "Home Screen",
          style: TextStyle(
            color: AppPalette.textWhiteColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(AuthLogoutPressed());
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(fromSplash: true),
                ),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: BlocConsumer<SelectedCubit, SelectedState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is SelectedInitial) {
            return _pages[state.index];
          }
          return _pages[0];
        },
      ),
      bottomNavigationBar: BlocBuilder<SelectedCubit, SelectedState>(
        builder: (context, state) {
          int currentIndex = 0;
          if (state is SelectedInitial) {
            currentIndex = state.index;
          }
          return BottomNavigationBar(
            onTap: (index) => context.read<SelectedCubit>().onSelection(index),
            currentIndex: currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_tree_outlined),
                label: 'Data List',
              ),
            ],
          );
        },
      ),
    );
  }
}
