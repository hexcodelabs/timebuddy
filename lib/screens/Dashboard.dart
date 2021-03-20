import 'package:flutter/material.dart';
import 'package:timebuddy/screens/PlaningPage.dart';
import 'package:timebuddy/screens/startPlanPage.dart';
import 'package:timebuddy/theme/themes.dart';
import 'package:page_transition/page_transition.dart';
import 'package:intl/intl.dart';
import 'package:timebuddy/utils/Database.dart';
import 'package:timebuddy/modals/task.dart';
import 'dart:collection';

import 'package:timebuddy/localization/language_constants.dart';
import 'package:timebuddy/modals/priority.dart';
import 'package:timebuddy/main.dart';
import 'package:timebuddy/screens/settingsPage.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String quote = '\"${prefs.getString('quote')}\"';
  List<List<String>> inputFieldList = List<List<String>>();
  List<Task> _taskList;

  HashMap taskList;

  List<Map<String, dynamic>> activityList;

  Map<String, dynamic> currentActivity;
  Map<String, dynamic> nextActivity;
  int remainingActivities = 0;

  @override
  void initState() {
    _taskList = List<Task>();
    super.initState();
    setState(() {
      inputFieldList = [
        ["", "", ""],
      ];
    });
    getSchedule();
    getPriority();
  }

  getPriority() async {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    List<Priority> inputPriorityList = List<Priority>();

    List<Map<String, dynamic>> _results =
        await DBProvider.db.getPriorities(formattedDate);
    if (_results != null) {
      inputPriorityList =
          _results.map((item) => Priority.fromMap(item)).toList();

      inputFieldList = List<List<String>>();

      inputPriorityList.forEach((priority) {
        inputFieldList.add(["", "", ""]);
      });
      inputPriorityList.forEach((priority) {
        if (priority.priority == "") {
        } else {
          setState(() {
            inputFieldList[priority.index][0] = priority.priority;
            inputFieldList[priority.index][1] = priority.completed.toString();
            inputFieldList[priority.index][2] = priority.id.toString();
          });
        }
      });

      if (inputFieldList.length == 3 && inputFieldList[2][0] == "") {
        inputFieldList.removeAt(2);
      }

      if (inputFieldList.length >= 2 && inputFieldList[1][0] == "") {
        inputFieldList.removeAt(1);
      }
      if (inputFieldList.length > 1 && inputFieldList[0][0] == "") {
        inputFieldList.removeAt(0);
      }
    } else {
      inputPriorityList = List<Priority>();
      setState(() {
        inputFieldList = [
          ["", "", ""]
        ];
      });
    }
    return inputPriorityList;
  }

  getSchedule() async {
    taskList = new HashMap<String, List<String>>();
    activityList = new List<Map<String, dynamic>>();
    currentActivity = null;
    nextActivity = null;
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    List<Map<String, dynamic>> _results =
        await DBProvider.db.getSchedule(formattedDate);
    if (_results != null) {
      setState(() {
        _taskList = _results.map((item) => Task.fromMap(item)).toList();
      });
    } else {
      _taskList = List<Task>();
    }

    _taskList.forEach((task) {
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

    return _taskList;
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
      searchForCurrentActivity(element);
    });
  }

  getPreviousHourHalf(String hour, String half) {
    if (hour == "00" && half == "1") {
      return "null";
    }

    int hourInt = int.parse(hour);

    if (half == "2") {
      return "$hour 1";
    } else {
      if (hourInt >= 11) {
        hourInt = hourInt - 1;
        hour = hourInt.toString();
        return "$hour 2";
      } else {
        hourInt = hourInt - 1;
        hour = "0" + hourInt.toString();
        return "$hour 2";
      }
    }
  }

  getNextHourHalf(String hour, String half) {
    if (hour == "23" && half == "2") {
      return "null";
    }

    int hourInt = int.parse(hour);

    if (half == "1") {
      return "$hour 2";
    } else {
      if (hourInt >= 9) {
        hourInt = hourInt + 1;
        hour = hourInt.toString();
        return "$hour 1";
      } else {
        hourInt = hourInt + 1;
        hour = "0" + hourInt.toString();
        return "$hour 1";
      }
    }
  }

  void searchForCurrentActivity(activity) {
    var now = new DateTime.now();

    List<String> activityStartHourHalf = activity['start'].split(" ");
    List<String> activityEndHourHalf = activity['end'].split(" ");

    int startHour = int.parse(activityStartHourHalf[0]);
    int endHour = int.parse(activityEndHourHalf[0]);

    DateFormat dateFormat = new DateFormat.Hm();
    final currentTime = DateTime.now();
    DateTime open = dateFormat.parse(
        "${activityStartHourHalf[0]}:${activityStartHourHalf[1] == "1" ? "00" : "30"}");
    open = new DateTime(now.year, now.month, now.day, open.hour, open.minute);
    DateTime close = dateFormat.parse(
        "${activityEndHourHalf[0]}:${activityEndHourHalf[1] == "1" ? "00" : "30"}");
    if (activityEndHourHalf[0] == "24" && activityEndHourHalf[1] == "0") {
      close = dateFormat.parse("${23}:${59}");
    }
    close =
        new DateTime(now.year, now.month, now.day, close.hour, close.minute);

    if (currentTime.isAfter(open) && currentTime.isBefore(close)) {
      String currentTimeString = DateFormat('HH:mm').format(now);
      List<String> currentHourHalf = currentTimeString.split(":");
      int currentHour = int.parse(currentHourHalf[0]);
      int currentminute = int.parse(currentHourHalf[1]);
      int endHalf = activityEndHourHalf[1] == "1" ? 0 : 30;
      int difference =
          (endHour * 60 + endHalf) - (currentHour * 60 + currentminute);
      if (activityEndHourHalf[0] == "24" && activityEndHourHalf[1] == "0") {
        difference = difference + 29;
      }
      String closeTime = DateFormat('h:mm a').format(close);
      activity['difference'] = difference;
      activity['endTime'] = closeTime;
      setState(() {
        currentActivity = activity;
      });
      remainingActivities = activityList.last['id'] - currentActivity['id'] + 1;
      if (activityList[currentActivity['id'] - 1]['id'] !=
          activityList.last['id']) {
        int currentActivityID = currentActivity['id'];
        //String openTime = DateFormat('h:mm a').format(open);

        nextActivity = activityList[currentActivityID];
        List<String> activityStartHourHalfNext =
            activityList[currentActivityID]['start'].split(" ");
        DateTime opennext = dateFormat.parse(
            "${activityStartHourHalfNext[0]}:${activityStartHourHalfNext[1] == "1" ? "00" : "30"}");
        opennext = new DateTime(
            now.year, now.month, now.day, opennext.hour, opennext.minute);
        String openTimeNext = DateFormat('h:mm a').format(opennext);
        nextActivity['startTime'] = openTimeNext;
      }
    }

    String currentTimeString = DateFormat('HH:mm').format(now);
    List<String> currentHourHalf = currentTimeString.split(":");
    int currentHour = int.parse(currentHourHalf[0]);
    int currentminute = int.parse(currentHourHalf[1]);

    if (currentHour == 23 && currentminute >= 30) {
      activity['difference'] = 60 - currentminute;
      activity['endTime'] = "12:00";
      setState(() {
        currentActivity = activity;
      });
    }

    if (currentActivity == null && nextActivity == null) {
      if (currentTime.isBefore(open)) {
        String currentTimeString = DateFormat('HH:mm').format(now);
        List<String> currentHourHalf = currentTimeString.split(":");
        int currentHour = int.parse(currentHourHalf[0]);
        int currentminute = int.parse(currentHourHalf[1]);
        int startHalf = activityStartHourHalf[1] == "1" ? 0 : 30;
        int difference =
            (startHour * 60 + startHalf) - (currentHour * 60 + currentminute);
        String openTime = DateFormat('h:mm a').format(open);
        activity['startTime'] = openTime;
        activity['difference'] = difference;
        setState(() {
          nextActivity = activity;
        });
        remainingActivities = activityList.last['id'] - nextActivity['id'] + 1;
      }
    }
    DateTime finalTime = dateFormat.parse("${23}:${30}");
    finalTime = new DateTime(currentTime.year, currentTime.month,
        currentTime.day, finalTime.hour, finalTime.minute);

    if (currentTime.isAfter(finalTime)) {
      setState(() {
        nextActivity = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var now = new DateTime.now();

    String currentTime = DateFormat('h:mm a').format(now);
    String currentDay = DateFormat('EEEE').format(DateTime.now());

    double topHeight = height * 0.18;

    return Scaffold(
      backgroundColor: Color(0xff00a4ea),
      body: Stack(
        children: [
          Container(
            width: width,
            height: height,
            decoration: AppTheme.backgroundGradient,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: topHeight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Dashboard",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '$currentTime - $currentDay',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      height: height - topHeight,
                      width: width,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 33, right: 33),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 25, bottom: 19),
                                child: Text(
                                  getTranslated(context, 'dashboard_text_1'),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff57C3ff),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            ActivityTable(currentActivity, nextActivity),
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 15, bottom: 25),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType
                                                  .bottomToTop,
                                              child:
                                                  PlaningPage(readOnly: true)));
                                    },
                                    child: Container(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        getTranslated(
                                            context, 'dashboard_text_9'),
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xffc7c7c7)),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    ' | ',
                                    style: TextStyle(
                                        fontSize: 14, color: Color(0xffc7c7c7)),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType
                                                  .bottomToTop,
                                              child: PlaningPage(
                                                  readOnly: false)));
                                    },
                                    child: Container(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        getTranslated(
                                            context, 'dashboard_text_9_1'),
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xffc7c7c7)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 5, bottom: 5),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Color(0xff57C3ff),
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.star_rate_rounded,
                                      size: 30,
                                      color: Colors.yellowAccent[700],
                                    ),
                                  ),
                                ),
                                Text(
                                  "Priorities today",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Container(
                              // constraints: BoxConstraints(
                              //   minHeight: 100,
                              // ),
                              child: inputFieldList.length == 1 &&
                                      inputFieldList[0][0] == ""
                                  ? null
                                  : ListView.builder(
                                      padding: const EdgeInsets.all(0),
                                      shrinkWrap: true,
                                      itemCount: inputFieldList.length,
                                      itemBuilder:
                                          (BuildContext ctxt, int index) {
                                        return inputField(context,
                                            inputFieldList[index], index);
                                      }),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                top: 30,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '$remainingActivities',
                                    style: TextStyle(
                                        fontSize: 36, color: Color(0xff57C3ff)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                bottom: 10,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    getTranslated(context, 'dashboard_text_10'),
                                    style: TextStyle(
                                        fontSize: 14, color: Color(0xff57C3ff)),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                                left: 45,
                                right: 45,
                              ),
                              child: Text(
                                quote,
                                style: TextStyle(
                                    color: Color(0xff57C3ff), fontSize: 24),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.bottomToTop,
                                        child: SettingsPage()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Container(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    getTranslated(context, 'dashboard_text_11'),
                                    style: TextStyle(
                                        fontSize: 24, color: Color(0xffc7c7c7)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xE7F6FFFF),
                        borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(40.0),
                          topRight: const Radius.circular(40.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: topHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.bottomToTop,
                            child: StartPlanPage()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  inputField(context, inputField, index) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () async {
                    if (inputFieldList[index][1] == "0") {
                      setState(() {
                        inputFieldList[index][1] = "1";
                      });
                      await DBProvider.db
                          .changePriorityStatus(inputFieldList[index][2], 1);
                    } else {
                      setState(() {
                        inputFieldList[index][1] = "0";
                      });
                      await DBProvider.db
                          .changePriorityStatus(inputFieldList[index][2], 0);
                    }
                  },
                  child: Container(
                    height: 30,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff57C3ff)),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 45, right: 45),
                      child: Text(
                        inputField[0],
                        style: TextStyle(
                          color: Color(0xff57C3ff),
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (inputFieldList[index][1] == "0") {
                      setState(() {
                        inputFieldList[index][1] = "1";
                      });
                      await DBProvider.db
                          .changePriorityStatus(inputFieldList[index][2], 1);
                    } else {
                      setState(() {
                        inputFieldList[index][1] = "0";
                      });
                      await DBProvider.db
                          .changePriorityStatus(inputFieldList[index][2], 0);
                    }
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff57C3ff)),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: inputField[1] == "1"
                        ? Icon(
                            Icons.check_rounded,
                            size: 30,
                            color: Colors.green[800],
                          )
                        : Icon(
                            Icons.clear_rounded,
                            size: 30,
                            color: Colors.red[800],
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ActivityTable extends StatefulWidget {
  ActivityTable(this.currentActivity, this.nextActivity);

  Map<String, dynamic> currentActivity;
  Map<String, dynamic> nextActivity;

  @override
  _ActivityTableState createState() => _ActivityTableState();
}

class _ActivityTableState extends State<ActivityTable> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Table(
              columnWidths: {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1.5),
              },
              border: TableBorder.all(style: BorderStyle.none),
              children: [
                TableRow(children: [
                  Text(''),
                  Text(
                      '${widget.currentActivity != null ? widget.currentActivity['task'] : "No activity"}'),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 9),
                    child: Text(
                      getTranslated(context, 'dashboard_text_3'),
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff57C3ff),
                      ),
                    ),
                  ),
                  Text(''),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 9),
                    child: Text(''),
                  ),
                  Text(
                      '${widget.currentActivity != null ? widget.currentActivity['difference'].toString() + " minutes longer until " + widget.currentActivity['endTime'] : widget.nextActivity != null ? widget.nextActivity['difference'].toString() + " minutes longer until " + widget.nextActivity['startTime'] : ""}'),
                ]),
                TableRow(children: [
                  Text(
                    getTranslated(context, 'dashboard_text_5'),
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff57C3ff),
                    ),
                  ),
                  Text(''),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 9),
                    child: Text(''),
                  ),
                  Text(
                      '${widget.nextActivity != null ? widget.nextActivity['task'] : "No activity"}'),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 9),
                    child: Text(
                      getTranslated(context, 'dashboard_text_7'),
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff57C3ff),
                      ),
                    ),
                  ),
                  Text(''),
                ]),
                TableRow(children: [
                  Text(''),
                  Text(
                      '${widget.nextActivity != null ? widget.nextActivity['startTime'] : ""}'),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
