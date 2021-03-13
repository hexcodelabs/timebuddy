import 'package:timebuddy/constants/theme_data.dart';
import 'package:timebuddy/modals/alarm_info.dart';

List<AlarmInfo> alarms = [
  AlarmInfo(DateTime.now().add(Duration(hours: 1)),
      description: 'office', gradientColors: GradientColors.sky),
  AlarmInfo(DateTime.now().add(Duration(hours: 1)),
      description: 'Sport', gradientColors: GradientColors.sky),
  AlarmInfo(DateTime.now().add(Duration(hours: 1)),
      description: 'TV', gradientColors: GradientColors.sky),
  AlarmInfo(DateTime.now().add(Duration(hours: 1)),
      description: 'Study', gradientColors: GradientColors.sky),
  AlarmInfo(DateTime.now().add(Duration(hours: 1)),
      description: 'Sleep', gradientColors: GradientColors.sky),
];
