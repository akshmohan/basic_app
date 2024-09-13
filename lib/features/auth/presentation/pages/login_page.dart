import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test_new/core/common/palette/app_palette.dart';
import 'package:machine_test_new/core/common/widgets/loader.dart';
import 'package:machine_test_new/core/utils/show_snackbar.dart';
import 'package:machine_test_new/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:machine_test_new/features/auth/presentation/widgets/auth_button.dart';
import 'package:machine_test_new/features/auth/presentation/widgets/auth_field.dart';
import 'package:machine_test_new/features/home/home_page/home_screen.dart';

class LoginPage extends StatefulWidget {
  final bool fromSplash;
  const LoginPage({super.key, required this.fromSplash});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers for email and password fields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // GlobalKey for form validation
  final formKey = GlobalKey<FormState>();

  // Dispose method to dispose of text editing controllers
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // BlocConsumer listens to state changes in AuthBloc and rebuilds UI accordingly
    return BlocConsumer<AuthBloc, AuthState>(
      // Listener function to execute based on state changes
      listener: (context, state) {
        // Show snackbar if login fails
        if (state is AuthLoginFailure && widget.fromSplash != true) {
          showSnackbar(context, state.message);
        }
        // Navigate to ProfileScreen if login succeeds
        if (state is AuthLoginSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        }
      },
      // Builder function to build UI based on state
      builder: (context, state) {
        // Show loader widget if login is in progress
        if (state is AuthLoginLoading) {
          return const Loader();
        }
        // Otherwise, build login form
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppPalette.appBarColor,
            title: const Text(
              "Login Page",
              style: TextStyle(
                color: AppPalette.textWhiteColor,
              ),
            ),
            centerTitle: true,
          ),
          // Main content of the page
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              // Form widget for user input
              child: Form(
                key: formKey, // Attach GlobalKey for form validation
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Email field widget
                    AuthField(
                      hintText: "Enter Email",
                      controller: emailController,
                    ),
                    const SizedBox(height: 20),
                    // Password field widget
                    AuthField(
                      hintText: "Enter Password",
                      controller: passwordController,
                      isObscureText: true, // Obscure text for password field
                    ),
                    const SizedBox(height: 50),
                    // Login button widget
                    AuthButton(
                      buttonText: "Login",
                      onPressed: () {
                        // Validate form before submitting
                        if (formKey.currentState!.validate()) {
                          // Dispatch AuthLoginPressed event with email and password
                          context.read<AuthBloc>().add(
                                AuthLoginPressed(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                ),
                              );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
