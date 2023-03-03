import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learn_it/common/models/userlogin_payload_model.dart';
import 'package:learn_it/common/widgets/button.dart';
import 'package:learn_it/dashboard_page/models/dashboard_model.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../common/providers/backend_provider.dart';
import '../../common/utils/color.dart';
import '../../common/utils/screen_size.dart';
import '../../common/widgets/loading.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/dashboard_container_widget.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  late Future<String> myFuture;
  late String id;
  late String userType;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    String jwt = context.read<BackEndProvider>().jwt;
    String serverIp = context.read<BackEndProvider>().getLocalhost();

    id = context.read<BackEndProvider>().payloadData!.user.id;
    userType = context.read<BackEndProvider>().payloadData!.user.userType;
    print("Debug------> $userType");
    myFuture = getDashboardData(jwt, serverIp);
  }

  Future<String> getDashboardData(String jwtToken, String serverIp) async {
    if (userType == "T") {
      print("teacher");
      var res = await http.get(Uri.parse("$serverIp/getAllcourses/$id"),
          headers: {"Authorization": jwtToken});

      //success prompt
      if (res.statusCode == 200) {
        print("Dashboard - Success");
        print(res.body);
        return res.body;
      }
    }
    if (userType == "S") {
      print("student");
      var res = await http.get(Uri.parse("$serverIp/getAllcourses"),
          headers: {"Authorization": jwtToken});

      //success prompt
      if (res.statusCode == 200) {
        print("Dashboard - Success Student");

        return res.body;
      }
    }

    return "";
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BackEndProvider>(context);

    //dashboardprovider
    final dashboardProvider = Provider.of<DashBoardProvider>(context);
    //final courseCount = dashboardProvider.dashboardData!.data.length;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    //function to get dashboard data
    String username = provider.payloadData!.user.username;
    return Scaffold(
        //backgroundColor: const Color(0xFFF2F2F2),
        appBar: AppBar(
          title: Text("Hi, $username"),
          automaticallyImplyLeading: false,
        ),
        /* body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            //shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                        text: "You have ",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.w600),
                        children: [
                          TextSpan(
                              text: "3",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color: CustomColor.primaryColor,
                                      fontWeight: FontWeight.bold)),
                          const TextSpan(text: " meetings today")
                        ]),
                  ),
                ),
              ),
              /* SizedBox(
              child: Lottie.asset(
                "assets/lottie/dashboard_meeting.json",
                height: SizeConfig.height! * 30,
                width: SizeConfig.height! * 30,
              ),
            ),*/
              SizedBox(
                height: SizeConfig.height! * 3,
              ),
              Text(
                "Current Meeting",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: CustomColor.primaryColor,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: SizeConfig.height! * 1.5,
              ),
              DashboardContainer(
                courseName: "Flutter Course",
                time: "04:00 - 05:00 PM",
                imgUrl: "assets/images/Template4.jpg",
              ),
              SizedBox(
                height: SizeConfig.height! * 5,
              ),
              Text(
                "Upcoming Meetings",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: SizeConfig.height! * 2,
              ),
              DashboardContainer(
                courseName: "React Native Course",
                time: "10:00 - 11:00 PM",
                imgUrl: "assets/images/Template3.jpg",
              ),
              SizedBox(
                height: SizeConfig.height! * 2,
              ),
              DashboardContainer(
                courseName: "Node JS",
                time: "06:00 - 07:00 PM",
                imgUrl: "assets/images/Template1.jpg",
              ),
              SizedBox(
                height: SizeConfig.height! * 2,
              ),
              DashboardContainer(
                courseName: "React Native Course",
                time: "10:00 - 11:00 PM",
                imgUrl: "assets/images/Template3.jpg",
              ),
              SizedBox(
                height: SizeConfig.height! * 2,
              ),
              DashboardContainer(
                courseName: "Node JS",
                time: "06:00 - 07:00 PM",
                imgUrl: "assets/images/Template1.jpg",
              ),
              SizedBox(
                height: SizeConfig.height! * 2,
              ),
              DashboardContainer(
                courseName: "React Native Course",
                time: "10:00 - 11:00 PM",
                imgUrl: "assets/images/Template3.jpg",
              ),
              SizedBox(
                height: SizeConfig.height! * 2,
              ),
              DashboardContainer(
                courseName: "Node JS",
                time: "06:00 - 07:00 PM",
                imgUrl: "assets/images/Template1.jpg",
              ),
            ],
          ),
        )*/

        body: FutureBuilder(
          future: myFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              final dashboardData =
                  dashboardDataFromJson(snapshot.data as String);
              dashboardProvider.setDashboardData(snapshot.data as String);
              int numberOfCourses =
                  dashboardProvider.dashboardData!.data.length;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  //shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(
                              text: "You have ",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontWeight: FontWeight.w600),
                              children: [
                                TextSpan(
                                    text: numberOfCourses.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontWeight: FontWeight.bold)),
                                const TextSpan(text: " meetings today")
                              ]),
                        ),
                      ),
                    ),
                    /* SizedBox(
              child: Lottie.asset(
                "assets/lottie/dashboard_meeting.json",
                height: SizeConfig.height! * 30,
                width: SizeConfig.height! * 30,
              ),
            ),*/
                    SizedBox(
                      height: SizeConfig.height! * 3,
                    ),
                    Text(
                      "Current Meeting",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: SizeConfig.height! * 1.5,
                    ),
                    dashboardProvider.todaySchedule.length == 0
                        ? Container(
                            child: Column(
                              children: [
                                SizedBox(
                                    height: SizeConfig.height! * 20,
                                    child: Lottie.asset(
                                        "assets/lottie/no_meeting.json")),
                                Text(
                                  "You have no meetings right now",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          // color: Color(0xffFF888F),
                                          fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          )
                        : ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            separatorBuilder: (context, index) => SizedBox(
                              height: SizeConfig.height! * 2,
                            ),
                            itemCount: dashboardProvider.todaySchedule.length,
                            itemBuilder: (context, index) {
                              final dashboardvalue =
                                  dashboardProvider.todaySchedule[index];
                              final cardDetails = dashboardData.data[index];
                              final dateFormat =
                                  DateFormat("MMM dd, yyyy HH:mm a");
                              String dateInput = dateFormat.format(
                                  DateTime.parse(
                                      cardDetails.scheduleDate.toString()));

                              String date = DateFormat("MMM dd, yyyy").format(
                                  DateTime.parse(
                                      cardDetails.scheduleDate.toString()));
                              String time = DateFormat("hh:mm:a").format(
                                  DateTime.parse(
                                      cardDetails.scheduleDate.toString()));
                              print(dashboardProvider.todaySchedule.length);
                              return dashboardProvider.todaySchedule.length == 0
                                  ? Container(
                                      height: 50,
                                      width: 50,
                                      child: Lottie.asset(
                                          "assets/lottie/no_meeting.json"),
                                    )
                                  : DashboardContainer(
                                      index: index,
                                      time: time,
                                      courseName: dashboardvalue.courseName,
                                      imgUrl:
                                          dashboardProvider.images[index % 5]);
                            },
                          ),
                    SizedBox(
                      height: SizeConfig.height! * 5,
                    ),
                    Text(
                      "Upcoming Meetings",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: SizeConfig.height! * 2,
                    ),
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => SizedBox(
                        height: SizeConfig.height! * 2,
                      ),
                      itemCount: dashboardData.data.length,
                      itemBuilder: (context, index) {
                        final dashboardvalue = dashboardData.data[index];
                        final cardDetails = dashboardData.data[index];
                        final dateFormat = DateFormat("MMM dd, yyyy HH:mm a");
                        String dateInput = dateFormat.format(DateTime.parse(
                            cardDetails.scheduleDate.toString()));
                        // print(
                        //     "Input Value =====> ${cardDetails.scheduleDate.toString()}");
                        // print("dateformat ------->  ${dateInput}");

                        String date = DateFormat("MMM dd, yyyy").format(
                            DateTime.parse(
                                cardDetails.scheduleDate.toString()));
                        String time = DateFormat("hh:mm:a").format(
                            DateTime.parse(
                                cardDetails.scheduleDate.toString()));

                        /*final parsedDate =
                          cardDetails.scheduleDate.toString().parseToDate();
                      print(parsedDate.toIso8601String());*/
                        return DashboardContainer(
                            index: index,
                            time: time,
                            courseName: dashboardvalue.courseName,
                            imgUrl: dashboardProvider.images[index % 5]);
                      },
                    ),
                  ],
                ),
              );
            } else {
              return const LoadingScreen();
            }
          },
        ));
  }
}


/* 
final cardDetails = dashboardData.data[index];
                      final dateFormat = DateFormat("MMM dd, yyyy HH:mm a");
                      String dateInput = dateFormat.format(
                          DateTime.parse(cardDetails.scheduleDate.toString()));
                      // print(
                      //     "Input Value =====> ${cardDetails.scheduleDate.toString()}");
                      // print("dateformat ------->  ${dateInput}");

                      String date = DateFormat("MMM dd, yyyy").format(
                          DateTime.parse(cardDetails.scheduleDate.toString()));
                      String time = DateFormat("hh:mm:a").format(
                          DateTime.parse(cardDetails.scheduleDate.toString()));
*/

//old layout
/*
 return Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: ListView(
                shrinkWrap: true,
                children: [
                  const Padding(padding: EdgeInsets.all(5)),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: width * 0.5,
                        childAspectRatio: 2.75 / 4.5,
                        mainAxisSpacing: 30,
                        crossAxisSpacing: 20),
                    //GridBuilder

                    itemBuilder: (context, index) {
                      final cardDetails = dashboardData.data[index];
                      final dateFormat = DateFormat("MMM dd, yyyy HH:mm a");
                      String dateInput = dateFormat.format(
                          DateTime.parse(cardDetails.scheduleDate.toString()));
                      // print(
                      //     "Input Value =====> ${cardDetails.scheduleDate.toString()}");
                      // print("dateformat ------->  ${dateInput}");

                      String date = DateFormat("MMM dd, yyyy").format(
                          DateTime.parse(cardDetails.scheduleDate.toString()));
                      String time = DateFormat("hh:mm:a").format(
                          DateTime.parse(cardDetails.scheduleDate.toString()));

                      /*final parsedDate =
                          cardDetails.scheduleDate.toString().parseToDate();
                      print(parsedDate.toIso8601String());*/

                      //----Styled Container here----
                      return ClayContainer(
                        //padding: EdgeInsets.all(10),
                        height: 100,
                        width: 50,
                        depth: 10,
                        spread: 3.5,

                        customBorderRadius: const BorderRadius.only(
                            topRight: Radius.elliptical(30, 30),
                            bottomLeft: Radius.circular(30)),
                        color: const Color(0xFFF2F2F2),

                        child: Column(
                          children: [
                            //Course Heading
                            Flexible(
                              flex: 1,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                width: 200,
                                height: 75,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.elliptical(30, 30),
                                    ),
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color.fromARGB(255, 9, 43, 101),
                                          Color.fromARGB(180, 14, 96, 195),
                                        ])),
                                child: Text(
                                  cardDetails.courseName,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                            //Course Description
                            Flexible(
                              flex: 3,
                              child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(30)),
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color.fromARGB(255, 173, 210, 255),
                                          Colors.white
                                        ])),
                                padding: const EdgeInsets.all(10),
                                height: 250,
                                //course description
                                width: 200,
                                child: Column(
                                  children: [
                                    Flexible(
                                      flex: 2,
                                      child: Container(
                                        height: 110,
                                        child: Text(
                                          cardDetails.description,
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ),
                                    ),
                                    //course time

                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.calendar_month,
                                              size: 18,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              date,
                                              style:
                                                  const TextStyle(fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.access_time_filled_outlined,
                                              size: 18,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(time),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: InkWell(
                                        onTap: () {},
                                        child: Container(
                                            height: 30,
                                            width: 70,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                gradient: const LinearGradient(
                                                    colors: [
                                                      Color.fromARGB(
                                                          215, 27, 87, 191),
                                                      Color.fromARGB(
                                                          180, 14, 96, 195),
                                                    ])),
                                            alignment: Alignment.center,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              // ignore: prefer_const_literals_to_create_immutables
                                              children: [
                                                const Icon(
                                                    Icons.video_call_rounded,
                                                    color: Colors.white),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                const Text(
                                                  "Join",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: dashboardData.data.length,
                  ),
                ],
              ),
            );
 */