import 'package:flutter/material.dart';
import 'package:learn_it/dashboard_page/widgets/red_audio_button.dart';
import 'package:learn_it/dashboard_page/widgets/red_video_button.dart';
import 'package:learn_it/video_call_page/widgets/audio_button.dart';
import 'package:learn_it/video_call_page/widgets/video_button.dart';

import 'dart:math' as math;
import 'dart:ui';

import '../../common/utils/color.dart';
import '../../common/utils/screen_size.dart';
import 'join_button.dart';

class ModalBottomSheet {
  BuildContext context;
  String courseName;
  String time;
  String instructorName;
  DraggableScrollableController controller;
  double? offset;
  ModalBottomSheet(
      {required this.context,
      required this.courseName,
      required this.time,
      required this.instructorName,
      required this.controller,
      required this.offset});

  makeDismissable({required child}) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ));
  }

  bottomsheet() {
    print("Offset === $offset");
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      // enableDrag: true,
      isScrollControlled: true,
      enableDrag: true,

      builder: (context) {
        return makeDismissable(
          child: NotificationListener<DraggableScrollableNotification>(
            onNotification: (notification) {
              // print("${notification.extent}");
              // print("Lerp Value - ${lerpDouble(10, 20, notification.extent)}");
              return true;
            },
            child: DraggableScrollableSheet(
              snap: true,
              initialChildSize: 0.175,
              minChildSize: 0.175,
              maxChildSize: 0.95,
              controller: controller,
              builder: (context, scrollController) {
                // print(controller.pixels);
                // print("Scroll value - ${scrollController.initialScrollOffset}");

                return AnimatedBuilder(
                    animation: scrollController,
                    builder: (context, child) {
                      if (scrollController.hasClients) {
                        print(scrollController.offset);
                      }

                      return Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Container(
                            height: SizeConfig.height! * 100,
                            width: SizeConfig.width! * 100,
                            padding: EdgeInsets.all(16),
                            child: Stack(children: [
                              Positioned(
                                left: 10,
                                child: Text(
                                  courseName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: CustomColor.primaryColor),
                                ),
                              ),
                              Positioned(
                                  top: 50,
                                  child: Container(
                                    width: SizeConfig.width! * 90,
                                    child: Row(
                                      children: const [
                                        RedAudioButton(),
                                        RedVideoButton(),
                                        Spacer(),
                                        JoinButton(),
                                      ],
                                    ),
                                  ))
                            ]),
                          ),
                        ),
                      );
                    });
              },
            ),
          ),
        );
      },
      context: context,
    );
  }
}

/*class ModalBottomSheet extends StatefulWidget {
  BuildContext context;
  String courseName;
  String time;
  String instructorName;
  ModalBottomSheet(
      {required this.context,
      required this.courseName,
      required this.time,
      required this.instructorName,
      super.key});

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
} */
