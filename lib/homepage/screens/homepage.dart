import 'package:flutter/material.dart';
import 'package:learn_it/addcourses_page/screens/addcourses_page.dart';
import 'package:learn_it/attendance_page/screens/attendance_page.dart';
import 'package:learn_it/dashboard_page/screens/dashboard_page.dart';
import 'package:learn_it/homepage/providers/dashboard_provider.dart';
import 'package:learn_it/profile_page/screens/profile_page.dart';
import 'package:learn_it/schedule_page/screens/schedule_page.dart';
import 'package:provider/provider.dart';

import '../../common/widgets/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashBoardProvider>(context);
    final dashboardData = dashboardProvider.dashboardData;

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final pages = [
      DashBoardPage(),
      TodaySchedulePage(),
      AttendancePage(),
      AddCoursesPage(),
      ProfilePage()
    ];
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Palette.kToDark,
          backgroundColor: Colors.grey,
          unselectedItemColor: Colors.grey,
          // ignore: prefer_const_literals_to_create_immutables
          items: [
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.dashboard,
                ),
                label: "Dashboard"),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.access_time_filled,
                ),
                label: "Today's Schedule"),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.task_alt,
                ),
                label: "Attendance"),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_box_rounded,
                ),
                label: "Add Courses"),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: "Profile")
          ],
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          currentIndex: index),
    );
  }
}
