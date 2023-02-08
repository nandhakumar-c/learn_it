import 'package:flutter/material.dart';
import 'package:learn_it/homepage/models/dashboard_model.dart';

class DashBoardProvider with ChangeNotifier {
  DashboardData? dashboardData;
  void setDashboardData(String data) {
    dashboardData = dashboardDataFromJson(data);
    notifyListeners();
  }
}
