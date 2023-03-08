import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learn_it/dashboard_page/models/dashboard_model.dart';

class DashBoardProvider with ChangeNotifier {
  DashboardData? dashboardData; //Class or any datatype
  List<String> images = [
    "assets/images/Template1.jpg",
    "assets/images/Template2.jpg",
    "assets/images/Template3.jpg",
    "assets/images/Template4.jpg",
    "assets/images/Template5.jpg"
  ];
  void setDashboardData(String data) {
    dashboardData = dashboardDataFromJson(data);
    meetingFilterFunction();
    //filterTodaySchedule(); //assign values
  }

  List<Datum> currentMeeting = [];
  List<Datum> upcomingMeeting = [];

  Map<String, List<Datum>> filteredMeetings = {
    "currentMeeting": [],
    "upcomingMeeting": []
  };

//filters the today's currentMeeting and upcomingMeetings
  void meetingFilterFunction() {
    currentMeeting = [];
    upcomingMeeting = [];
    final todayDate = DateFormat("dd/MM/yyyy").format(DateTime.now());

    for (int index = 0; index < dashboardData!.data.length; index++) {
      final courseDate = DateFormat("dd/MM/yyyy")
          .format(dashboardData!.data[index].scheduleDate);
      final courseStartTime = dashboardData!.data[index].scheduleDate;
      final courseEndTime = dashboardData!.data[index].endDateTime;
      print(courseEndTime);
      if (courseDate == todayDate) {
        if (courseStartTime.isBefore(DateTime.now()) &&
            courseEndTime!.isAfter(DateTime.now())) {
          print("currentMeeting => ${dashboardData!.data[index].courseName}");
          currentMeeting.add(dashboardData!.data[index]);
          filteredMeetings.update("currentMeeting", (value) {
            value = [...currentMeeting];

            return value;
          });
        } else if (courseEndTime!.isAfter(DateTime.now())) {
          print("upcomingMeeting => ${dashboardData!.data[index].courseName}");
          upcomingMeeting.add(dashboardData!.data[index]);
          filteredMeetings.update("upcomingMeeting", (value) {
            value = [...upcomingMeeting];
            return value;
          });
        }
      }
    }
    notifyListeners();
    // return;
  }

  List<Datum> todaySchedule = [];
  List<String> map = [];
  List<Datum> filterTodaySchedule() {
    for (int i = 0; i < dashboardData!.data.length; i++) {
      final subject = dashboardData!.data[i];
      final date = DateFormat("dd-mm-yyyy").format(subject.scheduleDate);
      final todayDate = DateFormat("dd-mm-yyyy").format(DateTime.now());
      String id = dashboardData!.data[i].id;
      if (date == todayDate &&
          !map.contains(id) &&
          subject.scheduleDate.isBefore(DateTime.now())) {
        map.add(id);
        todaySchedule.add(subject);
      }
    }
    print("====FILTER====");
    return todaySchedule;
  }
}
