import 'package:flutter/material.dart';

import '../../common/utils/screen_size.dart';

class OwnMessageWidget extends StatelessWidget {
  String sender;
  String message;
  OwnMessageWidget({required this.sender, required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xffC1E5F5), borderRadius: BorderRadius.circular(10)),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SizedBox(
              width: SizeConfig.width! * 100,
              child: SizedBox(
                // height: SizeConfig.height! * 10,
                width: SizeConfig.width! * 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Align(
                        child: SizedBox(
                          height: SizeConfig.width! * 10,
                          width: SizeConfig.width! * 10,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(48),
                            child: const Image(
                                image:
                                    AssetImage("assets/avatars/avatar2.jpeg")),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, bottom: 0),
                            child: SizedBox(
                                height: 20,
                                //width: SizeConfig.width! * 75,
                                child: Row(children: [
                                  Text(
                                    "You",
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  const Spacer(),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "Now",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ))
                                ])),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              message.toString(),
                              softWrap: false,
                              maxLines: 1000,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}


/* */