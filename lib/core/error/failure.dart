import 'package:flutter/material.dart';

import '../localization/app_localizations.dart';

enum ErrorType {
  network,
  server,
  authentication,
  unknown,
}

class Failure {
  final ErrorType type;
  final String message;

  Failure(this.type, [String? customMessage])
      : message = customMessage ?? '';

  String getLocalizedErrorMessage(BuildContext context) {
    switch (type) {
      case ErrorType.network:
        return message.isNotEmpty
            ? message
            : AppLocalizations.of(context).translate('network_error_message_key');
      case ErrorType.server:
        return message.isNotEmpty
            ? message
            : AppLocalizations.of(context).translate('server_error_message_key');
      case ErrorType.authentication:
        return message.isNotEmpty
            ? message
            : AppLocalizations.of(context).translate('authentication_error_message_key');
      case ErrorType.unknown:
        return message.isNotEmpty
            ? message
            : AppLocalizations.of(context).translate('unknown_error_message_key');
    // Add more cases for other error types if necessary
      default:
        return message.isNotEmpty
            ? message
            : AppLocalizations.of(context).translate('error_message');
    }
  }
}
