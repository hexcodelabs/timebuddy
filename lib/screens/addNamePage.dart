import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:timebuddy/theme/themes.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timebuddy/screens/selectPlanPage.dart';
import 'package:timebuddy/main.dart';

import 'package:timebuddy/localization/language_constants.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';

class AddQuotes extends StatefulWidget {
  @override
  _AddQuotesPageState createState() => _AddQuotesPageState();
}

class _AddQuotesPageState extends State<AddQuotes> {
  TextEditingController myController;
  //Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  ////bool pageLoaded = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    myController = TextEditingController();
    myController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  // // // ignore: missing_return
  // // Future<String> getName() async {
  // //   //SharedPreferences prefs = await SharedPreferences.getInstance();
  // //   debugPrint("sV" + prefs.getString('name').toString());
  // //   debugPrint("sVsV" + prefs.getBool('seenAddQuotePage').toString());

  // //   return (prefs.getString('name') ?? "");
  // // }

  // // Future checkFirstSeen() async {
  // //   //SharedPreferences prefs = await SharedPreferences.getInstance();
  // //   var name = prefs.getString('name').toString();
  // //   bool _seenAddQuotePage = (prefs.getBool('seenAddQuotePage') ?? false);

  // //   if (_seenAddQuotePage && name != null) {
  // //     debugPrint("next");
  // //     await prefs.setBool('seenAddQuotePage', true);
  // //     Navigator.of(context).pushReplacement(new MaterialPageRoute(
  // //         builder: (context) => new SelectPlans(name: name)));
  // //   } else if (!this.pageLoaded) {
  // //     debugPrint("befor " + this.pageLoaded.toString());
  // //     setState(() {
  // //       pageLoaded = true;
  // //     });
  // //     debugPrint("after" + this.pageLoaded.toString());
  // //   } else {
  // //     prefs.setString('name again', name);
  // //     Navigator.of(context).pushReplacement(
  // //         new MaterialPageRoute(builder: (context) => new AddQuotes()));
  // //   }
  // // }

  // @override
  // void afterFirstLayout(BuildContext context) => checkFirstSeen();

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
                getTranslated(context, 'name_screen_text_1'),
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
                  textCapitalization: TextCapitalization.words,
                  controller: myController,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, color: Colors.white),
                  decoration: InputDecoration(
                    hintText: getTranslated(context, 'name_screen_text_2'),
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
            PageNavigator(myController.text),
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
  PageNavigator(this.name);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () async {
          //SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('seenAddQuotePage', true);
          await prefs.setString('name', name);
          debugPrint("set addQuotePage see : " +
              prefs.getBool("'seenAddQuotePage").toString());
          debugPrint("set name : " + prefs.getString('name'));
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
                getTranslated(context, 'name_screen_text_3'),
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
