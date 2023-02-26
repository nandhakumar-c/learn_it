import 'package:flutter/material.dart';

import 'dart:math' as math;
import 'dart:ui';

import '../../common/utils/screen_size.dart';

class ModalBottomSheet extends StatefulWidget {
  // BuildContext context;
  // String courseName;
  // String time;
  // String instructorName;
  // ModalBottomSheet(
  //     {required this.context,
  //     required this.courseName,
  //     required this.time,
  //     required this.instructorName,
  //     super.key});

  @override
  State<ModalBottomSheet> createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<ModalBottomSheet>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  double get maxHeight => SizeConfig.height as double;
  double startTextSize = 20;
  double endTextSize = 40;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
  }

  lerp(double min, double max) {
    return lerpDouble(min, max, _controller!.value);
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller!,
      builder: (context, child) {
        return Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: lerp(120, maxHeight),
          child: GestureDetector(
              child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
          )),
        );
      },
    );
  }
}
/*class ModalBottomSheet {
  BuildContext context;
  String courseName;
  String time;
  String instructorName;
  ModalBottomSheet(
      {required this.context,
      required this.courseName,
      required this.time,
      required this.instructorName});

  bottomsheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(children: [
            Container(
              height: SizeConfig.height! * 20,
            ),
          ]);
        });
  }
}*/
