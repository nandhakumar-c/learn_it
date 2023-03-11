import 'package:flutter/material.dart';
import 'package:videosdk/videosdk.dart';

import '../../common/utils/color.dart';
import '../../common/widgets/colors.dart';
import '../stats/call_stats.dart';

class ParticipantGridTile extends StatefulWidget {
  final Participant participant;
  final bool isLocalParticipant;
  final String? activeSpeakerId;
  final String? quality;
  const ParticipantGridTile(
      {Key? key,
      required this.participant,
      required this.quality,
      this.isLocalParticipant = false,
      required this.activeSpeakerId})
      : super(key: key);

  @override
  State<ParticipantGridTile> createState() => _ParticipantGridTileState();
}

class _ParticipantGridTileState extends State<ParticipantGridTile> {
  Stream? videoStream;
  Stream? audioStream;

  @override
  void initState() {
    _initStreamListeners();
    super.initState();

    widget.participant.streams.forEach((key, Stream stream) {
      setState(() {
        if (stream.kind == 'video') {
          videoStream = stream;
          widget.participant.setQuality(widget.quality);
        } else if (stream.kind == 'audio') {
          audioStream = stream;
        }
      });
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
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
          borderRadius: BorderRadius.circular(12),
          color: black800,
          border: widget.activeSpeakerId != null &&
                  widget.activeSpeakerId == widget.participant.id
              ? Border.all(color: Colors.blueAccent)
              : null,
        ),
        child: Stack(
          children: [
            videoStream != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: RTCVideoView(
                      videoStream?.renderer as RTCVideoRenderer,
                      mirror: widget.participant.isLocal ? true : false,
                      objectFit:
                          RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                    ),
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: black500,
                        ),
                        //Participant Grid
                        child: Text(
                          widget.participant.displayName.characters.first
                              .toUpperCase(),
                          style: const TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                  ),
            if (audioStream == null)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.mic_off,
                      size: 15,
                    )),
              ),
            Positioned(
              bottom: 8,
              left: 8,
              child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(widget.participant.isLocal
                      ? "You"
                      : widget.participant.displayName)),
            ),
            Positioned(
                top: 4,
                left: 4,
                child: CallStats(participant: widget.participant)),
          ],
        ),
      ),
    );
  }

  _initStreamListeners() {
    widget.participant.on(Events.streamEnabled, (Stream stream) {
      setState(() {
        if (stream.kind == 'video') {
          videoStream = stream;
          widget.participant.setQuality(widget.quality);
        } else if (stream.kind == 'audio') {
          audioStream = stream;
        }
      });
    });

    widget.participant.on(Events.streamDisabled, (Stream stream) {
      setState(() {
        if (stream.kind == 'video' && videoStream?.id == stream.id) {
          videoStream = null;
        } else if (stream.kind == 'audio' && audioStream?.id == stream.id) {
          audioStream = null;
        }
      });
    });

    widget.participant.on(Events.streamPaused, (Stream stream) {
      setState(() {
        if (stream.kind == 'video' && videoStream?.id == stream.id) {
          videoStream = null;
        } else if (stream.kind == 'audio' && audioStream?.id == stream.id) {
          audioStream = stream;
        }
      });
    });

    widget.participant.on(Events.streamResumed, (Stream stream) {
      setState(() {
        if (stream.kind == 'video' && videoStream?.id == stream.id) {
          videoStream = stream;
          widget.participant.setQuality(widget.quality);
        } else if (stream.kind == 'audio' && audioStream?.id == stream.id) {
          audioStream = stream;
        }
      });
    });
  }
}
