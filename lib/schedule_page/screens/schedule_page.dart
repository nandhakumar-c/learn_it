import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TodaySchedulePage extends StatefulWidget {
  const TodaySchedulePage({super.key});

  @override
  State<TodaySchedulePage> createState() => _TodaySchedulePageState();
}

class _TodaySchedulePageState extends State<TodaySchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Today's Schedule Page")),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.calculate), label: "Dummy")
          ],
        ),
        body: SfCalendar(
          dataSource: MeetingDataSource(getAppointments()),
        ));
  }
}

Appointment returnAppointmentObject(
    startTime, endTime, String text, Color color) {
  return Appointment(
      startTime: startTime,
      endTime: endTime,
      color: color,
      subject: "Flutter Crash Course");
}

List<Appointment> getAppointments() {
  List<Appointment> appointments = [];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 15, 0, 0);
  final DateTime endTime = startTime.add(Duration(hours: 1));

  appointments.add(returnAppointmentObject(
      startTime, endTime, "Flutter Crash Course", Colors.green));
  return appointments;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
