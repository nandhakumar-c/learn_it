import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:videosdk/videosdk.dart';

import '../../../common/utils/screen_size.dart';
import '../../../common/widgets/colors.dart';
import '../../utils/toast.dart';

class ChatWidget extends StatelessWidget {
  final bool isLocalParticipant;
  final PubSubMessage message;
  const ChatWidget(
      {Key? key, required this.isLocalParticipant, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      //alignment:
      // isLocalParticipant ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: () {
          Clipboard.setData(ClipboardData(text: message.message));
          showSnackBarMessage(
              message: "Message has been copied", context: context);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: isLocalParticipant
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.25)
                    : Color(0xffffffff),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Container(
                  width: SizeConfig.width! * 100,
                  child: Container(
                    // height: SizeConfig.height! * 10,
                    width: SizeConfig.width! * 100,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Align(
                            child: Container(
                              height: SizeConfig.width! * 10,
                              width: SizeConfig.width! * 10,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(48),
                                child: Image(
                                    image: AssetImage(isLocalParticipant
                                        ? "assets/avatars/avatar2.jpeg"
                                        : "assets/avatars/channels4_profile.jpg")),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, bottom: 0),
                                child: Container(
                                    height: 20,
                                    //width: SizeConfig.width! * 75,
                                    child: Row(children: [
                                      Text(
                                        isLocalParticipant
                                            ? "You"
                                            : message.senderName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary),
                                      ),
                                      Spacer(),
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            message.timestamp
                                                .toLocal()
                                                .format('h:i a'),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary),
                                          ))
                                    ])),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  message.message,
                                  softWrap: false,
                                  maxLines: 1000,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondaryContainer),
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
        ),
        /*child: Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: black600,
          ),
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isLocalParticipant ? "You" : message.senderName,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: black400,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message.message,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    message.timestamp.toLocal().format('h:i a'),
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                        color: black400,
                        fontSize: 10,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ), */
      ),
    );
  }
}
