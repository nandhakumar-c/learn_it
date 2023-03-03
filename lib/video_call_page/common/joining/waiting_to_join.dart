import 'package:flutter/material.dart';
import 'package:learn_it/common/utils/screen_size.dart';
import 'package:lottie/lottie.dart';

import '../../utils/spacer.dart';

class WaitingToJoin extends StatelessWidget {
  const WaitingToJoin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: Center(
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/lottie/join_meeting.json",
                height: SizeConfig.height! * 40, width: SizeConfig.width! * 70),
            SizedBox(
              width: SizeConfig.width! * 75,
              child: Center(
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          text:
                              "\"The capacity to learn is a gift; the ability to learn is a skill; the willingness to learn is a choice.\"",
                          style: Theme.of(context).textTheme.bodyMedium),
                      TextSpan(
                          text: "- Brian Herbert",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.w600)),
                    ])),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
