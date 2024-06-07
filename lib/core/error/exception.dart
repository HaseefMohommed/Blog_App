import 'package:blog_app/core/localization/app_localizations.dart';
import 'package:flutter/material.dart';

class ServerException implements Exception {
  final String key;

  ServerException(this.key);

  String getLocalizedErrorMessage(BuildContext context) {
    return AppLocalizations.of(context).translate(key);
  }
}

