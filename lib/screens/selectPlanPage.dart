import 'package:flutter/material.dart';
import 'package:timebuddy/screens/startPlanPage.dart';
import 'package:timebuddy/theme/themes.dart';
import 'package:page_transition/page_transition.dart';
import 'package:intl/intl.dart';

class SelectPlans extends StatefulWidget {
  @override
  _SelectPlansState createState() => _SelectPlansState();
}

class _SelectPlansState extends State<SelectPlans> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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

    String name = "Marius"; // need to return from previous interface

    return Scaffold(
      backgroundColor: Color(0xff00a4ea),
      body: Container(
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
                "Choose an option",
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
              "Do you want to ",
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
                      child: StartPlanPage()));
            },
            child: Text(
              "Replicate one of your old plans",
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
              "Or",
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
                      child: StartPlanPage()));
            },
            child: Text(
              "Lay down a plan for today",
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
