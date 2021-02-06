import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:timebuddy/theme/themes.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timebuddy/screens/selectPlanPage.dart';

class AddQuotes extends StatefulWidget {
  @override
  _AddQuotesPageState createState() => _AddQuotesPageState();
}

class _AddQuotesPageState extends State<AddQuotes> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
                "Welcome to TimeBuddy!\nEnter your name to get started",
                style: AppTheme.mainTitle,
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(
              flex: 5,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(right: 100, left: 100),
                child: TextField(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, color: Color(0xff57C3FF)),
                  decoration: InputDecoration(
                    hintText: "Write here...",
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.4),
                      fontSize: 22,
                    ),
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
            Spacer(
              flex: 10,
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
                  type: PageTransitionType.bottomToTop, child: SelectPlans()));
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
