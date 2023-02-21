import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learn_it/dashboard_page/models/dashboard_model.dart';

class DashBoardProvider with ChangeNotifier {
  DashboardData? dashboardData; //Class or any datatype

  void setDashboardData(String data) {
    dashboardData = dashboardDataFromJson(data);
    filterTodaySchedule(); //assign values
  }

  List<Datum> todaySchedule = [];
  List<String> map = [];
  List<Datum> filterTodaySchedule() {
    for (int i = 0; i < dashboardData!.data.length; i++) {
      final subject = dashboardData!.data[i];
      final date = DateFormat("dd-MM-yyyy").format(subject.scheduleDate);
      final todayDate = DateFormat("dd-MM-yyyy").format(DateTime.now());
      String id = dashboardData!.data[i].id;
      if (date == todayDate && !map.contains(id)) {
        map.add(id);
        todaySchedule.add(subject);
      }
      print("Filter Function Called $i times");
    }

    return todaySchedule;
  }
}
