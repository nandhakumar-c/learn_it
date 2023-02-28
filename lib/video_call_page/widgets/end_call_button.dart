import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:learn_it/video_call_page/providers/video_call_provider.dart';
import 'package:provider/provider.dart';

class EndCallButton extends StatefulWidget {
  RTCVideoRenderer localRenderer;

  EndCallButton({required this.localRenderer, super.key});

  @override
  State<EndCallButton> createState() => _EndCallButtonState();
}

class _EndCallButtonState extends State<EndCallButton> {
  @override
  Widget build(BuildContext context) {
    final videoProvider = Provider.of<VideoCallProvider>(context);
    return SizedBox(
      height: 48,
      width: 48,
      child: IconButton(
        style: IconButton.styleFrom(
          backgroundColor: Color(0xffFF002E),
        ),
        icon: const Icon(
          Icons.call_end,
          color: Color(0xffffffff),
        ),
        onPressed: () {
          videoProvider.hangUp(widget.localRenderer);
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
