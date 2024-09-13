import 'package:flutter/material.dart';
import 'package:machine_test_new/core/common/palette/app_palette.dart';

class AuthButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const AuthButton(
      {super.key, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(10),
    //     color: AppPalette.buttonColor,
    //   ),
    //   child: ElevatedButton(
    //     onPressed: onPressed,
    //     child: Text(
    //       buttonText,
    //       style: TextStyle(
    //         color: AppPalette.textWhiteColor,
    //       ),
    //     ),
    //   ),
    // );
    return ElevatedButton(
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(color: AppPalette.textWhiteColor),
        ));
  }
}
