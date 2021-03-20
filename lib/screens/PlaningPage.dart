import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'package:timebuddy/screens/completePlanPage.dart';
import 'package:timebuddy/screens/templatePage.dart';
import 'package:timebuddy/theme/themes.dart';
import 'package:page_transition/page_transition.dart';
import 'package:o_color_picker/o_color_picker.dart';
import 'dart:collection';
import 'package:timebuddy/modals/task.dart';
import 'package:timebuddy/utils/Database.dart';
import 'package:intl/intl.dart';

import 'package:timebuddy/localization/language_constants.dart';
import 'package:timebuddy/main.dart';
import '../controller/Controller.dart';

import 'addPriorityPage.dart';

class PlaningPage extends StatefulWidget {
  final bool readOnly;
  final String date;
  final String previous;
  PlaningPage(
      {Key key,
      @required this.readOnly,
      @required this.date,
      @required this.previous})
      : super(key: key);
  @override
  _PlaningPageState createState() => _PlaningPageState();
}

class _PlaningPageState extends State<PlaningPage> {
  Color selectedColor = Colors.transparent;
  HashMap colorMap = new HashMap<String, Color>();

  List<Task> _taskList;

  @override
  void initState() {
    debugPrint(widget.date);
    debugPrint(widget.previous);
    _taskList = List<Task>();
    super.initState();

    getSchedule();
  }

  getSchedule() async {
    _taskList = List<Task>();
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    List<Map<String, dynamic>> _results;
    if (widget.date != null && widget.previous == 'templatePage') {
      _results = await DBProvider.db.getSchedule(widget.date);
      debugPrint("widget ");
      debugPrint(_results.toString());
    } else {
      _results = await DBProvider.db.getSchedule(formattedDate);
      debugPrint("Today ");
      debugPrint(_results.toString());
    }

    if (_results != null) {
      setState(() {
        _taskList = _results.map((item) => Task.fromMap(item)).toList();
      });
    } else {
      _taskList = List<Task>();
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
    double topHeight = height * 0.15;
    double topHeightnew = height * 0.14;

    return Scaffold(
      backgroundColor: Color(0xff00a4ea),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              width: width,
              height: height,
              decoration: AppTheme.backgroundGradient,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: topHeight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 0,
                        bottom: 0,
                      ),
                      child: Center(
                        child: Text(
                          getTranslated(context, 'time_shedule_start_text_1'),
                          style: AppTheme.mainTitle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        height: height - topHeight,
                        width: width,
                        child: ListView(
                          children: [
                            !widget.readOnly
                                ? Container(
                                    //color: Colors.black,
                                    child: Text(
                                      getTranslated(
                                          context, 'time_shedule_start_text_2'),
                                      style: TextStyle(
                                        color:
                                            Color(0xff00a4ea).withOpacity(0.6),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                : Container(),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 55,
                                  right: 40,
                                  bottom: 30,
                                  top: 40,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [Text(':00'), Text(':30')],
                                ),
                              ),
                            ),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                                    child: Table(
                                      columnWidths: {
                                        0: FlexColumnWidth(0.8),
                                        1: FlexColumnWidth(4),
                                        2: FlexColumnWidth(4),
                                      },
                                      border: TableBorder(
                                          bottom: BorderSide(
                                              width: 1,
                                              color: Color(0xff00a4ea)
                                                  .withOpacity(0.6)),
                                          horizontalInside: BorderSide(
                                              width: 1,
                                              color: Color(0xff00a4ea)
                                                  .withOpacity(0.6)),
                                          verticalInside: BorderSide(
                                              width: 1,
                                              color: Color(0xff00a4ea)
                                                  .withOpacity(0.6))),
                                      children: [
                                        buildTableRow('00', width, height,
                                            widget.readOnly),
                                        buildTableRow('01', width, height,
                                            widget.readOnly),
                                        buildTableRow('02', width, height,
                                            widget.readOnly),
                                        buildTableRow('03', width, height,
                                            widget.readOnly),
                                        buildTableRow('04', width, height,
                                            widget.readOnly),
                                        buildTableRow('05', width, height,
                                            widget.readOnly),
                                        buildTableRow('06', width, height,
                                            widget.readOnly),
                                        buildTableRow('07', width, height,
                                            widget.readOnly),
                                        buildTableRow('08', width, height,
                                            widget.readOnly),
                                        buildTableRow('09', width, height,
                                            widget.readOnly),
                                        buildTableRow('10', width, height,
                                            widget.readOnly),
                                        buildTableRow('11', width, height,
                                            widget.readOnly),
                                        buildTableRow('12', width, height,
                                            widget.readOnly),
                                        buildTableRow('13', width, height,
                                            widget.readOnly),
                                        buildTableRow('14', width, height,
                                            widget.readOnly),
                                        buildTableRow('15', width, height,
                                            widget.readOnly),
                                        buildTableRow('16', width, height,
                                            widget.readOnly),
                                        buildTableRow('17', width, height,
                                            widget.readOnly),
                                        buildTableRow('18', width, height,
                                            widget.readOnly),
                                        buildTableRow('19', width, height,
                                            widget.readOnly),
                                        buildTableRow('20', width, height,
                                            widget.readOnly),
                                        buildTableRow('21', width, height,
                                            widget.readOnly),
                                        buildTableRow('22', width, height,
                                            widget.readOnly),
                                        buildTableRow('23', width, height,
                                            widget.readOnly),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            PageNavigator(
                                _taskList,
                                DateFormat('yyyy-MM-dd').format(DateTime.now()),
                                widget.readOnly,
                                widget.previous),
                          ],
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
          ),
          Container(
            height: topHeightnew,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 38,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.bottomToTop,
                            child: widget.previous == 'templatePage'
                                ? TemplatePage(previous: 'planingPage')
                                : widget.previous == 'dashboard'
                                    ? Dashboard(previous: 'planingPage')
                                    : AddPriority(previous: 'planingPage')));
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  TableRow buildTableRow(String s, double width, double height, bool readOnly) {
    if (!colorMap.containsKey(s + "1") && !colorMap.containsKey(s + "2")) {
      colorMap[s + "1"] = selectedColor;
      colorMap[s + "2"] = selectedColor;
    }

    return TableRow(
      children: [
        Container(
          alignment: Alignment.center,
          height: 30,
          child: Text(s,
              style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
        ),
        inputCell(s, "1", readOnly),
        inputCell(s, "2", readOnly),
      ],
    );
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

  GestureDetector inputCell(String s, String c, bool readOnly) {
    if (_taskList.indexWhere((task) => task.hour == s && task.half == c) ==
        -1) {
      Task task = Task(
          hour: s,
          half: c,
          date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
          task: "",
          previous: "false",
          next: "false");
      _taskList.add(task);
    }

    return GestureDetector(
      onDoubleTap: !readOnly
          ? () => showDialog<void>(
                context: context,
                builder: (BuildContext context) => Material(
                  color: Colors.transparent,
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.white.withOpacity(0.2),
                    child: OColorPicker(
                      selectedColor: selectedColor,
                      colors: primaryColorsPalette,
                      onColorChange: (color) {
                        setState(() {
                          selectedColor = color;
                          colorMap[s + c] = selectedColor;
                        });

                        int index = _taskList.indexWhere(
                            (task) => task.hour == s && task.half == c);

                        var hexCode =
                            '${colorMap[s + c].value.toRadixString(16).substring(0, 8)}';
                        if (index == -1) {
                          Task task = Task(
                              hour: s,
                              half: c,
                              date: DateFormat('yyyy-MM-dd')
                                  .format(DateTime.now()),
                              color: hexCode);
                          setState(() {
                            _taskList.add(task);
                          });
                        } else {
                          setState(() {
                            _taskList[index].color = hexCode;
                          });
                        }

                        List<String> previousHourHalf = getPreviousHourHalf(
                                _taskList[index].hour, _taskList[index].half)
                            .toString()
                            .split(" ");
                        int previousIndex = _taskList.indexWhere((task) =>
                            task.hour == previousHourHalf[0] &&
                            task.half == previousHourHalf[1]);
                        List<String> nextHourHalf = getNextHourHalf(
                                _taskList[index].hour, _taskList[index].half)
                            .toString()
                            .split(" ");
                        int nextIndex = _taskList.indexWhere((task) =>
                            task.hour == nextHourHalf[0] &&
                            task.half == nextHourHalf[1]);

                        if (previousHourHalf[0] == "null") {
                          _taskList[index].previous = "false";
                        } else {
                          _taskList[index].previous = "false";
                          _taskList[previousIndex].next = "false";
                          if (_taskList[previousIndex].color ==
                                  _taskList[index].color &&
                              _taskList[previousIndex].color != null &&
                              _taskList[previousIndex].color != "ffffffff" &&
                              _taskList[previousIndex].color != "00000000" &&
                              _taskList[previousIndex].task != "" &&
                              _taskList[index].task == "") {
                            _taskList[index].previous = "true";
                            _taskList[previousIndex].next = "true";
                          }
                          if (_taskList[previousIndex].color ==
                                  _taskList[index].color &&
                              _taskList[previousIndex].color != null &&
                              _taskList[previousIndex].color != "ffffffff" &&
                              _taskList[previousIndex].color != "00000000" &&
                              _taskList[previousIndex].previous == "true" &&
                              _taskList[index].task == "") {
                            _taskList[index].previous = "true";
                            _taskList[previousIndex].next = "true";
                          }
                          if (_taskList[previousIndex].color ==
                                  _taskList[index].color &&
                              _taskList[previousIndex].color != null &&
                              _taskList[previousIndex].color != "ffffffff" &&
                              _taskList[previousIndex].color != "00000000" &&
                              _taskList[previousIndex].task == "" &&
                              _taskList[index].task == "") {
                            _taskList[index].previous = "true";
                            _taskList[previousIndex].next = "true";
                          }
                        }

                        if (nextHourHalf[0] == "null") {
                          _taskList[index].next = "false";
                        } else {
                          _taskList[index].next = "false";
                          _taskList[nextIndex].previous = "false";
                          if (_taskList[nextIndex].color ==
                                  _taskList[index].color &&
                              _taskList[nextIndex].color != null &&
                              _taskList[nextIndex].color != "ffffffff" &&
                              _taskList[nextIndex].color != "00000000" &&
                              _taskList[nextIndex].task == "" &&
                              _taskList[index].task != "") {
                            _taskList[index].next = "true";
                            _taskList[nextIndex].previous = "true";
                          }

                          if (_taskList[nextIndex].color ==
                                  _taskList[index].color &&
                              _taskList[nextIndex].color != null &&
                              _taskList[nextIndex].color != "ffffffff" &&
                              _taskList[nextIndex].color != "00000000" &&
                              _taskList[nextIndex].task == "" &&
                              _taskList[index].task == "") {
                            _taskList[index].next = "true";
                            _taskList[nextIndex].previous = "true";
                          }
                        }
                        if (previousHourHalf[0] != "null") {
                          debugPrint(
                              "pre nex = " + _taskList[previousIndex].next);
                        }
                        debugPrint("cur pre = " + _taskList[index].previous);
                        debugPrint("cur nex = " + _taskList[index].next);
                        if (nextHourHalf[0] != "null") {
                          debugPrint(
                              "nex pre = " + _taskList[nextIndex].previous);
                        }
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              )
          : null,
      child: Container(
        color: _taskList
                    .indexWhere((task) => task.hour == s && task.half == c) !=
                -1
            ? Color(int.parse(
                '0x${_taskList[_taskList.indexWhere((task) => task.hour == s && task.half == c)].color == null ? 00000000 : _taskList[_taskList.indexWhere((task) => task.hour == s && task.half == c)].color}'))
            : colorMap[s + c],
        //height: 30,
        constraints: BoxConstraints(
          minHeight: 30,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: TextField(
            readOnly: readOnly,
            controller: TextEditingController()
              ..text = _taskList.indexWhere(
                          (task) => task.hour == s && task.half == c) !=
                      -1
                  ? _taskList[_taskList.indexWhere(
                          (task) => task.hour == s && task.half == c)]
                      .task
                  : "",
            onChanged: (value) {
              debugPrint(_taskList
                  .indexWhere((task) => task.hour == s && task.half == c)
                  .toString());
              debugPrint("typed" + value);

              int index = _taskList
                  .indexWhere((task) => task.hour == s && task.half == c);
              debugPrint(index.toString());
              debugPrint("previous = " +
                  getPreviousHourHalf(
                          _taskList[index].hour, _taskList[index].half)
                      .toString());
              debugPrint(
                  "currunt = " + _taskList[index].hour + _taskList[index].half);
              debugPrint("next = " +
                  getNextHourHalf(_taskList[index].hour, _taskList[index].half)
                      .toString());
              if (index == -1) {
                debugPrint("asd");
                Task task = Task(
                    hour: s,
                    half: c,
                    date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                    task: value);
                _taskList.add(task);
              } else {
                _taskList[index].task = value;

                debugPrint("a=" + _taskList[index].task);
              }
              debugPrint(_taskList.length.toString());

              List<String> previousHourHalf = getPreviousHourHalf(
                      _taskList[index].hour, _taskList[index].half)
                  .toString()
                  .split(" ");
              int previousIndex = _taskList.indexWhere((task) =>
                  task.hour == previousHourHalf[0] &&
                  task.half == previousHourHalf[1]);
              List<String> nextHourHalf =
                  getNextHourHalf(_taskList[index].hour, _taskList[index].half)
                      .toString()
                      .split(" ");
              int nextIndex = _taskList.indexWhere((task) =>
                  task.hour == nextHourHalf[0] && task.half == nextHourHalf[1]);

              if (previousHourHalf[0] == "null") {
                _taskList[index].previous = "false";
              } else {
                _taskList[index].previous = "false";
                _taskList[previousIndex].next = "false";
                if (_taskList[previousIndex].color == _taskList[index].color &&
                    _taskList[previousIndex].color != null &&
                    _taskList[previousIndex].color != "ffffffff" &&
                    _taskList[previousIndex].color != "00000000" &&
                    _taskList[previousIndex].task != "" &&
                    _taskList[index].task == "") {
                  _taskList[index].previous = "true";
                  _taskList[previousIndex].next = "true";
                }
                if (_taskList[previousIndex].color == _taskList[index].color &&
                    _taskList[previousIndex].color != null &&
                    _taskList[previousIndex].color != "ffffffff" &&
                    _taskList[previousIndex].color != "00000000" &&
                    _taskList[previousIndex].previous == "true" &&
                    _taskList[index].task == "") {
                  _taskList[index].previous = "true";
                  _taskList[previousIndex].next = "true";
                }
                if (_taskList[previousIndex].color == _taskList[index].color &&
                    _taskList[previousIndex].color != null &&
                    _taskList[previousIndex].color != "ffffffff" &&
                    _taskList[previousIndex].color != "00000000" &&
                    _taskList[previousIndex].task == "" &&
                    _taskList[index].task == "") {
                  _taskList[index].previous = "true";
                  _taskList[previousIndex].next = "true";
                }
              }

              if (nextHourHalf[0] == "null") {
                _taskList[index].next = "false";
              } else {
                _taskList[index].next = "false";
                _taskList[nextIndex].previous = "false";
                if (_taskList[nextIndex].color == _taskList[index].color &&
                    _taskList[nextIndex].color != null &&
                    _taskList[nextIndex].color != "ffffffff" &&
                    _taskList[nextIndex].color != "00000000" &&
                    _taskList[nextIndex].task == "" &&
                    _taskList[index].task != "") {
                  _taskList[index].next = "true";
                  _taskList[nextIndex].previous = "true";
                }

                if (_taskList[nextIndex].color == _taskList[index].color &&
                    _taskList[nextIndex].color != null &&
                    _taskList[nextIndex].color != "ffffffff" &&
                    _taskList[nextIndex].color != "00000000" &&
                    _taskList[nextIndex].task == "" &&
                    _taskList[index].task == "") {
                  _taskList[index].next = "true";
                  _taskList[nextIndex].previous = "true";
                }
              }
              if (previousHourHalf[0] != "null") {
                debugPrint("pre nex = " + _taskList[previousIndex].next);
              }
              debugPrint("cur pre = " + _taskList[index].previous);
              debugPrint("cur nex = " + _taskList[index].next);
              if (nextHourHalf[0] != "null") {
                debugPrint("nex pre = " + _taskList[nextIndex].previous);
              }
            },
            // keyboardType: TextInputType.text,
            // maxLines: null,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 4),
              isDense: true,
              labelStyle: AppTheme.textField,
              disabledBorder: InputBorder.none,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}

class PageNavigator extends StatelessWidget {
  PageNavigator(
      this._taskList, this.formattedDate, this.readOnly, this.previous);

  final List<Task> _taskList;
  final String formattedDate;
  final String previous;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () async {
          if (readOnly) {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.bottomToTop,
                    child: Dashboard(previous: 'planingPage')));
          } else {
            await DBProvider.db.addNewSchedule(_taskList, formattedDate);

            var notification = prefs.getBool('notifications');
            if (notification) {
              await flutterLocalNotificationsPlugin.cancelAll();
              await Controller().getSchedule();
            } else {
              await flutterLocalNotificationsPlugin.cancelAll();
            }
            if (previous == 'dashboard') {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.bottomToTop,
                      child: Dashboard(previous: 'planingPage')));
            } else {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.bottomToTop,
                      child: CompletePlanPage(
                        previous: 'planingPage',
                        prePrevious: previous,
                      )));
            }
          }
        },
        child: Container(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 20, 10),
            child: Text(
              'I\'m done',
              style:
                  TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.5)),
            ),
          ),
        ),
      ),
    );
  }
}
