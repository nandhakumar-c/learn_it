import 'package:flutter/material.dart';

class EndCallButton extends StatefulWidget {
  const EndCallButton({super.key});

  @override
  State<EndCallButton> createState() => _EndCallButtonState();
}

class _EndCallButtonState extends State<EndCallButton> {
  @override
  Widget build(BuildContext context) {
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
        onPressed: () {},
      ),
    );
  }
}
