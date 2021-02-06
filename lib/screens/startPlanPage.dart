import 'package:flutter/material.dart';
import 'package:timebuddy/theme/themes.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timebuddy/screens/PlaningPage.dart';

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
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Text(
                "Great! Let’s map down your priorities for today.\nRemember, you can always go back and edit the plan.",
                style: AppTheme.mainTitle,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Text(
                "What are your main priorities today?",
                style: AppTheme.mainTitle,
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              "Add up to 3",
              style: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
                padding: const EdgeInsets.only(top: 50, right: 80, left: 80),
                child: Container(
                  //color: Colors.amber,
                  width: 350,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 50,
                        width: 275,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white.withOpacity(0.3),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 2, 2, 2),
                          child: TextField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Write here...',
                              hintStyle: TextStyle(
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
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color(0x57C3FF).withOpacity(0.8),
                        ),
                        child: Icon(
                          Icons.add,
                          size: 45,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.bottomToTop,
                        child: PlaningPage()));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 150),
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
