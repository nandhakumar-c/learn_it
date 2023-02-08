import 'package:flutter/material.dart';
import 'package:learn_it/homepage/providers/dashboard_provider.dart';
import 'package:provider/provider.dart';

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

    return Scaffold(
      appBar: AppBar(title: const Text("HomePage")),
      body: ListView(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: width * 0.5,
              childAspectRatio: 3 / 4,
            ),
            //GridBuilder
            itemBuilder: (context, index) {
              final cardDetails = dashboardData!.data[index];
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  //----Styled Container here----
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: 50,
                    width: 50,
                    color: Colors.grey,
                    child: Column(
                      children: [
                        Text(cardDetails.courseName),
                        Text(cardDetails.description),
                        Text(cardDetails.scheduleDate.toIso8601String())
                      ],
                    ),
                  ));
            },
            itemCount: 2,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.purple,
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
