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
            PageNavigator(),
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
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SvgPicture.asset(
                  "assets/images/Arrow.svg",
                ),
              ),
            ),
            Container(
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
