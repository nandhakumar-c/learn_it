import 'package:flutter/material.dart';
import 'package:learn_it/video_call_page/providers/video_call_provider.dart';
import 'package:provider/provider.dart';

class AudioInfoButton extends StatefulWidget {
  const AudioInfoButton({super.key});

  @override
  State<AudioInfoButton> createState() => _AudioInfoButtonState();
}

class _AudioInfoButtonState extends State<AudioInfoButton> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final audioTrigger = Provider.of<VideoCallProvider>(context);
    return audioTrigger.isAudioEnabled
        ? IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Color.fromARGB(136, 128, 128, 128),
            ),
            onPressed: () {},
            icon: const Icon(
              Icons.mic,
              size: 10,
            ),
            color: Color(0xffffffff),
          )
        : IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Color(0xffffffff),
            ),
            onPressed: () {},
            icon: const Icon(
              Icons.mic_off,
              size: 10,
            ),
            color: const Color(0xff808080));
  }
}
