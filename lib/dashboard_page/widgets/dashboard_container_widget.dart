import 'package:flutter/material.dart';
import 'package:learn_it/dashboard_page/widgets/join_button.dart';
import 'package:learn_it/dashboard_page/widgets/modalbottomsheet.dart';
import 'package:learn_it/dashboard_page/widgets/red_audio_button.dart';
import 'package:learn_it/dashboard_page/widgets/red_video_button.dart';

import '../../common/utils/color.dart';
import '../../common/utils/screen_size.dart';

class DashboardContainer extends StatefulWidget {
  String time;
  String courseName;
  String imgUrl;
  DashboardContainer(
      {required this.time,
      required this.courseName,
      required this.imgUrl,
      super.key});

  @override
  State<DashboardContainer> createState() => _DashboardContainerState();
}

class _DashboardContainerState extends State<DashboardContainer> {
  DraggableScrollableController? controller;
  double? offset;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = DraggableScrollableController();
    controller!.addListener(() {
      offset = controller!.pixels;
      //print("Offset value $offset");
      // print("Offset ---> ${controller!.pixels}");
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: CustomColor.primaryColor,
      onTap: () {
        ModalBottomSheet(
                context: context,
                courseName: widget.courseName,
                time: widget.time,
                instructorName: "John Smith",
                controller: controller!,
                offset: offset)
            .bottomsheet();
      },
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(7),
          image: DecorationImage(
              filterQuality: FilterQuality.high,
              colorFilter:
                  const ColorFilter.mode(Colors.black38, BlendMode.multiply),
              opacity: 0.95,
              image: AssetImage(widget.imgUrl),
              fit: BoxFit.cover),
        ),
        height: 130,
        width: SizeConfig.width,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              widget.courseName,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.w700, color: Colors.white),
            ),
            Text(
              widget.time,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w500, color: Colors.white),
            ),
          ]),
        ),
      ),
    );
  }

  bottomsheet() {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      builder: (context, scrollController) {
        return Stack(
          children: [
            Positioned(
              child: Text(
                widget.courseName,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.w700,
                    color: CustomColor.primaryColor),
              ),
            )
          ],
        );
      },
    );
  }
}
