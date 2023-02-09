import 'package:flutter/material.dart';
import 'package:learn_it/homepage/models/dashboard_model.dart';

class DashBoardProvider with ChangeNotifier {
  DashboardData? dashboardData; //Class or any datatype

  void setDashboardData(String data) {
    dashboardData = dashboardDataFromJson(data); //assign values
    notifyListeners();
  }
}
