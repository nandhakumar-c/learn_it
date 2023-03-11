import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn_it/common/routes/app_routes.dart';
import 'package:learn_it/dashboard_page/providers/dashboard_provider.dart';
import 'package:learn_it/dashboard_page/screens/dashboard_page.dart';
import 'package:learn_it/dashboard_page/widgets/red_audio_button.dart';
import 'package:learn_it/dashboard_page/widgets/red_video_button.dart';
import 'package:learn_it/video_call_page/widgets/audio_button.dart';
import 'package:learn_it/video_call_page/widgets/video_button.dart';
import 'package:provider/provider.dart';

import 'dart:math' as math;
import 'dart:ui';

import '../../common/utils/color.dart';
import '../../common/utils/screen_size.dart';
import '../utils/path_constant.dart';
import 'join_button.dart';

//Use AnimatedBuilder widget

class ModalBottomSheet extends StatefulWidget {
  BuildContext context;

  int index;
  String meetingType;
  String date;
  String time;
  // DraggableScrollableController _scrollController;

  Widget child;
  ModalBottomSheet(
      {required this.index,
      required this.context,
      required this.meetingType,
      required this.time,
      required this.date,
      //required this._scrollController,

      required this.child});

  @override
  State<ModalBottomSheet> createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<ModalBottomSheet>
    with SingleTickerProviderStateMixin {
  DraggableScrollableController _scrollController =
      DraggableScrollableController();
  AnimationController? animationController;
  double offset = 0;
  GlobalKey _sheetKey = GlobalKey();
  double maxHeight = (SizeConfig.height! * 100 - 40);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scrollController = DraggableScrollableController();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _scrollController.addListener(() {
      offset = _scrollController.pixels;
      //print("Offset value $offset");
      // print("Offset ---> ${_scrollController!.pixels}");
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
    animationController!.dispose();
  }

  lerp(double min, double max) {
    // print(lerpDouble(min, max, offset));

    return lerpDouble(min, max, animationController!.value);
  }

  lerpColor(Color color1, Color color2) {
    return Color.lerp(color1, color2, animationController!.value);
  }

  toggle() {
    bool isCompleted = animationController!.status == AnimationStatus.completed;
    animationController!.fling(velocity: isCompleted ? -1 : 1);
  }

  verticalDragUpdate(DragUpdateDetails details) {
    animationController!.value -= details.primaryDelta! / maxHeight;
  }

  verticalDragEndDetails(DragEndDetails details) {
    if (animationController!.isAnimating ||
        animationController!.status == AnimationStatus.completed) return;

    double flingVelocity = details.velocity.pixelsPerSecond.dy / maxHeight;
    if (flingVelocity < 0) {
      animationController!.fling(velocity: math.max(1, -flingVelocity));
    } else if (flingVelocity > 0) {
      animationController!.fling(velocity: math.min(-1, -flingVelocity));
    } else {
      animationController!.fling(velocity: flingVelocity < 0.5 ? -1 : 1);
    }
  }

  String? linkMessage;
  bool _isCreatingLink = false;

  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  Future createDynamicLink(bool short, String link) async {
    setState(() {
      _isCreatingLink = true;
    });

    final parameters = DynamicLinkParameters(
      link: Uri.parse(kUriPrefix + link),
      uriPrefix: kUriPrefix,
      androidParameters: AndroidParameters(
          packageName: "com.example.learn_it", minimumVersion: 0),
    );

    Uri url;
    if (short) {
      final shortLink = await dynamicLinks.buildShortLink(parameters);
      url = shortLink.shortUrl;
    } else {
      url = await dynamicLinks.buildLink(parameters);
    }

    setState(() {
      _isCreatingLink = false;
      linkMessage = url.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashBoardProvider>(context)
        .filteredMeetings[widget.meetingType]![widget.index];
    final courseName = dashboardProvider.courseName;
    final courseDescription = dashboardProvider.description;
    final instructor = dashboardProvider.teacherName;

    return InkWell(
        splashColor: CustomColor.primaryColor,
        child: widget.child,
        onTap: () {
          makeDismissable({required child}) {
            return GestureDetector(
                behavior: HitTestBehavior.opaque,
                // onDoubleTap: toggle,
                onTap: () => Navigator.of(context).pop(),
                child: GestureDetector(
                  onTap: toggle,
                  child: child,
                ));
          }

          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            // enableDrag: true,
            isScrollControlled: true,
            enableDrag: true,

            builder: (context) {
              return makeDismissable(
                child: Stack(
                  children: [
                    AnimatedBuilder(
                      animation: animationController!,
                      builder: (context, child) {
                        return Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          height: lerp(maxHeight * 0.2, maxHeight),
                          child: GestureDetector(
                              onVerticalDragUpdate: verticalDragUpdate,
                              onVerticalDragEnd: verticalDragEndDetails,
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: const AssetImage(
                                          "assets/images/Education.jpg"),
                                      fit: BoxFit.cover,
                                      opacity: lerp(0.0, 0.5)),
                                  color: Color.fromRGBO(
                                      lerp(255, 0).toInt(),
                                      lerp(255, 0).toInt(),
                                      lerp(255, 0).toInt(),
                                      1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                child: Stack(children: [
                                  /*----------------------------------- Deep Linking Setup ------------------------------------------ */
                                  Positioned(
                                      top: lerp(0, maxHeight * 0.05),
                                      right: lerp(2, 5),
                                      child: SizedBox(
                                        height: 52,
                                        width: 52,
                                        child: IconButton(
                                          onPressed: () {
                                            print("Inside Function");
                                            createDynamicLink(false,
                                                "${AppRoutes.preview}?meetingId=${dashboardProvider.roomId}");
                                            // createDynamicLink(
                                            //     false, "/attendance");
                                            print("Outside Function");

                                            Clipboard.setData(ClipboardData(
                                                text: linkMessage));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Copied to the Clipboard")));
                                          },
                                          icon: Icon(
                                            Icons.share,
                                            color: lerpColor(
                                                Colors.black, Colors.white),
                                          ),
                                        ),
                                      )),
                                  Positioned(
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        height: 4,
                                        width: lerp(25, 100),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: lerpColor(Color(0xff808080),
                                              Color(0xffffffff)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: lerp(10, maxHeight * 0.05),
                                    left: lerp(2, 10),
                                    child: Text(
                                      courseName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(
                                              fontSize: lerp(20, 30),
                                              fontWeight: FontWeight.w700,
                                              color: lerpColor(
                                                  CustomColor.primaryColor,
                                                  CustomColor.secondaryColor)),
                                    ),
                                  ),
                                  Positioned(
                                    top:
                                        lerp(maxHeight * 0.04, maxHeight * 0.1),
                                    left: lerp(0, 10),
                                    child: Container(
                                      height: maxHeight * 0.25,
                                      width: SizeConfig.width! * 80,
                                      child: Opacity(
                                        opacity: lerp(0, 1),
                                        child: Text(
                                          courseDescription,
                                          //softWrap: false,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: lerpColor(
                                                      Color(0xff808080),
                                                      Color(0xffffffff))),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: lerp(0, maxHeight * 0.35),
                                    left: lerp(0, 10),
                                    child: Text(
                                      "Timing",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(
                                              fontSize: lerp(0, 24),
                                              fontWeight: FontWeight.w700,
                                              color: lerpColor(
                                                  CustomColor.primaryColor,
                                                  CustomColor.secondaryColor)),
                                    ),
                                  ),
                                  Positioned(
                                    top: lerp(
                                        maxHeight * 0.057, maxHeight * 0.6),
                                    left: lerp(0, 10),
                                    child: Icon(
                                      Icons.access_time_filled_rounded,
                                      size: lerp(18, 0),
                                      color: Color(0xff808080),
                                    ),
                                  ),
                                  Positioned(
                                    top: lerp(
                                        maxHeight * 0.055, maxHeight * 0.4),
                                    left: lerp(20, 10),
                                    child: Text(
                                      widget.time,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              fontSize: lerp(16, 20),
                                              fontWeight: FontWeight.w500,
                                              color: lerpColor(
                                                  Color(0xff808080),
                                                  Color(0xffffffff))),
                                    ),
                                  ),
                                  Positioned(
                                    top: lerp(0, maxHeight * 0.55),
                                    left: lerp(0, 10),
                                    child: Text(
                                      "Instructor",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(
                                              fontSize: lerp(0, 24),
                                              fontWeight: FontWeight.w700,
                                              color: lerpColor(
                                                  CustomColor.primaryColor,
                                                  CustomColor.secondaryColor)),
                                    ),
                                  ),
                                  Positioned(
                                    top: lerp(
                                        maxHeight * 0.057, maxHeight * 0.6),
                                    left: lerp(maxHeight * 0.275, 10),
                                    child: Icon(
                                      Icons.person_rounded,
                                      size: lerp(18, 0),
                                      color: Color(0xff808080),
                                    ),
                                  ),
                                  Positioned(
                                    top: lerp(
                                        maxHeight * 0.055, maxHeight * 0.6),
                                    left: lerp(maxHeight * 0.3, 10),
                                    child: Text(
                                      instructor,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              fontSize: lerp(16, 20),
                                              fontWeight: FontWeight.w500,
                                              color: lerpColor(
                                                  Color(0xff808080),
                                                  Color(0xffffffff))),
                                    ),
                                  ),
                                  Positioned(
                                    top: lerp(maxHeight * 0.1, maxHeight - 100),
                                    child: Container(
                                      width: SizeConfig.width! * 90,
                                      child: Row(
                                        children: [
                                          RedAudioButton(),
                                          RedVideoButton(),
                                          Spacer(),
                                          SizedBox(
                                              height: 40,
                                              width: lerp(
                                                  78, SizeConfig.width! * 60),
                                              child: JoinButton(
                                                  index: widget.index)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                              )),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
            context: context,
          );
        });
  }
}

/*Stack(
                  children: [
                    DraggableScrollableSheet(
                      key: _sheetKey,
                      snap: true,
                      initialChildSize: 0.175,
                      minChildSize: 0.175,
                      maxChildSize: 0.95,
                      _scrollController: _scrollController,
                      builder: (context, scrollController) {
                        _scrollController!.addListener(() {
                          //print("-----${_scrollController!.pixels}");
                          //print(offset - (offset - 1));
                        });
                        return AnimatedBuilder(
                          animation: animationController!,
                          builder: (context, child) {
                            print("value ---> ${animationController!.value}");
                            return Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              child: SingleChildScrollView(
                                _scrollController: scrollController,
                                child: Container(
                                  height: SizeConfig.height! * 100,
                                  width: SizeConfig.width! * 100,
                                  padding: EdgeInsets.all(16),
                                  child: Stack(children: [
                                    AnimatedPositioned(
                                      top: 10,

                                      duration: Duration(milliseconds: 400),
                                      curve: Curves.easeInOut,
                                      //left: lerpDouble(10, 30, offset - (offset - 1)),
                                      child: Transform.translate(
                                        offset: Offset(10, 20),
                                        child: Text(
                                          widget.courseName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                      CustomColor.primaryColor),
                                        ),
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
                          },
                        );
                      },
                    ),
                    AnimatedBuilder(
                      animation: _scrollController!,
                      builder: (context, child) {
                        return Stack(
                          children: [
                            AnimatedPositioned(
                                top: _sheetKey.currentContext!.size!.height -
                                    _scrollController!.pixels,
                                child: Text(
                                  widget.courseName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: CustomColor.primaryColor),
                                ),
                                duration: Duration(milliseconds: 400))
                          ],
                        );
                      },
                    )
                  ],
                ), */

// class ModalBottomSheet {
//   bottomsheet() {
//     print("Offset === $offset");
//   }
// }

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
  AnimationController? __scrollController;
  double get maxHeight => SizeConfig.height as double;
  double startTextSize = 20;
  double endTextSize = 40;

  @override
  void initState() {
    super.initState();
    __scrollController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
  }

  lerp(double min, double max) {
    return lerpDouble(min, max, __scrollController!.value);
  }

  @override
  void dispose() {
    super.dispose();
    __scrollController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: __scrollController!,
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
