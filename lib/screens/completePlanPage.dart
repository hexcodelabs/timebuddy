import 'package:flutter/material.dart';
import 'package:timebuddy/screens/PlaningPage.dart';
import 'package:timebuddy/theme/themes.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timebuddy/screens/dashboard.dart';

import 'package:timebuddy/localization/language_constants.dart';

class CompletePlanPage extends StatefulWidget {
  final String previous;
  final String prePrevious;

  CompletePlanPage(
      {Key key, @required this.previous, @required this.prePrevious})
      : super(key: key);
  @override
  _CompletePlanPageState createState() => _CompletePlanPageState();
}

class _CompletePlanPageState extends State<CompletePlanPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    double topHeight = height * 0.18;

    return Scaffold(
      backgroundColor: Color(0xff00a4ea),
      body: Stack(
        children: [
          Container(
            width: width,
            height: height,
            decoration: AppTheme.backgroundGradient,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(
                  flex: 3,
                ),
                Container(
                  child: Text(
                    getTranslated(context, 'time_shedule_text_1'),
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  child: Text(
                    getTranslated(context, 'time_shedule_text_2'),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
                Spacer(
                  flex: 3,
                ),
                PageNavigator(),
                Spacer(
                  flex: 1,
                ),
              ],
            ),
          ),
          Container(
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
                            child: PlaningPage(
                              previous: widget.prePrevious,
                              date: null,
                              readOnly: false,
                            )));
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
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.bottomToTop,
                  child: Dashboard(previous: 'completePlanPage')));
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
                getTranslated(context, 'time_shedule_text_3'),
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
