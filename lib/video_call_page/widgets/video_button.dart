import 'package:flutter/material.dart';
import 'package:learn_it/video_call_page/providers/video_call_provider.dart';
import 'package:provider/provider.dart';

class VideoButton extends StatefulWidget {
  const VideoButton({super.key});

  @override
  State<VideoButton> createState() => _VideoButtonState();
}

class _VideoButtonState extends State<VideoButton> {
  @override
  Widget build(BuildContext context) {
    final videoProvider = Provider.of<VideoCallProvider>(context);
    return videoProvider.isVideoEnabled
        ? IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Color.fromARGB(136, 128, 128, 128),
            ),
            onPressed: () {
              videoProvider.videoSwitch();
            },
            icon: Icon(
              Icons.videocam,
              color: Color(0xffffffff),
            ),
          )
        : IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Color(0xffffffff),
            ),
            onPressed: () {
              videoProvider.videoSwitch();
            },
            icon: const Icon(
              Icons.videocam_off,
              color: Color(0xff808080),
            ));
  }
}
