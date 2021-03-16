import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:timebuddy/data.dart';
import 'package:timebuddy/localization/language_constants.dart';
import 'package:timebuddy/screens/PlaningPage.dart';

class TemplatePage extends StatefulWidget {
  TemplatePage({Key key}) : super(key: key);

  @override
  _TemplatePageState createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {
  var selected;
  @override
  void initState() {
    super.initState();
    this.setState(() {
      selected = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    debugPrint("selected : " + selected.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xff00a4ea).withOpacity(0.17),
          height: height,
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
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shrinkWrap: true,
                  children: templates.map<Widget>((template) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            this.setState(() {
                              selected = template.id;
                            });
                          },
                          child: Container(
                            width: width * 0.5,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Color(0xff57C3ff), width: 2),
                              color: this.selected == template.id
                                  ? Color(0xff57C3ff)
                                  : null,
                            ),
                            child: Text(
                              template.name,
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
              PageNavigator(),
              Spacer(
                flex: 1,
              ),
            ],
          ),
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
