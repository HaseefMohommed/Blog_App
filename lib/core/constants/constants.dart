import 'package:blog_app/core/localization/app_localizations.dart';
import 'package:flutter/material.dart';


class Constants {
  static List<String> getLocalizedTopics(BuildContext context) {
    return [
      AppLocalizations.of(context).translate("technology"),
      AppLocalizations.of(context).translate("business"),
      AppLocalizations.of(context).translate("programming"),
      AppLocalizations.of(context).translate("entertainment"),
    ];
  }

  static const noConnectionErrorMessage = 'Not connected to a network!';
}