// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'export_import_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ExportImportEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime? startDate, DateTime? endDate)
    exportToCsv,
    required TResult Function(DateTime? startDate, DateTime? endDate)
    exportToPdf,
    required TResult Function() importFromCsv,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime? startDate, DateTime? endDate)? exportToCsv,
    TResult? Function(DateTime? startDate, DateTime? endDate)? exportToPdf,
    TResult? Function()? importFromCsv,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime? startDate, DateTime? endDate)? exportToCsv,
    TResult Function(DateTime? startDate, DateTime? endDate)? exportToPdf,
    TResult Function()? importFromCsv,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExportToCsv value) exportToCsv,
    required TResult Function(ExportToPdf value) exportToPdf,
    required TResult Function(ImportFromCsv value) importFromCsv,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExportToCsv value)? exportToCsv,
    TResult? Function(ExportToPdf value)? exportToPdf,
    TResult? Function(ImportFromCsv value)? importFromCsv,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExportToCsv value)? exportToCsv,
    TResult Function(ExportToPdf value)? exportToPdf,
    TResult Function(ImportFromCsv value)? importFromCsv,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExportImportEventCopyWith<$Res> {
  factory $ExportImportEventCopyWith(
    ExportImportEvent value,
    $Res Function(ExportImportEvent) then,
  ) = _$ExportImportEventCopyWithImpl<$Res, ExportImportEvent>;
}

/// @nodoc
class _$ExportImportEventCopyWithImpl<$Res, $Val extends ExportImportEvent>
    implements $ExportImportEventCopyWith<$Res> {
  _$ExportImportEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExportImportEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ExportToCsvImplCopyWith<$Res> {
  factory _$$ExportToCsvImplCopyWith(
    _$ExportToCsvImpl value,
    $Res Function(_$ExportToCsvImpl) then,
  ) = __$$ExportToCsvImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime? startDate, DateTime? endDate});
}

/// @nodoc
class __$$ExportToCsvImplCopyWithImpl<$Res>
    extends _$ExportImportEventCopyWithImpl<$Res, _$ExportToCsvImpl>
    implements _$$ExportToCsvImplCopyWith<$Res> {
  __$$ExportToCsvImplCopyWithImpl(
    _$ExportToCsvImpl _value,
    $Res Function(_$ExportToCsvImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExportImportEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? startDate = freezed, Object? endDate = freezed}) {
    return _then(
      _$ExportToCsvImpl(
        startDate: freezed == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$ExportToCsvImpl implements ExportToCsv {
  const _$ExportToCsvImpl({this.startDate, this.endDate});

  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;

  @override
  String toString() {
    return 'ExportImportEvent.exportToCsv(startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExportToCsvImpl &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, startDate, endDate);

  /// Create a copy of ExportImportEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExportToCsvImplCopyWith<_$ExportToCsvImpl> get copyWith =>
      __$$ExportToCsvImplCopyWithImpl<_$ExportToCsvImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime? startDate, DateTime? endDate)
    exportToCsv,
    required TResult Function(DateTime? startDate, DateTime? endDate)
    exportToPdf,
    required TResult Function() importFromCsv,
  }) {
    return exportToCsv(startDate, endDate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime? startDate, DateTime? endDate)? exportToCsv,
    TResult? Function(DateTime? startDate, DateTime? endDate)? exportToPdf,
    TResult? Function()? importFromCsv,
  }) {
    return exportToCsv?.call(startDate, endDate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime? startDate, DateTime? endDate)? exportToCsv,
    TResult Function(DateTime? startDate, DateTime? endDate)? exportToPdf,
    TResult Function()? importFromCsv,
    required TResult orElse(),
  }) {
    if (exportToCsv != null) {
      return exportToCsv(startDate, endDate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExportToCsv value) exportToCsv,
    required TResult Function(ExportToPdf value) exportToPdf,
    required TResult Function(ImportFromCsv value) importFromCsv,
  }) {
    return exportToCsv(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExportToCsv value)? exportToCsv,
    TResult? Function(ExportToPdf value)? exportToPdf,
    TResult? Function(ImportFromCsv value)? importFromCsv,
  }) {
    return exportToCsv?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExportToCsv value)? exportToCsv,
    TResult Function(ExportToPdf value)? exportToPdf,
    TResult Function(ImportFromCsv value)? importFromCsv,
    required TResult orElse(),
  }) {
    if (exportToCsv != null) {
      return exportToCsv(this);
    }
    return orElse();
  }
}

abstract class ExportToCsv implements ExportImportEvent {
  const factory ExportToCsv({
    final DateTime? startDate,
    final DateTime? endDate,
  }) = _$ExportToCsvImpl;

  DateTime? get startDate;
  DateTime? get endDate;

  /// Create a copy of ExportImportEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExportToCsvImplCopyWith<_$ExportToCsvImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ExportToPdfImplCopyWith<$Res> {
  factory _$$ExportToPdfImplCopyWith(
    _$ExportToPdfImpl value,
    $Res Function(_$ExportToPdfImpl) then,
  ) = __$$ExportToPdfImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime? startDate, DateTime? endDate});
}

/// @nodoc
class __$$ExportToPdfImplCopyWithImpl<$Res>
    extends _$ExportImportEventCopyWithImpl<$Res, _$ExportToPdfImpl>
    implements _$$ExportToPdfImplCopyWith<$Res> {
  __$$ExportToPdfImplCopyWithImpl(
    _$ExportToPdfImpl _value,
    $Res Function(_$ExportToPdfImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExportImportEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? startDate = freezed, Object? endDate = freezed}) {
    return _then(
      _$ExportToPdfImpl(
        startDate: freezed == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$ExportToPdfImpl implements ExportToPdf {
  const _$ExportToPdfImpl({this.startDate, this.endDate});

  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;

  @override
  String toString() {
    return 'ExportImportEvent.exportToPdf(startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExportToPdfImpl &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, startDate, endDate);

  /// Create a copy of ExportImportEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExportToPdfImplCopyWith<_$ExportToPdfImpl> get copyWith =>
      __$$ExportToPdfImplCopyWithImpl<_$ExportToPdfImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime? startDate, DateTime? endDate)
    exportToCsv,
    required TResult Function(DateTime? startDate, DateTime? endDate)
    exportToPdf,
    required TResult Function() importFromCsv,
  }) {
    return exportToPdf(startDate, endDate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime? startDate, DateTime? endDate)? exportToCsv,
    TResult? Function(DateTime? startDate, DateTime? endDate)? exportToPdf,
    TResult? Function()? importFromCsv,
  }) {
    return exportToPdf?.call(startDate, endDate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime? startDate, DateTime? endDate)? exportToCsv,
    TResult Function(DateTime? startDate, DateTime? endDate)? exportToPdf,
    TResult Function()? importFromCsv,
    required TResult orElse(),
  }) {
    if (exportToPdf != null) {
      return exportToPdf(startDate, endDate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExportToCsv value) exportToCsv,
    required TResult Function(ExportToPdf value) exportToPdf,
    required TResult Function(ImportFromCsv value) importFromCsv,
  }) {
    return exportToPdf(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExportToCsv value)? exportToCsv,
    TResult? Function(ExportToPdf value)? exportToPdf,
    TResult? Function(ImportFromCsv value)? importFromCsv,
  }) {
    return exportToPdf?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExportToCsv value)? exportToCsv,
    TResult Function(ExportToPdf value)? exportToPdf,
    TResult Function(ImportFromCsv value)? importFromCsv,
    required TResult orElse(),
  }) {
    if (exportToPdf != null) {
      return exportToPdf(this);
    }
    return orElse();
  }
}

abstract class ExportToPdf implements ExportImportEvent {
  const factory ExportToPdf({
    final DateTime? startDate,
    final DateTime? endDate,
  }) = _$ExportToPdfImpl;

  DateTime? get startDate;
  DateTime? get endDate;

  /// Create a copy of ExportImportEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExportToPdfImplCopyWith<_$ExportToPdfImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ImportFromCsvImplCopyWith<$Res> {
  factory _$$ImportFromCsvImplCopyWith(
    _$ImportFromCsvImpl value,
    $Res Function(_$ImportFromCsvImpl) then,
  ) = __$$ImportFromCsvImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ImportFromCsvImplCopyWithImpl<$Res>
    extends _$ExportImportEventCopyWithImpl<$Res, _$ImportFromCsvImpl>
    implements _$$ImportFromCsvImplCopyWith<$Res> {
  __$$ImportFromCsvImplCopyWithImpl(
    _$ImportFromCsvImpl _value,
    $Res Function(_$ImportFromCsvImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExportImportEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ImportFromCsvImpl implements ImportFromCsv {
  const _$ImportFromCsvImpl();

  @override
  String toString() {
    return 'ExportImportEvent.importFromCsv()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ImportFromCsvImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime? startDate, DateTime? endDate)
    exportToCsv,
    required TResult Function(DateTime? startDate, DateTime? endDate)
    exportToPdf,
    required TResult Function() importFromCsv,
  }) {
    return importFromCsv();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime? startDate, DateTime? endDate)? exportToCsv,
    TResult? Function(DateTime? startDate, DateTime? endDate)? exportToPdf,
    TResult? Function()? importFromCsv,
  }) {
    return importFromCsv?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime? startDate, DateTime? endDate)? exportToCsv,
    TResult Function(DateTime? startDate, DateTime? endDate)? exportToPdf,
    TResult Function()? importFromCsv,
    required TResult orElse(),
  }) {
    if (importFromCsv != null) {
      return importFromCsv();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExportToCsv value) exportToCsv,
    required TResult Function(ExportToPdf value) exportToPdf,
    required TResult Function(ImportFromCsv value) importFromCsv,
  }) {
    return importFromCsv(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExportToCsv value)? exportToCsv,
    TResult? Function(ExportToPdf value)? exportToPdf,
    TResult? Function(ImportFromCsv value)? importFromCsv,
  }) {
    return importFromCsv?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExportToCsv value)? exportToCsv,
    TResult Function(ExportToPdf value)? exportToPdf,
    TResult Function(ImportFromCsv value)? importFromCsv,
    required TResult orElse(),
  }) {
    if (importFromCsv != null) {
      return importFromCsv(this);
    }
    return orElse();
  }
}

abstract class ImportFromCsv implements ExportImportEvent {
  const factory ImportFromCsv() = _$ImportFromCsvImpl;
}
