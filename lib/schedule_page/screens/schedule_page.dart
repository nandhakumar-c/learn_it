import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:learn_it/dashboard_page/providers/dashboard_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../dashboard_page/models/dashboard_model.dart';

class TodaySchedulePage extends StatefulWidget {
  const TodaySchedulePage({super.key});

  @override
  State<TodaySchedulePage> createState() => _TodaySchedulePageState();
}

class _TodaySchedulePageState extends State<TodaySchedulePage> {
  List<Color> colors = [
    Colors.green,
    Colors.blue,
    Colors.red,
    Colors.purple,
    Colors.grey,
    Colors.deepOrange
  ];

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardData = Provider.of<DashBoardProvider>(context);
    final todaySchedule = dashboardData.dashboardData!.data;
    return Scaffold(
        appBar: AppBar(
          title: Text("Meeting Calendar"),
          automaticallyImplyLeading: false,
        ),
        body: SfCalendar(
          dataSource: MeetingDataSource(getAppointments(todaySchedule, colors)),
        ));
  }
}

Appointment returnAppointmentObject(
    startTime, endTime, String text, Color color) {
  return Appointment(
      startTime: startTime, endTime: endTime, color: color, subject: text);
}

List<Appointment> getAppointments(
    List<Datum> todaySchedule, List<Color> colors) {
  List<Appointment> appointments = [];
  // final DateTime today = DateTime.now();
  // final DateTime startTime =
  //     DateTime(today.year, today.month, today.day, 15, 0, 0);
  // final DateTime endTime = startTime.add(Duration(hours: 1));
  for (int i = 0; i < todaySchedule.length; i++) {
    print(todaySchedule[i].courseName);
    print("--------------");
    var startTime = todaySchedule[i].scheduleDate;
    var endTime = startTime.add(Duration(hours: 1));
    String courseTitle = todaySchedule[i].courseName;
    Color tileColor = colors[i % 6];
    // Color tileColor =
    //     Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    appointments.add(
        returnAppointmentObject(startTime, endTime, courseTitle, tileColor));
  }

  return appointments;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
