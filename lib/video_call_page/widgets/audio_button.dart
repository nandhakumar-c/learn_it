import 'package:flutter/material.dart';
import 'package:learn_it/video_call_page/providers/video_call_provider.dart';
import 'package:provider/provider.dart';

class AudioButton extends StatefulWidget {
  const AudioButton({super.key});

  @override
  State<AudioButton> createState() => _AudioButtonState();
}

class _AudioButtonState extends State<AudioButton> {
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
            onPressed: () {
              audioTrigger.audioSwitch();
            },
            icon: Icon(Icons.mic),
            color: Color(0xffffffff),
          )
        : IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Color(0xffffffff),
            ),
            onPressed: () {
              audioTrigger.audioSwitch();
            },
            icon: const Icon(
              Icons.mic_off,
              color: Color(0xff808080),
            ));
  }
}
