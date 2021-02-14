import 'package:flutter/material.dart';
import 'package:timebuddy/theme/themes.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timebuddy/screens/PlaningPage.dart';

import 'package:timebuddy/localization/language_constants.dart';

class StartPlanPage extends StatefulWidget {
  @override
  _StartPlanPageState createState() => _StartPlanPageState();
}

class _StartPlanPageState extends State<StartPlanPage> {
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
            Spacer(
              flex: 6,
            ),
            Container(
              child: Text(
                "Great! Let’s map down your priorities for today.\nRemember, you can always go back and edit the plan.",
                style: AppTheme.mainTitle,
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(
              flex: 3,
            ),
            Container(
              child: Text(
                "What are your main priorities today?",
                style: AppTheme.mainTitle,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              child: Text(
                "Add up to 3",
                style: TextStyle(
                  color: Color(0xff57C3ff),
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(
              flex: 2,
            ),
            InputField(),
            InputField(),
            Spacer(
              flex: 8,
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

class InputField extends StatelessWidget {
  const InputField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 40,
              width: 240,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0x57C3FF).withOpacity(0.6),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 2, 2, 2),
                child: TextField(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Write here...',
                    hintStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.white.withOpacity(0.4),
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
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Color(0x57C3FF).withOpacity(0.6),
              ),
              child: Icon(
                Icons.add,
                size: 40,
                color: Colors.white,
              ),
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
                  type: PageTransitionType.bottomToTop,
                  child: PlaningPage(readOnly: false)));
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
