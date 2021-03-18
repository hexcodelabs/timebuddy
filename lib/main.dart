import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timebuddy/theme/themes.dart';
import 'package:flutter/services.dart';
import 'package:timebuddy/screens/landingPage.dart';
import 'package:timebuddy/screens/quotePage.dart';

import 'package:timebuddy/localization/demo_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'localization/language_constants.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:math' as Math;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
SharedPreferences prefs;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  var initializationSettingsAndroid = AndroidInitializationSettings('appicon');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {});
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  });

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  final fb = FirebaseDatabase.instance;

  Locale _locale;
  int language;
  bool seenLandingPage =
      prefs.getBool('seenLandingPage') == null ? false : true;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  getAQuote() async {
    debugPrint("Quote");
    final response =
        await FirebaseDatabase.instance.reference().child("Quotes").once();
    var quotes = [];
    response.value.forEach((v) => quotes.add(v));
    int numberOfQuotes = quotes.length;

    Random random = new Math.Random();
    int randomNumber = random.nextInt(numberOfQuotes);
    debugPrint(randomNumber.toString());

    String quote = quotes[randomNumber].toString();
    debugPrint(quote);
    prefs.setString('quote', quote);
  }

  @override
  void initState() {
    super.initState();
    var notification = prefs.getBool('notifications');
    notification == null
        ? prefs.setBool('notifications', true)
        : prefs.setBool('notifications', notification);
    getAQuote();
  }

  @override
  Widget build(BuildContext context) {
    getAQuote();
    if (this._locale == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[800])),
        ),
      );
    } else {
      debugPrint("main/Meterial APP widget");
      debugPrint("main/seenLandingPage : " + this.seenLandingPage.toString());
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Timebuddy',
        theme: AppTheme.perksTheme,
        locale: _locale,
        supportedLocales: [
          Locale("en", "US"),
          Locale("da", "DK"),
        ],
        localizationsDelegates: [
          DemoLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        home: FutureBuilder(
          future: _fbApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print('You have an errro!  + ${snapshot.error.toString()}');
              return Text("Something went wrong");
            } else if (snapshot.hasData) {
              return seenLandingPage ? QuotePage() : LandingPage();
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      );
    }
  }
}
