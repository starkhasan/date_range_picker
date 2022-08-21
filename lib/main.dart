import 'package:flutter/material.dart';
import 'package:flutter_calendar/view/date_range_select.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DateRangeExample()
    );
  }
}
