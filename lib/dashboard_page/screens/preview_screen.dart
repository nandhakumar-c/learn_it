import 'package:flutter/material.dart';

class PreviewScreen extends StatefulWidget {
  String meetingId;
  PreviewScreen({required this.meetingId, super.key});

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(child: Text(widget.meetingId)),
      ),
    );
  }
}
