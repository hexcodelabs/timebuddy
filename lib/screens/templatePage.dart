import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:timebuddy/localization/language_constants.dart';
import 'package:timebuddy/screens/planingPage.dart';
import 'package:timebuddy/screens/selectPlanPage.dart';

import 'package:timebuddy/utils/Database.dart';

class TemplatePage extends StatefulWidget {
  final String previous;

  TemplatePage({Key key, @required this.previous}) : super(key: key);

  @override
  _TemplatePageState createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {
  var selected;
  List<String> _dates;
  @override
  initState() {
    super.initState();
    this.setState(() {
      selected = null;
    });
    getDates();
  }

  getDates() async {
    List<Map<String, dynamic>> _results = await DBProvider.db.getDatesList();
    debugPrint(_results.toString());
    List<String> dateList;
    dateList = _results.map((date) => date['date'].toString()).toList();
    setState(() {
      _dates = dateList;
    });
    debugPrint(dateList.toString());
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    double topHeight = height * 0.195;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              color: Color(0xE7F6FFFF),
              height: height,
              width: width,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      getTranslated(context, 'template_page_1'),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    height: height * 0.6,
                    child: this._dates == null
                        ? null
                        : ListView(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shrinkWrap: true,
                            children: this._dates.map<Widget>((date) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      this.setState(() {
                                        selected = date;
                                      });
                                    },
                                    child: Container(
                                      width: width * 0.5,
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: Color(0xff57C3ff), width: 2),
                                        color: this.selected == date
                                            ? Color(0xff57C3ff)
                                            : null,
                                      ),
                                      child: Text(
                                        DateFormat('yyyy-MM-dd')
                                                    .format(DateTime.now()) ==
                                                date
                                            ? 'Today'
                                            : DateFormat('yyyy-MM-dd').format(
                                                        DateTime.now().subtract(
                                                            Duration(
                                                                days: 1))) ==
                                                    date
                                                ? 'Yesterday'
                                                : date,
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  this.selected == null
                      ? Container(
                          child: Text(
                            'Select a template first',
                            style: TextStyle(
                              color: Color(0xff57C3ff),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gilroy',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : PageNavigator(selected: this.selected),
                  Spacer(
                    flex: 1,
                  ),
                ],
              ),
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
                    color: Color(0xff57C3ff),
                    size: 40,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.bottomToTop,
                            child: SelectPlans(previous: 'templatePage')));
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
    @required this.selected,
  }) : super(key: key);

  final selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.bottomToTop,
                  child: PlaningPage(
                      readOnly: false,
                      date: this.selected,
                      previous: "templatePage")));
        },
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SvgPicture.asset(
                  "assets/images/Arrow.svg",
                  color: Color(0xff57C3ff),
                ),
              ),
            ),
            Container(
              child: Text(
                getTranslated(context, 'template_page_2'),
                style: TextStyle(
                  color: Color(0xff57C3ff),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Gilroy',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
