import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learn_it/common/models/userlogin_payload_model.dart';
import 'package:learn_it/common/widgets/button.dart';
import 'package:learn_it/homepage/models/dashboard_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../common/providers/backend_provider.dart';
import '../../homepage/providers/dashboard_provider.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  late Future<String> myFuture;
  late String id;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String jwt = context.read<BackEndProvider>().jwt;
    String serverIp = context.read<BackEndProvider>().getLocalhost();
    myFuture = getDashboardData(jwt, serverIp);
    id = context.read<BackEndProvider>().payloadData!.user.id;
  }

  Future<String> getDashboardData(String jwtToken, String serverIp) async {
    print("Testing Id ===> $id");
    var res = await http.get(Uri.parse("$serverIp/getAllcourses/"),
        headers: {"Authorization": jwtToken});
    print("Dashboard - Success");
    //success prompt
    if (res.statusCode == 200) {
      print("Dashboard - Success");

      return res.body;
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BackEndProvider>(context);

    //dashboardprovider
    final dashboardProvider = Provider.of<DashBoardProvider>(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

//function to get dashboard data

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        title: const Text("Dashboard page"),
        leading: IconButton(icon: Icon(Icons.chevron_left), onPressed: () {}),
      ),
      body: FutureBuilder(
        future: myFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final dashboardData =
                dashboardDataFromJson(snapshot.data as String);

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
                      String dateFormat = DateFormat("MMM dd, yyyy hh:mm a")
                          .format(DateTime.parse(
                              cardDetails.scheduleDate.toString()));
                      String date = DateFormat("MMM dd, yyyy").format(
                          DateTime.parse(cardDetails.scheduleDate.toString()));
                      String time = DateFormat("hh:mm:a").format(
                          DateTime.parse(cardDetails.scheduleDate.toString()));

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
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
