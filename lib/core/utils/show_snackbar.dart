import 'package:blog_app/core/error/failure.dart';
import 'package:flutter/material.dart';


void showSnackBar(BuildContext context, Failure failure) {
  final errorMessage = failure.getLocalizedErrorMessage(context);
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(errorMessage),
      ),
    );
}
