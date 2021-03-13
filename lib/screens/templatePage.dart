import 'package:flutter/material.dart';
import 'package:timebuddy/constants/theme_data.dart';
import 'package:timebuddy/data.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:timebuddy/theme/themes.dart';

class TemplatePage extends StatefulWidget {
  TemplatePage({Key key}) : super(key: key);

  @override
  _TemplatePageState createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff00a4ea),
      body: Container(
        decoration: AppTheme.backgroundGradient,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'TODO Templates',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: alarms.map<Widget>((alarm) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    margin: const EdgeInsets.only(bottom: 32),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: alarm.gradientColors,
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: alarm.gradientColors.last.withOpacity(0.4),
                          blurRadius: 8,
                          spreadRadius: 2,
                          offset: Offset(4, 4),
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.label,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  alarm.description,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Switch(
                              value: true,
                              onChanged: (bool value) {},
                              activeColor: Colors.white,
                            ),
                          ],
                        ),
                        Text(
                          'Mon-Fri',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'avenir',
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '07:00 AM',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              size: 36,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).followedBy([
                  DottedBorder(
                    strokeWidth: 3,
                    color: CustomColors.clockOutline,
                    borderType: BorderType.RRect,
                    radius: Radius.circular(24),
                    dashPattern: [5, 4],
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: CustomColors.clockBG,
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                      ),
                      child: TextButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          ),
                        ),
                        onPressed: () {},
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/add_alarm.png',
                              scale: 1.5,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Add New Template',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ]).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
