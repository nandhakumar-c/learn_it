import 'package:flutter/material.dart';
import 'package:learn_it/common/providers/backend_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../common/models/userlogin_payload_model.dart';
import '../../common/providers/sharedpref.dart';
import '../../common/widgets/loading.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  late Future<String> myFuture;
  late String id;
  late String userType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final provider = Provider.of<BackEndProvider>(context, listen: false);
    final payloadData =
        payloadFromJson(UserLoginDetails.getLoginData() as String);

    String jwt = UserLoginDetails.getJwtToken() as String;

    id = payloadData.user.id;
    userType = payloadData.user.userType;
    myFuture = getDashboardData(jwt, provider.getLocalhost());
  }

  Future<String> getDashboardData(String jwtToken, String serverIp) async {
    print("teacher");
    var res = await http.get(Uri.parse("$serverIp/fetch-attendance/$id"),
        headers: {"Authorization": jwtToken});

    //success prompt
    if (res.statusCode == 200) {
      print("Dashboard - Success");

      print(res.body);
      return res.body;
    }
    return "No data fetched";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance"),
      ),
      body: FutureBuilder(
        future: myFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                Text(
                  snapshot.data.toString(),
                ),
              ],
            );
          } else {
            return const LoadingScreen();
          }
        },
      ),
    );
  }
}
