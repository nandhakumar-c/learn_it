import 'package:flutter/material.dart';

class TodaySchedulePage extends StatefulWidget {
  const TodaySchedulePage({super.key});

  @override
  State<TodaySchedulePage> createState() => _TodaySchedulePageState();
}

class _TodaySchedulePageState extends State<TodaySchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(child: Text("Schedules page")),
      ),
    );
  }
}
