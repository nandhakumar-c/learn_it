import 'package:flutter/material.dart';
import 'package:learn_it/video_call_page/providers/video_call_provider.dart';
import 'package:provider/provider.dart';

class EndCallButton extends StatefulWidget {
  final void Function() onCallEndButtonPressed;
  const EndCallButton({required this.onCallEndButtonPressed, super.key});

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
          backgroundColor: const Color(0xffFF002E),
        ),
        icon: const Icon(
          Icons.call_end,
          color: Color(0xffffffff),
        ),
        onPressed: widget.onCallEndButtonPressed,
      ),
    );
  }
}
