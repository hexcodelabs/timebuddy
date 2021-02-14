import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:timebuddy/main.dart';
import 'package:timebuddy/theme/themes.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timebuddy/screens/quotePage.dart';

import 'package:timebuddy/modals/language.dart';
import 'package:timebuddy/localization/language_constants.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPage createState() => _LandingPage();
}

class _LandingPage extends State<LandingPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }

  int language = 2; //1-Dansk  2-English
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
              flex: 4,
            ),
            Container(
              child: Text(
                "TimeBuddy",
                style: TextStyle(fontSize: 30, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(
              flex: 2,
            ),
            Container(
              child: Text(
                "Welcome to TimeBuddy!\nChoose a language",
                style: AppTheme.mainTitle,
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(
              flex: 3,
            ),
            languageButtonBar(),
            Spacer(
              flex: 6,
            ),
            PageNavigator(),
            Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }

  Container languageButtonBar() {
    return Container(
      child: Container(
        child: Column(
          children: [
            Container(
              height: 50,
              width: 300,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    language = 1;
                  });
                  Language languageNew = Language(2, "dk", "dansk", "da");
                  _changeLanguage(languageNew);
                  debugPrint(language.toString());
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: language == 1 ? Colors.blue : Colors.lightBlue,
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 50,
                          width: 70,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: SvgPicture.asset(
                              "assets/images/Flag_of_Denmark.svg",
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 50,
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
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: 300,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    language = 2;
                  });
                  Language languageNew = Language(2, "us", "Englsh", "en");
                  _changeLanguage(languageNew);
                  debugPrint(language.toString());
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: language == 2 ? Colors.blue : Colors.lightBlue,
                      borderRadius: BorderRadius.circular(30)),
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
                                fit: BoxFit.fill,
                              ),
                            )),
                        SizedBox(
                          width: 50,
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
                ),
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
                  type: PageTransitionType.bottomToTop, child: QuotePage()));
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
