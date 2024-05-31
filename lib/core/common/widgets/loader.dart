import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 6.0, 
        valueColor: AlwaysStoppedAnimation<Color>(
          Theme.of(context).brightness == Brightness.dark
            ? AppPalette.greyColor
            : AppPalette.blueColor
        ),
      ),
    );
  }
}
