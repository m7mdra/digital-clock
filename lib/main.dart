import 'dart:async';

import 'package:digital_clock/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'extensions_on_datetime.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    super.initState();
  }

  static const MaterialColor primarySwatch =
      MaterialColor(primaryColor, <int, Color>{
    50: Color(0xFFE1E5E6),
    100: Color(0xFFB4BEC0),
    200: Color(0xFF829297),
    300: Color(0xFF4F666D),
    400: Color(0xFF2A464D),
    500: Color(primaryColor),
    600: Color(0xFF032129),
    700: Color(0xFF031B23),
    800: Color(0xFF02161D),
    900: Color(0xFF010D12),
  });
  static const int primaryColor = 0xFF04252E;

  static const MaterialColor accentMaterial =
      MaterialColor(accentColor, <int, Color>{
    100: Color(0xFF53BFFF),
    200: Color(accentColor),
    400: Color(0xFF0094EC),
    700: Color(0xFF0084D3),
  });
  static const int accentColor = 0xFF20ABFF;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: AppBarTheme(elevation: 0),
          primarySwatch: primarySwatch,
          accentColor: accentMaterial,
          textTheme: TextTheme(title: TextStyle(color: Colors.white)),
          canvasColor: Color(0xff04252e),
          backgroundColor: Color(0xff04252e)),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer _timer;
  DateTime dateTime;
  bool is24 = false;

  @override
  void initState() {
    super.initState();
    dateTime = DateTime.now();
    dateTime = DateTime.now();
    _timer = new Timer.periodic(const Duration(seconds: 1), _timeCallback);
  }

  @override
  void dispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }

  void _timeCallback(timer) {
    setState(() {
      dateTime = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    var date = DateFormat("dd/MM/yyyy").format(dateTime).replaceAll(",", " ");


    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsPage()));
              })
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                HourWidget(dateTime: dateTime, is24: is24),
                SeparatorWidget(),
                MinuteWidget(dateTime: dateTime),
                SeparatorWidget(),
                SecondWidget(dateTime: dateTime),
              ],
            ),
            Row(children: List.generate(date.length, (index) {
              if(date[index]==' ')
                return Text(" ");
              return TextWithBackground(date[index]);
            }).toList(),mainAxisSize: MainAxisSize.min,)
          ],
        ),
      ),
    );
  }
}

class HourWidget extends StatelessWidget {
  final DateTime dateTime;
  final bool is24;

  const HourWidget({Key key, this.dateTime, this.is24 = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            Text("8", style: placeHolderTextStyle, strutStyle: strutStyle),
            Text(
              is24
                  ? "${dateTime.hr24}".split("")[0]
                  : "${dateTime.hr} ".split("")[0],
              style: textStyle,
              strutStyle: strutStyle,
            ),
          ],
        ),
        Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            Text("8", style: placeHolderTextStyle, strutStyle: strutStyle),
            Text(
              is24
                  ? "${dateTime.hr24}".split("")[1]
                  : "${dateTime.hr} ".split("")[1],
              style: textStyle,
              strutStyle: strutStyle,
            ),
          ],
        ),
      ],
    );
  }
}

class SeparatorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          ":",
          style: placeHolderTextStyle,
          strutStyle: strutStyle,
        ),
        Text(
          ":",
          style: textStyle,
          strutStyle: strutStyle,
        ),
      ],
    );
  }
}

class MinuteWidget extends StatelessWidget {
  final DateTime dateTime;

  const MinuteWidget({Key key, this.dateTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            Text(
              "8",
              style: placeHolderTextStyle,
              strutStyle: strutStyle,
            ),
            Text(
              "${dateTime.min}".split("")[0],
              style: textStyle,
              strutStyle: strutStyle,
            ),
          ],
        ),
        Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            Text(
              "8",
              style: placeHolderTextStyle,
              strutStyle: strutStyle,
            ),
            Text(
              "${dateTime.min}".split("")[1],
              style: textStyle,
              strutStyle: strutStyle,
            ),
          ],
        ),
      ],
    );
  }
}

class SecondWidget extends StatelessWidget {
  final DateTime dateTime;

  const SecondWidget({Key key, this.dateTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            Text(
              "8",
              style: placeHolderTextStyle,
              strutStyle: strutStyle,
            ),
            Text(
              "${dateTime.sec}".split("")[0],
              style: textStyle,
              strutStyle: strutStyle,
            ),
          ],
        ),
        Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            Text(
              "8",
              style: placeHolderTextStyle,
              strutStyle: strutStyle,
            ),
            Text(
              "${dateTime.sec}".split("")[1],
              style: textStyle,
              strutStyle: strutStyle,
            ),
          ],
        ),
      ],
    );
  }
}

var textStyle =
    TextStyle(fontFamily: "digital", color: Color(0xff25fde6), fontSize: 150);
var strutStyle = StrutStyle(fontSize: 150, fontFamily: "digital");
var placeHolderTextStyle = TextStyle(
    fontFamily: "digital",
    color: Color(0xff3a4d49).withOpacity(0.5),
    fontSize: 150);
class TextWithBackground extends StatelessWidget {

  final String text;

  const TextWithBackground(this.text,{Key key} ) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.centerEnd,
      children: [
        Text(
          "8",
          style: placeHolderTextStyle.copyWith(fontSize: 50),
        ),
        Text(
          text,
          style: textStyle.copyWith(fontSize: 50),
        ),
      ],
    );
  }
}
