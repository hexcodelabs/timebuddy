import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:timebuddy/screens/Dashboard.dart';
import 'package:timebuddy/theme/themes.dart';
import 'package:timebuddy/main.dart';

import '../controller/Controller.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notification;

  @override
  void initState() {
    super.initState();
    this.setState(() {
      notification = prefs.getBool('notifications');
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    double topHeight = height * 0.15;
    debugPrint(this.notification.toString());
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
                Container(
                  height: topHeight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Settings",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      height: height - topHeight,
                      width: width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 40),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Notifications",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: 24,
                                    ),
                                  ),
                                  CupertinoSwitch(
                                    value: this.notification,
                                    activeColor: Colors.blue,
                                    onChanged: (value) async {
                                      debugPrint("valuse: " + value.toString());
                                      if (value) {
                                        this.setState(() {
                                          notification = value;
                                        });
                                        await prefs.setBool(
                                            'notifications', true);
                                        await Controller().getSchedule();
                                        debugPrint("notifications : " +
                                            value.toString());
                                      } else {
                                        this.setState(() {
                                          notification = value;
                                        });
                                        await prefs.setBool(
                                            'notifications', false);
                                        await flutterLocalNotificationsPlugin
                                            .cancelAll();
                                        debugPrint("notifications : " +
                                            value.toString());
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Divider(
                                height: 3,
                                color: Color(0xffc7c7c7),
                              ),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xE7F6FFFF),
                        borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(40.0),
                          topRight: const Radius.circular(40.0),
                        ),
                      ),
                    ),
                  ],
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
                            child: Dashboard()));
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
