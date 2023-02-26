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
        backgroundColor: Color.fromARGB(136, 128, 128, 128),
      ),
      onPressed: () {},
      icon: Icon(Icons.more_vert),
      color: Color(0xffffffff),
    );
  }
}
