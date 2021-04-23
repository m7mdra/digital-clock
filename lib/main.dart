import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
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
  bool is24 = true;
  @override
  void initState() {
    super.initState();
    dateTime = new DateTime.now();
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
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(child: HourWidget(dateTime: dateTime, is24: is24),onTap: (){
                  setState(() {
                    // is24 = !is24;
                  });
                },),
                // Text("Tap to change to 12 format",style: textStyle.copyWith(fontSize: 12),)
              ],
            ),
            SeparatorWidget(),
            MinuteWidget(dateTime: dateTime),
            SeparatorWidget(),
            SecondWidget(dateTime: dateTime),
          ],
        ),
      ),
      backgroundColor: Color(0xff04252e),
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
              is24? "${dateTime.hour}": "${dateTime.hour}".split("")[0],

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
              is24? "${dateTime.hour}": "${dateTime.hour} ".split("")[1],
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
              dateTime.minute < 10
                  ? "0${dateTime.minute}".split("")[0]
                  : "${dateTime.minute}".split("")[0],
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
              dateTime.minute < 10
                  ? "0${dateTime.minute}".split("")[1]
                  : "${dateTime.minute}".split("")[1],
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
              dateTime.second < 10
                  ? "0${dateTime.second}".split("")[0]
                  : "${dateTime.second}".split("")[0],
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
              dateTime.second < 10
                  ? "0${dateTime.second}".split("")[1]
                  : "${dateTime.second}".split("")[1],
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
var placeHolderTextStyle =
    TextStyle(fontFamily: "digital", color: Color(0xff3a4d49).withOpacity(0.5), fontSize: 150);
