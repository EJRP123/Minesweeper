import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(super.initial);

  void changeColor0(Color col0) {
    emit(SettingsInitial(
        nb0: col0,
        nb1: state.nb1,
        nb2: state.nb2,
        nb3: state.nb3,
        nb4: state.nb4,
        nb5: state.nb5,
        nb6: state.nb6,
        nb7: state.nb7,
        nb8: state.nb8,
        nb9: state.nb9,
        borderColor:     state.borderColor,
        backgroundColor: state.backgroundColor));
  }

  void changeColor1(Color col1) {
    emit(SettingsInitial(
        nb0: state.nb0,
        nb1: col1,
        nb2: state.nb2,
        nb3: state.nb3,
        nb4: state.nb4,
        nb5: state.nb5,
        nb6: state.nb6,
        nb7: state.nb7,
        nb8: state.nb8,
        nb9: state.nb9,
        borderColor:     state.borderColor,
        backgroundColor: state.backgroundColor));
  }

  void changeColor2(Color col2) {
    emit(SettingsInitial(
        nb0: state.nb0,
        nb1: state.nb1,
        nb2: col2,
        nb3: state.nb3,
        nb4: state.nb4,
        nb5: state.nb5,
        nb6: state.nb6,
        nb7: state.nb7,
        nb8: state.nb8,
        nb9: state.nb9,
        borderColor:     state.borderColor,
        backgroundColor: state.backgroundColor));
  }

  void changeColor3(Color col3) {
    emit(SettingsInitial(
        nb0: state.nb0,
        nb1: state.nb1,
        nb2: state.nb2,
        nb3: col3,
        nb4: state.nb4,
        nb5: state.nb5,
        nb6: state.nb6,
        nb7: state.nb7,
        nb8: state.nb8,
        nb9: state.nb9,
        borderColor:     state.borderColor,
        backgroundColor: state.backgroundColor));
  }

  void changeColor4(Color col4) {
    emit(SettingsInitial(
        nb0: state.nb0,
        nb1: state.nb1,
        nb2: state.nb2,
        nb3: state.nb3,
        nb4: col4,
        nb5: state.nb5,
        nb6: state.nb6,
        nb7: state.nb7,
        nb8: state.nb8,
        nb9: state.nb9,
        borderColor:     state.borderColor,
        backgroundColor: state.backgroundColor));
  }

  void changeColor5(Color col5) {
    emit(SettingsInitial(
        nb0: state.nb0,
        nb1: state.nb1,
        nb2: state.nb2,
        nb3: state.nb3,
        nb4: state.nb4,
        nb5: col5,
        nb6: state.nb6,
        nb7: state.nb7,
        nb8: state.nb8,
        nb9: state.nb9,
        borderColor:     state.borderColor,
        backgroundColor: state.backgroundColor));
  }

  void changeColor6(Color col6) {
    emit(SettingsInitial(
        nb0: state.nb0,
        nb1: state.nb1,
        nb2: state.nb2,
        nb3: state.nb3,
        nb4: state.nb4,
        nb5: state.nb5,
        nb6: col6,
        nb7: state.nb7,
        nb8: state.nb8,
        nb9: state.nb9,
        borderColor:     state.borderColor,
        backgroundColor: state.backgroundColor));
  }

  void changeColor7(Color col7) {
    emit(SettingsInitial(
        nb0: state.nb0,
        nb1: state.nb1,
        nb2: state.nb2,
        nb3: state.nb3,
        nb4: state.nb4,
        nb5: state.nb5,
        nb6: state.nb6,
        nb7: col7,
        nb8: state.nb8,
        nb9: state.nb9,
        borderColor:     state.borderColor,
        backgroundColor: state.backgroundColor));
  }

  void changeColor8(Color col8) {
    emit(SettingsInitial(
        nb0: state.nb0,
        nb1: state.nb1,
        nb2: state.nb2,
        nb3: state.nb3,
        nb4: state.nb4,
        nb5: state.nb5,
        nb6: state.nb6,
        nb7: state.nb7,
        nb8: col8,
        nb9: state.nb9,
        borderColor:     state.borderColor,
        backgroundColor: state.backgroundColor));
  }

  void changeColor9(Color col9) {
    emit(SettingsInitial(
        nb0: state.nb0,
        nb1: state.nb1,
        nb2: state.nb2,
        nb3: state.nb3,
        nb4: state.nb4,
        nb5: state.nb5,
        nb6: state.nb6,
        nb7: state.nb7,
        nb8: state.nb8,
        nb9: col9,
        borderColor:     state.borderColor,
        backgroundColor: state.backgroundColor));
  }

  void changeBorderColor(Color borderColor) {
    emit(SettingsInitial(
        nb0: state.nb0,
        nb1: state.nb1,
        nb2: state.nb2,
        nb3: state.nb3,
        nb4: state.nb4,
        nb5: state.nb5,
        nb6: state.nb6,
        nb7: state.nb7,
        nb8: state.nb8,
        nb9: state.nb9,
        borderColor:     borderColor,
        backgroundColor: state.backgroundColor));
  }

  void changeBackgroundColor(Color backgroundColor) {
    emit(SettingsInitial(
        nb0: state.nb0,
        nb1: state.nb1,
        nb2: state.nb2,
        nb3: state.nb3,
        nb4: state.nb4,
        nb5: state.nb5,
        nb6: state.nb6,
        nb7: state.nb7,
        nb8: state.nb8,
        nb9: state.nb9,
        borderColor:     state.borderColor,
        backgroundColor: backgroundColor));
  }
}
