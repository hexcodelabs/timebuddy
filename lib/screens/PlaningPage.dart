import 'package:flutter/material.dart';
import 'package:timebuddy/theme/themes.dart';
import 'package:page_transition/page_transition.dart';
import 'package:timebuddy/screens/completePlanPage.dart';

class PlaningPage extends StatefulWidget {
  @override
  _PlaningPageState createState() => _PlaningPageState();
}

class _PlaningPageState extends State<PlaningPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
              //color: Colors.white.withOpacity(0.1),
              height: 170,
              child: Padding(
                padding: const EdgeInsets.only(top: 80, bottom: 70),
                child: Text(
                  "Perfect. Let’s plan your time.",
                  style: AppTheme.mainTitle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: height - 170,
                  width: width,
                  child: ListView(
                    children: [
                      Container(
                        //color: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30, bottom: 60),
                          child: Text(
                            "Click on a field to start planing.",
                            style: TextStyle(
                              color: Color(0xff00a4ea).withOpacity(0.6),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                              child: Table(
                                columnWidths: {
                                  0: FlexColumnWidth(0.5),
                                  1: FlexColumnWidth(4),
                                  2: FlexColumnWidth(4),
                                },
                                border: TableBorder(
                                    bottom: BorderSide(
                                        width: 1,
                                        color:
                                            Color(0xff00a4ea).withOpacity(0.6)),
                                    horizontalInside: BorderSide(
                                        width: 1,
                                        color:
                                            Color(0xff00a4ea).withOpacity(0.6)),
                                    verticalInside: BorderSide(
                                        width: 1,
                                        color: Color(0xff00a4ea)
                                            .withOpacity(0.6))),
                                children: [
                                  buildTableRow('00'),
                                  buildTableRow('01'),
                                  buildTableRow('02'),
                                  buildTableRow('03'),
                                  buildTableRow('04'),
                                  buildTableRow('05'),
                                  buildTableRow('06'),
                                  buildTableRow('07'),
                                  buildTableRow('08'),
                                  buildTableRow('09'),
                                  buildTableRow('10'),
                                  buildTableRow('11'),
                                  buildTableRow('12'),
                                  buildTableRow('13'),
                                  buildTableRow('14'),
                                  buildTableRow('15'),
                                  buildTableRow('16'),
                                  buildTableRow('17'),
                                  buildTableRow('18'),
                                  buildTableRow('19'),
                                  buildTableRow('20'),
                                  buildTableRow('21'),
                                  buildTableRow('22'),
                                  buildTableRow('23'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
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
                            padding: const EdgeInsets.fromLTRB(0, 20, 30, 0),
                            child: Text(
                              'I\'m done',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                          ),
                        ),
                      ),
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
    );
  }

  TableRow buildTableRow(String s) {
    return TableRow(
      children: [
        Container(
          alignment: Alignment.center,
          height: 24,
          child: Text(s,
              style: TextStyle(fontSize: 14), textAlign: TextAlign.center),
        ),
        Container(
          height: 24,
          margin: const EdgeInsets.all(0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: TextField(
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
        Container(
          height: 24,
          margin: const EdgeInsets.all(0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: TextField(
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
      ],
    );
  }
}
