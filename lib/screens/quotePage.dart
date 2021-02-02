import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:timebuddy/theme/themes.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timebuddy/screens/addQuotesPage.dart';

class QuotePage extends StatefulWidget {
  @override
  _AddQuotesPageState createState() => _AddQuotesPageState();
}

class _AddQuotesPageState extends State<QuotePage> {
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
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Text(
                "TimeBuddy",
                style: TextStyle(fontSize: 30, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 150),
              child: Text(
                "Quote of the day",
                style: TextStyle(
                  color: Colors.blue[700]
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                quote,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
                textAlign: TextAlign.center,
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.bottomToTop,
                        child: AddQuotes()));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 200),
                child: SvgPicture.asset(
                  "assets/images/Arrow.svg",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "Click to continue",
                style: AppTheme.mainTitle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
