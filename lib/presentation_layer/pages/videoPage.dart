import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../data_layer/Entities/video.dart';

class VideoPlayer extends StatefulWidget {
  final Video video;

  const VideoPlayer({super.key, required this.video});

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: widget.video.id,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
        useHybridComposition: false,
      ),
    );
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressColors: ProgressBarColors(
            playedColor: Color(0xffAF4748),
            handleColor: Color(0xfff9be0c),
          ),
          topActions: <Widget>[
            Expanded(
              child: Container(
                color: Color(0xffAF4748),
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.video.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ),
        builder: (context, player) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xffAF4748),
              ),
              body: Container(
                height: double.maxFinite,
                child: Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Image.asset(
                        'assets/loginpage_bg.png',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Column(
                      children: [
                        player,
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.video.title,
                          style: TextStyle(fontSize: 25,
                          fontWeight: FontWeight.w500,wordSpacing: 2),),
                        ),
                      ],
                    ),
                  ],
                ),
              ));
        });
  }
}
