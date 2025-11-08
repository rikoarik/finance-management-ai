import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState()) {
    on<SetThemeMode>(_onSetThemeMode);
    on<ToggleTheme>(_onToggleTheme);
  }

  void _onSetThemeMode(SetThemeMode event, Emitter<ThemeState> emit) {
    emit(state.copyWith(themeMode: event.mode));
  }

  void _onToggleTheme(ToggleTheme event, Emitter<ThemeState> emit) {
    final newMode = state.themeMode == ThemeMode.light 
        ? ThemeMode.dark 
        : ThemeMode.light;
    emit(state.copyWith(themeMode: newMode));
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    try {
      return ThemeState.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    try {
      return state.toJson();
    } catch (_) {
      return null;
    }
  }
}

