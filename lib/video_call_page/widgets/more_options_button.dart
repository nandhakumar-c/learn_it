import 'package:flutter/material.dart';

class MoreOptionsButton extends StatefulWidget {
  const MoreOptionsButton({super.key});

  @override
  State<MoreOptionsButton> createState() => _MoreOptionsButtonState();
}

class _MoreOptionsButtonState extends State<MoreOptionsButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: IconButton.styleFrom(
        backgroundColor: const Color.fromARGB(136, 128, 128, 128),
      ),
      onPressed: () {},
      icon: const Icon(Icons.more_vert),
      color: const Color(0xffffffff),
    );
  }
}
