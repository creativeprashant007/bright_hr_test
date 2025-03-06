import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('en'));

  // basically this we implement when we need to have change the language of the application
  void changeLocale(Locale locale) {
    emit(locale);
  }
}
