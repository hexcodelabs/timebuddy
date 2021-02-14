import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timebuddy/modals/priority.dart';
import 'package:timebuddy/theme/themes.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timebuddy/screens/PlaningPage.dart';

import 'package:timebuddy/localization/language_constants.dart';

import 'package:timebuddy/utils/Database.dart';

class StartPlanPage extends StatefulWidget {
  @override
  _StartPlanPageState createState() => _StartPlanPageState();
}

class _StartPlanPageState extends State<StartPlanPage> {
  List<String> inputFieldList = List<String>();

  @override
  void initState() {
    super.initState();
    setState(() {
      inputFieldList = [""];
    });
    getPriority();
  }

  getPriority() async {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    List<Priority> inputPriorityList = List<Priority>();

    List<Map<String, dynamic>> _results =
        await DBProvider.db.getPriorities(formattedDate);
    if (_results != null) {
      inputPriorityList =
          _results.map((item) => Priority.fromMap(item)).toList();

      inputFieldList = List<String>();

      inputPriorityList.forEach((priority) {
        inputFieldList.add("");
      });
      inputPriorityList.forEach((priority) {
        if (priority.priority == "") {
        } else {
          setState(() {
            inputFieldList[priority.index] = priority.priority;
          });
        }
      });

      if (inputFieldList.length == 3 && inputFieldList[2] == "") {
        inputFieldList.removeAt(2);
      }

      if (inputFieldList.length >= 2 && inputFieldList[1] == "") {
        inputFieldList.removeAt(1);
      }
      if (inputFieldList.length > 1 && inputFieldList[0] == "") {
        inputFieldList.removeAt(0);
      }
    } else {
      inputPriorityList = List<Priority>();
      setState(() {
        inputFieldList = [""];
      });
    }

    return inputPriorityList;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xff00a4ea),
      body: SingleChildScrollView(
        child: Container(
          width: width,
          height: height,
          decoration: AppTheme.backgroundGradient,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(
                flex: 6,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  child: Text(
                    getTranslated(context, 'priorities_screen_text_1'),
                    style: AppTheme.mainTitle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Spacer(
                flex: 3,
              ),
              Container(
                child: Text(
                  getTranslated(context, 'priorities_screen_text_2'),
                  style: AppTheme.mainTitle,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                child: Text(
                  getTranslated(context, 'priorities_screen_text_3'),
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
              Center(
                child: Container(
                  alignment: Alignment.center,
                  width: 300,
                  constraints: BoxConstraints(
                    minHeight: 100,
                  ),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: inputFieldList.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return inputField(
                            context, inputFieldList[index], index);
                      }),
                ),
              ),
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
      ),
    );
  }

  inputField(context, inputField, index) {
    return Container(
      width: 300,
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () async {
                inputFieldList[index] = "";
                var now = new DateTime.now();
                var formatter = new DateFormat('yyyy-MM-dd');
                String formattedDate = formatter.format(now);
                await DBProvider.db.addPriority(inputFieldList, formattedDate);
                if (inputFieldList.length != 1) {
                  setState(() {
                    inputFieldList.removeAt(index);
                  });
                }
              },
              child: Container(
                height: 40,
                width: 30,
                child: inputFieldList.length != 1
                    ? Icon(
                        Icons.remove,
                        size: 30,
                        color: Colors.redAccent[100],
                      )
                    : null,
              ),
            ),
            Container(
              height: 40,
              width: 210,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0x57C3FF).withOpacity(0.6),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 2, 2, 2),
                child: TextField(
                  onChanged: (value) {
                    inputFieldList[index] = value;
                    var now = new DateTime.now();
                    var formatter = new DateFormat('yyyy-MM-dd');
                    String formattedDate = formatter.format(now);
                    DBProvider.db.addPriority(inputFieldList, formattedDate);
                  },
                  controller: TextEditingController()..text = inputField,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  decoration: InputDecoration(
                    hintText:
                        getTranslated(context, 'priorities_screen_text_5'),
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
            GestureDetector(
              onTap: () {
                if (inputFieldList.length < 3) {
                  setState(() {
                    inputFieldList.insert(index + 1, "");
                  });
                }
              },
              child: (inputFieldList.length - 1 == index && index != 2)
                  ? Container(
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
                    )
                  : Container(
                      height: 40,
                      width: 40,
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
                getTranslated(context, 'priorities_screen_text_6'),
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
