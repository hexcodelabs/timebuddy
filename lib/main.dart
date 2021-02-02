import 'package:flutter/material.dart';
import 'package:timebuddy/theme/themes.dart';
import 'package:flutter/services.dart';

import 'package:timebuddy/screens/addQuotesPage.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timebuddy',
      theme: AppTheme.perksTheme,
      debugShowCheckedModeBanner: false,
      home: AddQuotes(),
    );
  }
}
