import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:timebuddy/theme/themes.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timebuddy/screens/quotePage.dart';
import 'package:flag/flag.dart';

class LandingPage extends StatefulWidget {
  @override
  _AddQuotesPageState createState() => _AddQuotesPageState();
}

class _AddQuotesPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    int language = 1; //1-Dansk  2-English

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
              padding: const EdgeInsets.only(top: 80),
              child: Text(
                "Welcome to TimeBuddy!\nChoose a language",
                style: AppTheme.mainTitle,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 50, right: 80, left: 80),
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: 300,
                        child: RaisedButton(
                          color: language == 1 ? Colors.blue : Colors.lightBlue,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                    height: 50,
                                    width: 70,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30.0),
                                      child: SvgPicture.asset(
                                        "assets/images/Flag_of_Denmark.svg",
                                      ),
                                    )),
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  'Dansk',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              language = 1;
                            });
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: BorderSide(width: 2, color: Colors.blue)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        width: 300,
                        child: RaisedButton(
                          color: language == 2 ? Colors.blue : Colors.lightBlue,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                    height: 50,
                                    width: 70,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30.0),
                                      child: SvgPicture.asset(
                                        "assets/images/Flag_of_the_United_States.svg",
                                      ),
                                    )),
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  'English',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              language = 2;
                            });
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: BorderSide(width: 2, color: Colors.blue)),
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
                        child: QuotePage()));
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
