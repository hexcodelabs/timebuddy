import 'package:flutter/material.dart';
import 'package:timebuddy/theme/themes.dart';
import 'package:page_transition/page_transition.dart';
import 'package:timebuddy/screens/completePlanPage.dart';
import 'package:o_color_picker/o_color_picker.dart';
import 'dart:collection';
import 'package:timebuddy/modals/task.dart';
import 'package:timebuddy/utils/Database.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../controller/Controller.dart';

class PlaningPage extends StatefulWidget {
  @override
  _PlaningPageState createState() => _PlaningPageState();
}

class _PlaningPageState extends State<PlaningPage> {
  static var now = new DateTime.now();
  static var formatter = new DateFormat('yyyy-MM-dd');
  String formattedDate = formatter.format(now);

  Color selectedColor = Colors.transparent;
  HashMap colorMap = new HashMap<String, Color>();

  List<Task> _taskList;
  Controller controller = Get.find();

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
      debugPrint(_taskList[18].color.toString());
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
    double topHeight = height * 0.15;

    return Scaffold(
      backgroundColor: Color(0xff00a4ea),
      body: SingleChildScrollView(
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
                      "Perfect. Let’s plan your time.",
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
                        Container(
                          //color: Colors.black,
                          child: Text(
                            "Click on a field to start planing.",
                            style: TextStyle(
                              color: Color(0xff00a4ea).withOpacity(0.6),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 55,
                              right: 40,
                              bottom: 30,
                              top: 40,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                // child: Container(
                                //   child: FloatingActionButton(
                                //     onPressed: () async {
                                //       //getSchedule();
                                //       Color color = Colors.red;
                                //       List<Task> tl = [];
                                //       var hexCode =
                                //           '${color.value.toRadixString(16).substring(2, 8)}';
                                //       Task t = Task(
                                //           date: formattedDate,
                                //           hour: "00",
                                //           half: "1",
                                //           task: "Study",
                                //           color: hexCode);
                                //       tl.add(t);
                                //       color = new Color(0x12345678);
                                //       String colorString =
                                //           color.toString(); // Color(0x12345678)
                                //       String valueString = colorString
                                //           .split('(0x')[1]
                                //           .split(')')[0];
                                //       t = Task(
                                //           date: formattedDate,
                                //           hour: "00",
                                //           half: "2",
                                //           task: "sleep",
                                //           color: valueString);
                                //       tl.add(t);
                                //       t = Task(
                                //           date: formattedDate,
                                //           hour: "01",
                                //           half: "1",
                                //           task: "Study",
                                //           color:
                                //               Color(int.parse('0x$valueString'))
                                //                   .toString());
                                //       tl.add(t);
                                //       debugPrint(tl[1].toMap().toString());
                                //       await DBProvider.db.addNewSchedule(tl);
                                //       getSchedule();
                                //     },
                                //   ),
                                // ),
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
                                    buildTableRow('00', width, height),
                                    buildTableRow('01', width, height),
                                    buildTableRow('02', width, height),
                                    buildTableRow('03', width, height),
                                    buildTableRow('04', width, height),
                                    buildTableRow('05', width, height),
                                    buildTableRow('06', width, height),
                                    buildTableRow('07', width, height),
                                    buildTableRow('08', width, height),
                                    buildTableRow('09', width, height),
                                    buildTableRow('10', width, height),
                                    buildTableRow('11', width, height),
                                    buildTableRow('12', width, height),
                                    buildTableRow('13', width, height),
                                    buildTableRow('14', width, height),
                                    buildTableRow('15', width, height),
                                    buildTableRow('16', width, height),
                                    buildTableRow('17', width, height),
                                    buildTableRow('18', width, height),
                                    buildTableRow('19', width, height),
                                    buildTableRow('20', width, height),
                                    buildTableRow('21', width, height),
                                    buildTableRow('22', width, height),
                                    buildTableRow('23', width, height),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: RaisedButton(
                            child: Text("data"),
                            onPressed: () {
                              getSchedule();
                            },
                          ),
                        ),
                        PageNavigator(_taskList, formattedDate),
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
    );
  }

  TableRow buildTableRow(String s, double width, double height) {
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
        inputCell(s, "1"),
        inputCell(s, "2"),
      ],
    );
  }

  GestureDetector inputCell(String s, String c) {
    return GestureDetector(
      onDoubleTap: () => showDialog<void>(
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
                debugPrint("colorchang");
                int index = _taskList
                    .indexWhere((task) => task.hour == s && task.half == c);
                debugPrint(index.toString());
                var hexCode =
                    '${colorMap[s + c].value.toRadixString(16).substring(0, 8)}';
                if (index == -1) {
                  Task task = Task(
                      hour: s, half: c, date: formattedDate, color: hexCode);
                  setState(() {
                    _taskList.add(task);
                  });
                } else {
                  setState(() {
                    _taskList[index].color = hexCode;
                  });
                }
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ),
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
              if (index == -1) {
                debugPrint("asd");
                Task task =
                    Task(hour: s, half: c, date: formattedDate, task: value);
                _taskList.add(task);
              } else {
                // debugPrint("1");
                //debugPrint("b=" + _taskList[index].task);
                // debugPrint("2");
                _taskList[index].task = value;

                debugPrint("a=" + _taskList[index].task);
              }
              debugPrint(_taskList.length.toString());
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
  PageNavigator(this._taskList, this.formattedDate);

  final List<Task> _taskList;
  final String formattedDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () async {
          await DBProvider.db.addNewSchedule(_taskList, formattedDate);
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.bottomToTop,
                  child: CompletePlanPage()));
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
