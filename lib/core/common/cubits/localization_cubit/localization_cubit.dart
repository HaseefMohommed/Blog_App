import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class LocalizationCubit extends Cubit<Locale> {
  LocalizationCubit() : super(const Locale('en'));

  void changeLocale(Locale locale) {
    emit(locale);
  }
}
