import 'package:flutter/material.dart';
import 'package:learn_it/common/utils/color.dart';

import '../../common/utils/screen_size.dart';
import '../widgets/audio_button.dart';
import '../widgets/audio_info.dart';
import '../widgets/client_audio_info.dart';
import '../widgets/chat_button.dart';
import '../widgets/end_call_button.dart';
import '../widgets/more_options_button.dart';
import '../widgets/video_button.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff262626),
      //const Color(0xff101014),
      appBar: AppBar(
        // flexibleSpace: Container(
        //     decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //       begin: Alignment.topCenter,
        //       end: Alignment.bottomCenter,
        //       colors: <Color>[Colors.black, Color(0xff262626)]),
        // )),
        backgroundColor: Colors.black87,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            //color: Color(0xfff5f5fa),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        iconTheme: Theme.of(context).iconTheme.copyWith(
              color: const Color(0xfff5f5fa),
            ),
        title: Text(
          "htf-jwe-hrff",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: const Color(0xfff5f5fa)),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            child: Container(
              height: 80,
              width: SizeConfig.width! * 100,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.transparent, Colors.black])),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 80,
              width: SizeConfig.width! * 100,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black, Colors.transparent])),
            ),
          ),

          //Main Video
          Positioned(
            top: 0,
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Container(
                  width: SizeConfig.width! * 90,
                  height: SizeConfig.height! * 78,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(183, 51, 51, 51),
                    boxShadow: [
                      BoxShadow(
                        color: CustomColor.secondaryColor,
                      ),
                      const BoxShadow(
                        //color: Colors.white70,
                        spreadRadius: -3,
                        blurRadius: 10.0,
                      ),
                      BoxShadow(
                          color: CustomColor.secondaryColor,
                          blurRadius: 4,
                          blurStyle: BlurStyle.outer),
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(children: [
                    const Positioned(
                        top: 10,
                        right: 10,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: ClientAudioInfoButton(),
                          ),
                        )),
                    Positioned(
                        child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: SizeConfig.width! * 20,
                        width: SizeConfig.width! * 20,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(48),
                          child: const Image(
                              image: AssetImage(
                                  "assets/avatars/channels4_profile.jpg")),
                        ),
                      ),
                    ))
                  ]),
                ),
              ),
            ),
          ),

          //Local Video
          Positioned(
            bottom: SizeConfig.height! * 15,
            right: SizeConfig.width! * 10,
            child: Container(
              decoration: BoxDecoration(
                  color: const Color(0xff4d4d4d),
                  borderRadius: BorderRadius.circular(
                    SizeConfig.width! * 2,
                  ),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)]),
              height: SizeConfig.height! * 20,
              width: SizeConfig.width! * 20,
              child: Stack(children: [
                const Positioned(
                  top: 7,
                  right: 7,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      height: 25,
                      width: 25,
                      child: AudioInfoButton(),
                    ),
                  ),
                ),
                Positioned(
                    child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: SizeConfig.width! * 10,
                    width: SizeConfig.width! * 10,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(48),
                      child: const Image(
                          image: AssetImage("assets/avatars/avatar2.jpeg")),
                    ),
                  ),
                ))
              ]),
            ),
          ),
          Positioned(
              bottom: 16,
              child: Container(
                width: SizeConfig.width! * 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    AudioButton(),
                    VideoButton(),
                    EndCallButton(),
                    ChatButton(),
                    MoreOptionsButton()
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
