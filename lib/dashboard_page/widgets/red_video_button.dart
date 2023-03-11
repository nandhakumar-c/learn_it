import 'package:flutter/material.dart';
import 'package:learn_it/video_call_page/providers/video_call_provider.dart';
import 'package:provider/provider.dart';

class RedVideoButton extends StatefulWidget {
  const RedVideoButton({super.key});

  @override
  State<RedVideoButton> createState() => _RedVideoButtonState();
}

class _RedVideoButtonState extends State<RedVideoButton> {
  @override
  Widget build(BuildContext context) {
    final videoProvider = Provider.of<VideoCallProvider>(context);
    return videoProvider.isVideoEnabled
        ? IconButton(
            style: IconButton.styleFrom(
              backgroundColor: const Color.fromARGB(136, 128, 128, 128),
            ),
            onPressed: () {
              videoProvider.videoSwitch();
            },
            icon: const Icon(Icons.videocam),
            color: const Color(0xffffffff),
          )
        : IconButton(
            style: IconButton.styleFrom(
              backgroundColor: const Color(0xffFF002E),
            ),
            onPressed: () {
              videoProvider.videoSwitch();
            },
            icon: const Icon(
              Icons.videocam_off,
              color: Color(0xffffffff),
            ));
  }
}
