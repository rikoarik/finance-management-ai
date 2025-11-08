// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'analytics_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AnalyticsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadAnalytics,
    required TResult Function(TimeRange range) changeTimeRange,
    required TResult Function() refresh,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadAnalytics,
    TResult? Function(TimeRange range)? changeTimeRange,
    TResult? Function()? refresh,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadAnalytics,
    TResult Function(TimeRange range)? changeTimeRange,
    TResult Function()? refresh,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadAnalytics value) loadAnalytics,
    required TResult Function(ChangeTimeRange value) changeTimeRange,
    required TResult Function(RefreshAnalytics value) refresh,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadAnalytics value)? loadAnalytics,
    TResult? Function(ChangeTimeRange value)? changeTimeRange,
    TResult? Function(RefreshAnalytics value)? refresh,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadAnalytics value)? loadAnalytics,
    TResult Function(ChangeTimeRange value)? changeTimeRange,
    TResult Function(RefreshAnalytics value)? refresh,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalyticsEventCopyWith<$Res> {
  factory $AnalyticsEventCopyWith(
    AnalyticsEvent value,
    $Res Function(AnalyticsEvent) then,
  ) = _$AnalyticsEventCopyWithImpl<$Res, AnalyticsEvent>;
}

/// @nodoc
class _$AnalyticsEventCopyWithImpl<$Res, $Val extends AnalyticsEvent>
    implements $AnalyticsEventCopyWith<$Res> {
  _$AnalyticsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnalyticsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadAnalyticsImplCopyWith<$Res> {
  factory _$$LoadAnalyticsImplCopyWith(
    _$LoadAnalyticsImpl value,
    $Res Function(_$LoadAnalyticsImpl) then,
  ) = __$$LoadAnalyticsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadAnalyticsImplCopyWithImpl<$Res>
    extends _$AnalyticsEventCopyWithImpl<$Res, _$LoadAnalyticsImpl>
    implements _$$LoadAnalyticsImplCopyWith<$Res> {
  __$$LoadAnalyticsImplCopyWithImpl(
    _$LoadAnalyticsImpl _value,
    $Res Function(_$LoadAnalyticsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AnalyticsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadAnalyticsImpl implements LoadAnalytics {
  const _$LoadAnalyticsImpl();

  @override
  String toString() {
    return 'AnalyticsEvent.loadAnalytics()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadAnalyticsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadAnalytics,
    required TResult Function(TimeRange range) changeTimeRange,
    required TResult Function() refresh,
  }) {
    return loadAnalytics();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadAnalytics,
    TResult? Function(TimeRange range)? changeTimeRange,
    TResult? Function()? refresh,
  }) {
    return loadAnalytics?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadAnalytics,
    TResult Function(TimeRange range)? changeTimeRange,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (loadAnalytics != null) {
      return loadAnalytics();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadAnalytics value) loadAnalytics,
    required TResult Function(ChangeTimeRange value) changeTimeRange,
    required TResult Function(RefreshAnalytics value) refresh,
  }) {
    return loadAnalytics(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadAnalytics value)? loadAnalytics,
    TResult? Function(ChangeTimeRange value)? changeTimeRange,
    TResult? Function(RefreshAnalytics value)? refresh,
  }) {
    return loadAnalytics?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadAnalytics value)? loadAnalytics,
    TResult Function(ChangeTimeRange value)? changeTimeRange,
    TResult Function(RefreshAnalytics value)? refresh,
    required TResult orElse(),
  }) {
    if (loadAnalytics != null) {
      return loadAnalytics(this);
    }
    return orElse();
  }
}

abstract class LoadAnalytics implements AnalyticsEvent {
  const factory LoadAnalytics() = _$LoadAnalyticsImpl;
}

/// @nodoc
abstract class _$$ChangeTimeRangeImplCopyWith<$Res> {
  factory _$$ChangeTimeRangeImplCopyWith(
    _$ChangeTimeRangeImpl value,
    $Res Function(_$ChangeTimeRangeImpl) then,
  ) = __$$ChangeTimeRangeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TimeRange range});
}

/// @nodoc
class __$$ChangeTimeRangeImplCopyWithImpl<$Res>
    extends _$AnalyticsEventCopyWithImpl<$Res, _$ChangeTimeRangeImpl>
    implements _$$ChangeTimeRangeImplCopyWith<$Res> {
  __$$ChangeTimeRangeImplCopyWithImpl(
    _$ChangeTimeRangeImpl _value,
    $Res Function(_$ChangeTimeRangeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AnalyticsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? range = null}) {
    return _then(
      _$ChangeTimeRangeImpl(
        null == range
            ? _value.range
            : range // ignore: cast_nullable_to_non_nullable
                  as TimeRange,
      ),
    );
  }
}

/// @nodoc

class _$ChangeTimeRangeImpl implements ChangeTimeRange {
  const _$ChangeTimeRangeImpl(this.range);

  @override
  final TimeRange range;

  @override
  String toString() {
    return 'AnalyticsEvent.changeTimeRange(range: $range)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeTimeRangeImpl &&
            (identical(other.range, range) || other.range == range));
  }

  @override
  int get hashCode => Object.hash(runtimeType, range);

  /// Create a copy of AnalyticsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeTimeRangeImplCopyWith<_$ChangeTimeRangeImpl> get copyWith =>
      __$$ChangeTimeRangeImplCopyWithImpl<_$ChangeTimeRangeImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadAnalytics,
    required TResult Function(TimeRange range) changeTimeRange,
    required TResult Function() refresh,
  }) {
    return changeTimeRange(range);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadAnalytics,
    TResult? Function(TimeRange range)? changeTimeRange,
    TResult? Function()? refresh,
  }) {
    return changeTimeRange?.call(range);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadAnalytics,
    TResult Function(TimeRange range)? changeTimeRange,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (changeTimeRange != null) {
      return changeTimeRange(range);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadAnalytics value) loadAnalytics,
    required TResult Function(ChangeTimeRange value) changeTimeRange,
    required TResult Function(RefreshAnalytics value) refresh,
  }) {
    return changeTimeRange(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadAnalytics value)? loadAnalytics,
    TResult? Function(ChangeTimeRange value)? changeTimeRange,
    TResult? Function(RefreshAnalytics value)? refresh,
  }) {
    return changeTimeRange?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadAnalytics value)? loadAnalytics,
    TResult Function(ChangeTimeRange value)? changeTimeRange,
    TResult Function(RefreshAnalytics value)? refresh,
    required TResult orElse(),
  }) {
    if (changeTimeRange != null) {
      return changeTimeRange(this);
    }
    return orElse();
  }
}

abstract class ChangeTimeRange implements AnalyticsEvent {
  const factory ChangeTimeRange(final TimeRange range) = _$ChangeTimeRangeImpl;

  TimeRange get range;

  /// Create a copy of AnalyticsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangeTimeRangeImplCopyWith<_$ChangeTimeRangeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RefreshAnalyticsImplCopyWith<$Res> {
  factory _$$RefreshAnalyticsImplCopyWith(
    _$RefreshAnalyticsImpl value,
    $Res Function(_$RefreshAnalyticsImpl) then,
  ) = __$$RefreshAnalyticsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RefreshAnalyticsImplCopyWithImpl<$Res>
    extends _$AnalyticsEventCopyWithImpl<$Res, _$RefreshAnalyticsImpl>
    implements _$$RefreshAnalyticsImplCopyWith<$Res> {
  __$$RefreshAnalyticsImplCopyWithImpl(
    _$RefreshAnalyticsImpl _value,
    $Res Function(_$RefreshAnalyticsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AnalyticsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RefreshAnalyticsImpl implements RefreshAnalytics {
  const _$RefreshAnalyticsImpl();

  @override
  String toString() {
    return 'AnalyticsEvent.refresh()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RefreshAnalyticsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadAnalytics,
    required TResult Function(TimeRange range) changeTimeRange,
    required TResult Function() refresh,
  }) {
    return refresh();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadAnalytics,
    TResult? Function(TimeRange range)? changeTimeRange,
    TResult? Function()? refresh,
  }) {
    return refresh?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadAnalytics,
    TResult Function(TimeRange range)? changeTimeRange,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadAnalytics value) loadAnalytics,
    required TResult Function(ChangeTimeRange value) changeTimeRange,
    required TResult Function(RefreshAnalytics value) refresh,
  }) {
    return refresh(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadAnalytics value)? loadAnalytics,
    TResult? Function(ChangeTimeRange value)? changeTimeRange,
    TResult? Function(RefreshAnalytics value)? refresh,
  }) {
    return refresh?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadAnalytics value)? loadAnalytics,
    TResult Function(ChangeTimeRange value)? changeTimeRange,
    TResult Function(RefreshAnalytics value)? refresh,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh(this);
    }
    return orElse();
  }
}

abstract class RefreshAnalytics implements AnalyticsEvent {
  const factory RefreshAnalytics() = _$RefreshAnalyticsImpl;
}
