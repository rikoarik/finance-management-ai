import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_event.freezed.dart';

@freezed
class ThemeEvent with _$ThemeEvent {
  const factory ThemeEvent.setThemeMode(ThemeMode mode) = SetThemeMode;
  const factory ThemeEvent.toggleTheme() = ToggleTheme;
}

