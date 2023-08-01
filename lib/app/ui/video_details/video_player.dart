import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

import '../../../config/constant/color_constant.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({super.key});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.asset('assets/SampleVideo_1280x720_5mb.mp4')
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            setState(() {});
          });
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,

      // additionalOptions: (context) {
      //   return <OptionItem>[
      //     OptionItem(
      //       onTap: () => {},
      //       iconData: Icons.subtitles,
      //       title: 'Toggle Subtitle',
      //     )
      //   ];
      // },
      // autoPlay: true,
      looping: true,
      aspectRatio: 16 / 9,
      // allowMuting: false,
      // allowFullScreen: true,
      // allowPlaybackSpeedChanging: true,
      autoInitialize: true,
      // draggableProgressBar: true,
      // materialProgressColors: ChewieProgressColors(
      //     handleColor: kButtonSecondaryColor, playedColor: kButtonColor),
      // errorBuilder: (context, errorMessage) {
      //   return Center(
      //     child: Text(
      //       errorMessage,
      //       style: TextStyle(color: Colors.white),
      //     ),
      //   );
      // },
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Chewie(
        controller: _chewieController,
      ),
    );
  }
}
