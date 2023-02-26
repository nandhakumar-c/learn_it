import 'package:flutter/material.dart';

class VideoButton extends StatefulWidget {
  const VideoButton({super.key});

  @override
  State<VideoButton> createState() => _VideoButtonState();
}

class _VideoButtonState extends State<VideoButton> {
  bool isVideoEnabled = true;
  @override
  Widget build(BuildContext context) {
    return isVideoEnabled
        ? IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Color.fromARGB(136, 128, 128, 128),
            ),
            onPressed: () {
              setState(() {
                isVideoEnabled = !isVideoEnabled;
              });
            },
            icon: Icon(Icons.videocam),
            color: Color(0xffffffff),
          )
        : IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Color(0xffffffff),
            ),
            onPressed: () {
              setState(() {
                isVideoEnabled = !isVideoEnabled;
              });
            },
            icon: const Icon(
              Icons.videocam_off,
              color: Color(0xff808080),
            ));
  }
}
