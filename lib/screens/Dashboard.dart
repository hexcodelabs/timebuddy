import 'package:flutter/material.dart';
import 'package:timebuddy/theme/themes.dart';
import 'package:page_transition/page_transition.dart';
import 'package:intl/intl.dart';
import 'package:timebuddy/utils/Database.dart';
import 'package:timebuddy/modals/task.dart';
import 'dart:collection';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  static var now = new DateTime.now();
  static var formatter = new DateFormat('yyyy-MM-dd');
  String formattedDate = formatter.format(now);

  List<Task> _taskList;

  HashMap colorMap = new HashMap<String, Color>();

  @override
  void initState() {
    _taskList = List<Task>();
    super.initState();

    getSchedule();
  }

  getSchedule() async {
    List<Task> _taskList2;
    List<Map<String, dynamic>> _results =
        await DBProvider.db.getSchedule(formattedDate);
    if (_results != null) {
      // setState(() {
      //   _taskList2 = _results.map((item) => Task.fromMap(item)).toList();
      // });
      setState(() {
        _taskList = _results.map((item) => Task.fromMap(item)).toList();
      });
      debugPrint(_taskList[18].id.toString());
    } else {
      _taskList2 = List<Task>();
    }
    debugPrint("a" + _taskList.length.toString());
    _taskList.map((task) => debugPrint(
        "${task.id}, ${task.date}, ${task.hour},${task.half},${task.task},${task.color}"));

    return _taskList;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    var now = new DateTime.now();
    String currentTime = DateFormat('h:mm a').format(now);
    String currentDay = DateFormat('EEEE').format(DateTime.now());

    String quote = "\"Time is what we want most, but what we use worst\"";

    double topHeight = height * 0.18;

    return Scaffold(
      backgroundColor: Color(0xff00a4ea),
      body: Container(
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
                            padding: const EdgeInsets.only(top: 25, bottom: 19),
                            child: Text(
                              "Current doing according to schedule",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff57C3ff),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        ActivityTable(),
                        Container(
                          margin: const EdgeInsets.only(top: 30, bottom: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.bottomToTop,
                                          child: Dashboard()));
                                },
                                child: Container(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    'View schedule',
                                    style: TextStyle(
                                        fontSize: 14, color: Color(0xffc7c7c7)),
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
                                          type: PageTransitionType.bottomToTop,
                                          child: Dashboard()));
                                },
                                child: Container(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    'Edit schedule',
                                    style: TextStyle(
                                        fontSize: 14, color: Color(0xffc7c7c7)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '8',
                                style: TextStyle(
                                    fontSize: 36, color: Color(0xff57C3ff)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'avtivities left today',
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
                                    child: Dashboard()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Container(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                'Settings',
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
                    color: Colors.white,
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
    );
  }
}

class ActivityTable extends StatelessWidget {
  const ActivityTable({
    Key key,
  }) : super(key: key);

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
                  Text('Writing my english essay'),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 9),
                    child: Text(
                      'for',
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
                  Text('34 minutes longer until 9 AM'),
                ]),
                TableRow(children: [
                  Text(
                    'then',
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
                  Text('Bicycle ride in the forest'),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 9),
                    child: Text(
                      'starting at',
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
                  Text('9:30 AM'),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
