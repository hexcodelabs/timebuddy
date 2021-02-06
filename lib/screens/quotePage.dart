import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:timebuddy/theme/themes.dart';
import 'package:timebuddy/screens/addQuotesPage.dart';
import 'dart:async';
import 'package:flutter_svg/svg.dart';

class QuotePage extends StatefulWidget {
  @override
  _AddQuotesPageState createState() => _AddQuotesPageState();
}

class _AddQuotesPageState extends State<QuotePage> {
  Timer _timer;
  int _start = 5;

  void startTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    } else {
      _timer = new Timer.periodic(
        const Duration(seconds: 1),
        (Timer timer) => setState(
          () {
            if (_start <= 0) {
              timer.cancel();
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.bottomToTop,
                      child: AddQuotes()));
            } else {
              _start = _start - 1;
            }
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    String quote = "\"The two most powerful warriors are patience and time\"";

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
              flex: 5,
            ),
            Container(
              child: Text(
                "TimeBuddy",
                style: TextStyle(fontSize: 30, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(
              flex: 6,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  "Quote of the day",
                  style: TextStyle(color: Color(0xff57c3ff)),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: Text(
                  quote,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Spacer(
              flex: 12,
            ),
            PageNavigator(_start),
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
  final int start;
  const PageNavigator(
    this.start, {
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
                  type: PageTransitionType.bottomToTop, child: AddQuotes()));
        },
        child: Column(
          children: [
            Container(
              child: Text(
                "Continuing in $start...",
                style: AppTheme.mainTitle,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: 100,
              height: 100,
              //color: Colors.green[50],
              child: SvgPicture.asset(
                "assets/images/sm-mountain.svg",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
