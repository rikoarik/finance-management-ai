import 'package:freezed_annotation/freezed_annotation.dart';

part 'analytics_event.freezed.dart';

enum TimeRange { week, month, threeMonths, year, all }

@freezed
class AnalyticsEvent with _$AnalyticsEvent {
  const factory AnalyticsEvent.loadAnalytics() = LoadAnalytics;
  const factory AnalyticsEvent.changeTimeRange(TimeRange range) = ChangeTimeRange;
  const factory AnalyticsEvent.refresh() = RefreshAnalytics;
}

