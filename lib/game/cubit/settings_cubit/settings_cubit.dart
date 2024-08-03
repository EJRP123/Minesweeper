import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial.defaultSettings());

  void changeColor0(Color col0) {
    emit(SettingsInitial(
        col0,
        state.nb1,
        state.nb2,
        state.nb3,
        state.nb4,
        state.nb5,
        state.nb6,
        state.nb7,
        state.nb8,
        state.nb9,
        state.borderColor,
        state.backgroundColor));
  }

  void changeColor1(Color col1) {
    emit(SettingsInitial(
        state.nb0,
        col1,
        state.nb2,
        state.nb3,
        state.nb4,
        state.nb5,
        state.nb6,
        state.nb7,
        state.nb8,
        state.nb9,
        state.borderColor,
        state.backgroundColor));
  }

  void changeColor2(Color col2) {
    emit(SettingsInitial(
        state.nb0,
        state.nb1,
        col2,
        state.nb3,
        state.nb4,
        state.nb5,
        state.nb6,
        state.nb7,
        state.nb8,
        state.nb9,
        state.borderColor,
        state.backgroundColor));
  }

  void changeColor3(Color col3) {
    emit(SettingsInitial(
        state.nb0,
        state.nb1,
        state.nb2,
        col3,
        state.nb4,
        state.nb5,
        state.nb6,
        state.nb7,
        state.nb8,
        state.nb9,
        state.borderColor,
        state.backgroundColor));
  }

  void changeColor4(Color col4) {
    emit(SettingsInitial(
        state.nb0,
        state.nb1,
        state.nb2,
        state.nb3,
        col4,
        state.nb5,
        state.nb6,
        state.nb7,
        state.nb8,
        state.nb9,
        state.borderColor,
        state.backgroundColor));
  }

  void changeColor5(Color col5) {
    emit(SettingsInitial(
        state.nb0,
        state.nb1,
        state.nb2,
        state.nb3,
        state.nb4,
        col5,
        state.nb6,
        state.nb7,
        state.nb8,
        state.nb9,
        state.borderColor,
        state.backgroundColor));
  }

  void changeColor6(Color col6) {
    emit(SettingsInitial(
        state.nb0,
        state.nb1,
        state.nb2,
        state.nb3,
        state.nb4,
        state.nb5,
        col6,
        state.nb7,
        state.nb8,
        state.nb9,
        state.borderColor,
        state.backgroundColor));
  }

  void changeColor7(Color col7) {
    emit(SettingsInitial(
        state.nb0,
        state.nb1,
        state.nb2,
        state.nb3,
        state.nb4,
        state.nb5,
        state.nb6,
        col7,
        state.nb8,
        state.nb9,
        state.borderColor,
        state.backgroundColor));
  }


  void changeColor8(Color col8) {
    emit(SettingsInitial(
        state.nb0,
        state.nb1,
        state.nb2,
        state.nb3,
        state.nb4,
        state.nb5,
        state.nb6,
        state.nb7,
        col8,
        state.nb9,
        state.borderColor,
        state.backgroundColor));
  }

  void changeColor9(Color col9) {
    emit(SettingsInitial(
        state.nb0,
        state.nb1,
        state.nb2,
        state.nb3,
        state.nb4,
        state.nb5,
        state.nb6,
        state.nb7,
        state.nb8,
        col9,
        state.borderColor,
        state.backgroundColor));
  }

  void changeBorderColor(Color borderColor) {
    emit(SettingsInitial(
        state.nb0,
        state.nb1,
        state.nb2,
        state.nb3,
        state.nb4,
        state.nb5,
        state.nb6,
        state.nb7,
        state.nb8,
        state.nb9,
        borderColor,
        state.backgroundColor));
  }

  void changeBackgroundColor(Color backgroundColor) {
    emit(SettingsInitial(
        state.nb0,
        state.nb1,
        state.nb2,
        state.nb3,
        state.nb4,
        state.nb5,
        state.nb6,
        state.nb7,
        state.nb8,
        state.nb9,
        state.borderColor,
        backgroundColor));
  }
}
