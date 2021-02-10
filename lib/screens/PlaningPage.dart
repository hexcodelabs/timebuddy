import 'package:flutter/material.dart';
import 'package:timebuddy/theme/themes.dart';
import 'package:page_transition/page_transition.dart';
import 'package:timebuddy/screens/completePlanPage.dart';
import 'package:o_color_picker/o_color_picker.dart';
//import 'package:o_popup/o_popup.dart';
import 'dart:collection';

class PlaningPage extends StatefulWidget {
  @override
  _PlaningPageState createState() => _PlaningPageState();
}

class _PlaningPageState extends State<PlaningPage> {
  Color selectedColor = Colors.transparent;
  HashMap colorMap = new HashMap<String, Color>();
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
                              left: 70,
                              right: 70,
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
                                child: Table(
                                  columnWidths: {
                                    0: FlexColumnWidth(0.5),
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
                        PageNavigator(),
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
        GestureDetector(
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
                      colorMap[s + "1"] = selectedColor;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ),
          child: Container(
            height: 30,
            color: colorMap[s + "1"],
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: TextField(
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
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
        ),
        GestureDetector(
          onDoubleTap: () => showDialog<void>(
            context: context,
            builder: (_) => Material(
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
                      colorMap[s + "2"] = selectedColor;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ),
          child: Container(
            height: 30,
            color: colorMap[s + "2"],
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: TextField(
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
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
        ),
      ],
    );
  }
}

class PageNavigator extends StatelessWidget {
  const PageNavigator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
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
