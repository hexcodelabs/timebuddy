import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timebuddy/modals/task.dart';
import 'package:intl/intl.dart';
import 'package:timebuddy/main.dart';
import 'dart:collection';
import 'package:timebuddy/utils/Database.dart';

import 'package:flutter/cupertino.dart';

class Controller {
  bool shedule;
  List<Task> _allTaskList;
  HashMap taskList;
  List<Map<String, dynamic>> activityList;

  Future scheduleAlarm(id, start, body) async {
    var now = new DateTime.now();

    List<String> activityStartHourHalf = start.split(" ");
    int startHour = int.parse(activityStartHourHalf[0]);
    int startHalf = activityStartHourHalf[1] == "1" ? 0 : 30;

    DateFormat dateFormat = new DateFormat.Hm();
    DateTime open = dateFormat.parse(
        "${activityStartHourHalf[0]}:${activityStartHourHalf[1] == "1" ? "00" : "30"}");
    open = new DateTime(now.year, now.month, now.day, open.hour, open.minute);

    if (now.isAfter(open)) {
      return;
    }
    String currentTimeString = DateFormat('HH:mm').format(now);
    List<String> currentHourHalf = currentTimeString.split(":");
    int currentHour = int.parse(currentHourHalf[0]);
    int currentminute = int.parse(currentHourHalf[1]);
    int difference =
        (startHour * 60 + startHalf) - (currentHour * 60 + currentminute);

    var scheduledNotificationDateTime =
        DateTime.now().add(Duration(minutes: difference));

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'appicon',
      largeIcon: DrawableResourceAndroidBitmap('appicon'),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(id, 'Time Buddy', body,
        scheduledNotificationDateTime, platformChannelSpecifics);
  }

  Future getSchedule() async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    taskList = new HashMap<String, List<String>>();
    activityList = new List<Map<String, dynamic>>();

    List<Map<String, dynamic>> _results =
        await DBProvider.db.getSchedule(formattedDate);
    if (_results != null) {
      _allTaskList = _results.map((item) => Task.fromMap(item)).toList();
    } else {
      _allTaskList = List<Task>();
    }

    _allTaskList.forEach((task) {
      List<String> a = List<String>();
      a.add(task.hour + task.half);
      a.add(task.task);
      a.add(task.color);
      a.add(task.previous);
      a.add(task.next);
      a.add(task.hour);
      a.add(task.half);
      taskList[task.hour + task.half] = a;
    });

    final sortedTaskList = new SplayTreeMap.from(
        taskList, (a, b) => int.parse(a).compareTo(int.parse(b)));
    getActivityList(sortedTaskList);

    return _allTaskList;
  }

  void getActivityList(sortedTaskList) {
    Map<String, dynamic> activity = null;
    bool activityEnded = true;
    sortedTaskList.forEach((key, task) {
      String hourHalf = task[0];
      String tsk = task[1];
      String color = task[2];
      String previous = task[3];
      String next = task[4];
      String hour = task[5];
      String half = task[6];

      if (previous == "false") {
        if (activityList.length == 0 &&
            tsk == "" &&
            next == "false" &&
            (color == "00000000" || color == "ffffffff" || color == null)) {
          if (!activityEnded) {
            activity["end"] = hour + " " + half;
            activityList.add(activity);
            activityEnded = true;
          }
        } else {
          if (activityList.length == 0 && activity == null) {
            activity = new Map<String, dynamic>();
            activityEnded = false;
            activity["id"] = 1;
            activity["start"] = hour + " " + half;
            if (tsk == "") {
              activity["task"] = "Task not defined";
            } else {
              activity["task"] = tsk;
            }
            activity["halfs"] = 1;
            if (hourHalf == "232") {
              //activity["end"] = hour + " " + half;
              activity["end"] = "24" + " " + "0";
              activityList.add(activity);
              activityEnded = true;
            }
          } else if (tsk == "" &&
              next == "false" &&
              (color == "00000000" || color == "ffffffff" || color == null)) {
            if (!activityEnded) {
              activity["end"] = hour + " " + half;
              activityList.add(activity);
              activityEnded = true;
            }
          } else {
            if (!activityEnded) {
              activity["end"] = hour + " " + half;
              activityList.add(activity);
              activityEnded = true;
            }

            activity = new Map<String, dynamic>();
            activityEnded = false;
            activity["id"] = activityList.last["id"] + 1;
            activity["start"] = hour + " " + half;
            if (tsk == "") {
              activity["task"] = "Task not defined";
            } else {
              activity["task"] = tsk;
            }

            activity["halfs"] = 1;
            if (hourHalf == "232") {
              //activity["end"] = hour + " " + half;
              activity["end"] = "24" + " " + "0";
              activityList.add(activity);
              activityEnded = true;
            }
          }
        }
      } else {
        activity["halfs"] = activity["halfs"] + 1;
        if (hourHalf == "232") {
          //activity["end"] = hour + " " + half;
          activity["end"] = "24" + " " + "0";
          activityList.add(activity);
          activityEnded = true;
        }
      }
    });
    activity = null;
    activityList.forEach((element) {
      scheduleAlarm(element['id'], element['start'], element['task']);
    });
  }
}
