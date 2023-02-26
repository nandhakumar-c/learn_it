import 'package:flutter/material.dart';
import 'package:learn_it/dashboard_page/widgets/modalbottomsheet.dart';

import '../../common/utils/color.dart';
import '../../common/utils/screen_size.dart';

class DashboardContainer extends StatelessWidget {
  String time;
  String courseName;
  String imgUrl;
  DashboardContainer(
      {required this.time,
      required this.courseName,
      required this.imgUrl,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: CustomColor.primaryColor,
      onTap: () {
        // ModalBottomSheet(
        //     context: context,
        //     courseName: courseName,
        //     time: time,
        //     instructorName: "John Smith");
      },
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(7),
          image: DecorationImage(
              filterQuality: FilterQuality.high,
              colorFilter: ColorFilter.mode(Colors.black38, BlendMode.multiply),
              opacity: 0.95,
              image: AssetImage(imgUrl),
              fit: BoxFit.cover),
        ),
        height: 130,
        width: SizeConfig.width,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              courseName,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.w700, color: Colors.white),
            ),
            Text(
              time,
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
}