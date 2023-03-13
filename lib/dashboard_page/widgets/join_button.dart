import 'package:flutter/material.dart';
import 'package:learn_it/common/models/conference_meeting_model.dart';
import 'package:learn_it/common/providers/backend_provider.dart';
import 'package:learn_it/common/routes/app_routes.dart';
import 'package:learn_it/dashboard_page/providers/dashboard_provider.dart';
import 'package:learn_it/video_call_page/providers/video_call_provider.dart';
import 'package:provider/provider.dart';

import '../../common/models/userlogin_payload_model.dart';
import '../../common/providers/sharedpref.dart';
import '../../video_call_page/utils/api.dart';
import '../../video_call_page/utils/toast.dart';

import 'package:http/http.dart' as http;

class JoinButton extends StatefulWidget {
  int index;
  JoinButton({required this.index, super.key});

  @override
  State<JoinButton> createState() => _JoinButtonState();
}

class _JoinButtonState extends State<JoinButton> {
  String _token = "";
  late String id;
  late String userType;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final token = await fetchToken(context);
      setState(() => _token = token);
    });
  }

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashBoardProvider>(context);
    final userDetailsProvider = Provider.of<BackEndProvider>(context);
    final videoProvider = Provider.of<VideoCallProvider>(context);
    Future<void> joinMeeting(callType, displayName, meetingId) async {
      if (meetingId.isEmpty) {
        showSnackBarMessage(
            message: "Please enter Valid Meeting ID", context: context);
        return;
      }
      var validMeeting = await validateMeeting(_token, meetingId);
      if (validMeeting) {
        if (callType == "GROUP") {
          // ignore: use_build_context_synchronously
          final args = conferenceMeetingModelToJson(
            ConferenceMeetingModel(
              meetingId: meetingId,
              token: _token,
              displayName: displayName,
              micEnabled: videoProvider.isAudioEnabled,
              camEnabled: videoProvider.isVideoEnabled,
            ),
          );

          /* final provider = Provider.of<BackEndProvider>(context, listen: false);
          final payloadData =
              payloadFromJson(UserLoginDetails.getLoginData() as String);

          String jwt = UserLoginDetails.getJwtToken() as String;

          id = payloadData.user.id;
          userType = payloadData.user.userType;

          final res = await http.get(
              Uri.parse("${provider.getLocalhost()}/make-attendance/$id"),
              headers: {"Authorization": jwt});

          //success prompt
          if (res.statusCode == 200) {
            print("Dashboard - Success");

            print(res.body);
          } */

          Navigator.of(context)
              .pushNamed(AppRoutes.conference, arguments: args);
        }
      } else {
        // ignore: use_build_context_synchronously
        showSnackBarMessage(message: "Invalid Meeting ID", context: context);
      }
    }

    return FilledButton(
        onPressed: () {
          // Navigator.of(context).pop();
          print(
              "Index ==> ${dashboardProvider.dashboardData!.data[widget.index].roomId}");
          String meetingId =
              dashboardProvider.dashboardData!.data[widget.index].roomId;
          // String displayName = userDetailsProvider.payloadData!.user.username;
          final payloadData =
              payloadFromJson(UserLoginDetails.getLoginData() as String);
          String displayName = payloadData.user.username;
          joinMeeting("GROUP", displayName, meetingId);
          // Navigator.of(context).pushReplacement(MaterialPageRoute(
          //   builder: (context) => VideoCallScreen(),
          // ));
        },
        child: const Text("Join"));
  }
}
