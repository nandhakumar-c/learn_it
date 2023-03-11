import 'package:flutter/material.dart';
import 'package:learn_it/video_call_page/providers/video_call_provider.dart';
import 'package:provider/provider.dart';

class RedAudioButton extends StatefulWidget {
  const RedAudioButton({super.key});

  @override
  State<RedAudioButton> createState() => _RedAudioButtonState();
}

class _RedAudioButtonState extends State<RedAudioButton> {
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
              backgroundColor: const Color.fromARGB(136, 128, 128, 128),
            ),
            onPressed: () {
              audioTrigger.audioSwitch();
            },
            icon: const Icon(Icons.mic),
            color: const Color(0xffffffff),
          )
        : IconButton(
            style: IconButton.styleFrom(
              backgroundColor: const Color(0xffFF002E),
            ),
            onPressed: () {
              audioTrigger.audioSwitch();
            },
            icon: const Icon(
              Icons.mic_off,
              color: Color(0xffffffff),
            ));
  }
}
