import 'package:flutter/material.dart';
import 'package:timebuddy/screens/addPriorityPage.dart';
import 'package:timebuddy/screens/quotePage.dart';
import 'package:timebuddy/screens/templatePage.dart';
import 'package:timebuddy/theme/themes.dart';
import 'package:page_transition/page_transition.dart';
import 'package:intl/intl.dart';

import 'package:timebuddy/localization/language_constants.dart';
import 'package:timebuddy/main.dart';

import 'addNamePage.dart';

class SelectPlans extends StatefulWidget {
  final String previous;

  SelectPlans({Key key, @required this.previous}) : super(key: key);

  @override
  _SelectPlansState createState() => _SelectPlansState();
}

class _SelectPlansState extends State<SelectPlans> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    double topHeight = height * 0.18;

    var now = new DateTime.now();
    String currentTime = DateFormat('h:mm a').format(now);
    String currentDay = DateFormat('EEEE').format(DateTime.now());
    String greeting() {
      var hour = DateTime.now().hour;
      if (hour < 12) {
        return 'Morning';
      }
      if (hour < 17) {
        return 'Afternoon';
      }
      return 'Evening';
    }

    String name =
        prefs.getString('name') == null ? "" : prefs.getString('name');
    // need to return from previous interface

    return Scaffold(
      backgroundColor: Color(0xff00a4ea),
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            decoration: AppTheme.backgroundGradient,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(
                  flex: 7,
                ),
                Container(
                  child: Text(
                    "Good ${greeting()}, $name.\nIt is currently $currentTime, $currentDay ${greeting()}. ",
                    style: AppTheme.mainTitle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Spacer(
                  flex: 5,
                ),
                PageNavigator(),
                Spacer(
                  flex: 10,
                ),
                Container(
                  child: Text(
                    getTranslated(context, 'daily_welcome_screen_text_6'),
                    style: AppTheme.mainTitle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Spacer(
                  flex: 4,
                ),
              ],
            ),
          ),
          widget.previous == 'addNamePage'
              ? Container(
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
                                  child: AddName(previous: 'selectPlanPage')));
                        },
                      ),
                    ],
                  ),
                )
              : Container(
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
                                  child:
                                      QuotePage(previous: 'selectPlanPage')));
                        },
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

class PageNavigator extends StatelessWidget {
  const PageNavigator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              getTranslated(context, 'daily_welcome_screen_text_2'),
              style: TextStyle(
                color: Color(0xff57c3ff),
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Container(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.bottomToTop,
                      child: TemplatePage(previous: 'selectPlanPage')));
            },
            child: Text(
              getTranslated(context, 'daily_welcome_screen_text_3'),
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15, top: 15),
            child: Text(
              getTranslated(context, 'daily_welcome_screen_text_4'),
              style: TextStyle(
                color: Color(0xff57c3ff),
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Container(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.bottomToTop,
                      child: AddPriority(previous: 'selectPlanPage')));
            },
            child: Text(
              getTranslated(context, 'daily_welcome_screen_text_5'),
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
