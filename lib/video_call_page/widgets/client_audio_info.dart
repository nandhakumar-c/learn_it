import 'package:flutter/material.dart';
import 'package:learn_it/video_call_page/providers/video_call_provider.dart';
import 'package:provider/provider.dart';

class ClientAudioInfoButton extends StatefulWidget {
  const ClientAudioInfoButton({super.key});

  @override
  State<ClientAudioInfoButton> createState() => _ClientAudioInfoButtonState();
}

class _ClientAudioInfoButtonState extends State<ClientAudioInfoButton> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final clientAudio = Provider.of<VideoCallProvider>(context);
    return clientAudio.clientAudioEnabled
        ? IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Color.fromARGB(136, 128, 128, 128),
            ),
            onPressed: () {},
            icon: const Icon(
              Icons.mic,
              size: 15,
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
              size: 15,
            ),
            color: const Color(0xff808080));
  }
}
