// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ThemeEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ThemeMode mode) setThemeMode,
    required TResult Function() toggleTheme,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ThemeMode mode)? setThemeMode,
    TResult? Function()? toggleTheme,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ThemeMode mode)? setThemeMode,
    TResult Function()? toggleTheme,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetThemeMode value) setThemeMode,
    required TResult Function(ToggleTheme value) toggleTheme,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetThemeMode value)? setThemeMode,
    TResult? Function(ToggleTheme value)? toggleTheme,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetThemeMode value)? setThemeMode,
    TResult Function(ToggleTheme value)? toggleTheme,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemeEventCopyWith<$Res> {
  factory $ThemeEventCopyWith(
    ThemeEvent value,
    $Res Function(ThemeEvent) then,
  ) = _$ThemeEventCopyWithImpl<$Res, ThemeEvent>;
}

/// @nodoc
class _$ThemeEventCopyWithImpl<$Res, $Val extends ThemeEvent>
    implements $ThemeEventCopyWith<$Res> {
  _$ThemeEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ThemeEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SetThemeModeImplCopyWith<$Res> {
  factory _$$SetThemeModeImplCopyWith(
    _$SetThemeModeImpl value,
    $Res Function(_$SetThemeModeImpl) then,
  ) = __$$SetThemeModeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ThemeMode mode});
}

/// @nodoc
class __$$SetThemeModeImplCopyWithImpl<$Res>
    extends _$ThemeEventCopyWithImpl<$Res, _$SetThemeModeImpl>
    implements _$$SetThemeModeImplCopyWith<$Res> {
  __$$SetThemeModeImplCopyWithImpl(
    _$SetThemeModeImpl _value,
    $Res Function(_$SetThemeModeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ThemeEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? mode = null}) {
    return _then(
      _$SetThemeModeImpl(
        null == mode
            ? _value.mode
            : mode // ignore: cast_nullable_to_non_nullable
                  as ThemeMode,
      ),
    );
  }
}

/// @nodoc

class _$SetThemeModeImpl implements SetThemeMode {
  const _$SetThemeModeImpl(this.mode);

  @override
  final ThemeMode mode;

  @override
  String toString() {
    return 'ThemeEvent.setThemeMode(mode: $mode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetThemeModeImpl &&
            (identical(other.mode, mode) || other.mode == mode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, mode);

  /// Create a copy of ThemeEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetThemeModeImplCopyWith<_$SetThemeModeImpl> get copyWith =>
      __$$SetThemeModeImplCopyWithImpl<_$SetThemeModeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ThemeMode mode) setThemeMode,
    required TResult Function() toggleTheme,
  }) {
    return setThemeMode(mode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ThemeMode mode)? setThemeMode,
    TResult? Function()? toggleTheme,
  }) {
    return setThemeMode?.call(mode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ThemeMode mode)? setThemeMode,
    TResult Function()? toggleTheme,
    required TResult orElse(),
  }) {
    if (setThemeMode != null) {
      return setThemeMode(mode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetThemeMode value) setThemeMode,
    required TResult Function(ToggleTheme value) toggleTheme,
  }) {
    return setThemeMode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetThemeMode value)? setThemeMode,
    TResult? Function(ToggleTheme value)? toggleTheme,
  }) {
    return setThemeMode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetThemeMode value)? setThemeMode,
    TResult Function(ToggleTheme value)? toggleTheme,
    required TResult orElse(),
  }) {
    if (setThemeMode != null) {
      return setThemeMode(this);
    }
    return orElse();
  }
}

abstract class SetThemeMode implements ThemeEvent {
  const factory SetThemeMode(final ThemeMode mode) = _$SetThemeModeImpl;

  ThemeMode get mode;

  /// Create a copy of ThemeEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetThemeModeImplCopyWith<_$SetThemeModeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ToggleThemeImplCopyWith<$Res> {
  factory _$$ToggleThemeImplCopyWith(
    _$ToggleThemeImpl value,
    $Res Function(_$ToggleThemeImpl) then,
  ) = __$$ToggleThemeImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ToggleThemeImplCopyWithImpl<$Res>
    extends _$ThemeEventCopyWithImpl<$Res, _$ToggleThemeImpl>
    implements _$$ToggleThemeImplCopyWith<$Res> {
  __$$ToggleThemeImplCopyWithImpl(
    _$ToggleThemeImpl _value,
    $Res Function(_$ToggleThemeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ThemeEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ToggleThemeImpl implements ToggleTheme {
  const _$ToggleThemeImpl();

  @override
  String toString() {
    return 'ThemeEvent.toggleTheme()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ToggleThemeImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ThemeMode mode) setThemeMode,
    required TResult Function() toggleTheme,
  }) {
    return toggleTheme();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ThemeMode mode)? setThemeMode,
    TResult? Function()? toggleTheme,
  }) {
    return toggleTheme?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ThemeMode mode)? setThemeMode,
    TResult Function()? toggleTheme,
    required TResult orElse(),
  }) {
    if (toggleTheme != null) {
      return toggleTheme();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetThemeMode value) setThemeMode,
    required TResult Function(ToggleTheme value) toggleTheme,
  }) {
    return toggleTheme(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetThemeMode value)? setThemeMode,
    TResult? Function(ToggleTheme value)? toggleTheme,
  }) {
    return toggleTheme?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetThemeMode value)? setThemeMode,
    TResult Function(ToggleTheme value)? toggleTheme,
    required TResult orElse(),
  }) {
    if (toggleTheme != null) {
      return toggleTheme(this);
    }
    return orElse();
  }
}

abstract class ToggleTheme implements ThemeEvent {
  const factory ToggleTheme() = _$ToggleThemeImpl;
}
