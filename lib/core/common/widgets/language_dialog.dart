import 'package:blog_app/core/common/cubits/localization_cubit/localization_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageDialog extends StatelessWidget {
  const LanguageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Choose Language'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('English'),
            onTap: () {
              context.read<LocalizationCubit>().changeLocale(const Locale('en'));
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: const Text('Español'),
            onTap: () {
              context.read<LocalizationCubit>().changeLocale(const Locale('es'));
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: const Text('Sinhala'),
            onTap: () {
              context.read<LocalizationCubit>().changeLocale(const Locale('si'));
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }}