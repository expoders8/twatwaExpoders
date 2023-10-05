import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:opentrend/app/ui/video_details/video_details.dart';
import 'package:video_player/video_player.dart';

import '../../../config/constant/color_constant.dart';
import '../../../config/constant/constant.dart';
import '../../../config/constant/font_constant.dart';
import '../../controller/video_controller.dart';
import '../../controller/video_detail_controller.dart';

typedef StringCallback = void Function(String val);

class VideoPlayerScreen extends StatefulWidget {
  final ValueNotifier<int> valueNotifier;
  final int videoSize;
  final String videoUrl;
  final String videoid;
  final String videoQualityDatas;
  final StringCallback callbackSize;
  final StringCallback callbackPlay;
  final StringCallback callbackfullscreen;
  const VideoPlayerScreen({
    super.key,
    required this.videoUrl,
    required this.videoQualityDatas,
    required this.videoid,
    required this.callbackSize,
    required this.callbackPlay,
    required this.videoSize,
    required this.valueNotifier,
    required this.callbackfullscreen,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  final UpNextVideoController videoController =
      Get.put(UpNextVideoController());
  final VideoDetailController videoDetailController =
      Get.put(VideoDetailController());
  double _sliderValue = 0.0;
  late VideoPlayerController _controller;
  bool isChecked = false,
      showOverlay = false,
      fullHeight = false,
      _isPlaying = false,
      upnextVidepPlay = false,
      onetimecall = true,
      rePlayVideo = false,
      localValue = true,
      videoquality = true,
      _isFullScreen = false;
  double aspectRatio = 0.0;
  int currentIndex = 0;
  List<bool> buttonStates = List.generate(10, (index) => false);
  String tsecond = "",
      videoThumbhnilImage = "",
      videotitle = "",
      videoDescription = "";
  @override
  void initState() {
    super.initState();
    var getURL = Get.parameters['value'];
    if (getURL == "false") {
      _exitFullScreen();
    }
    Future.delayed(const Duration(milliseconds: 180), () async {
      showOverlay = false;
      _isPlaying = true;
    });
    videoPlayerController(widget.videoUrl.toString());
  }

  videoPlayerController(String url) async {
    Future.delayed(const Duration(milliseconds: 180), () async {
      showOverlay = false;
      _isPlaying = true;
    });
    _controller = VideoPlayerController.networkUrl(Uri.parse(url))
      ..initialize().then((_) {
        setState(() {
          _controller.play();
          aspectRatio = _controller.value.aspectRatio;
          widget.callbackSize(aspectRatio.toString());
        });
      });

    // WidgetsBinding.instance.addPostFrameCallback((_) {});
    _controller.addListener(() {
      if (_controller.value.isPlaying) {
        setState(() {
          _sliderValue = _controller.value.position.inMilliseconds.toDouble();
        });
      }
      if (_controller.value.position == _controller.value.duration) {
        if (videoquality) {
          if (tsecond != "00") {
            if (onetimecall) {
              setState(() {
                videoAutotonext();
                upnextVidepPlay = true;
              });
            }
          }
        }
      }
      setState(() {
        currentIndex = widget.videoSize;
      });
    });
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.valueNotifier.addListener(_valueListener);
  }

  void _valueListener() {
    if (mounted) {
      setState(() {
        currentIndex = widget.valueNotifier.value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return upnextVidepPlay
        ? Container(
            padding: const EdgeInsets.all(10),
            width: Get.width,
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Suggested video",
                      style: TextStyle(
                          color: kTextsecondarytopColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            upnextVidepPlay = false;
                            rePlayVideo = true;
                            onetimecall = false;
                            _controller.pause();
                          });
                          widget.callbackPlay(upnextVidepPlay.toString());
                        },
                        icon: const Icon(
                          Icons.cancel_outlined,
                          color: kTextsecondarytopColor,
                        ))
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        videoThumbhnilImage,
                        height: 100,
                        width: 150,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                          "assets/Opentrend_light_applogo.jpeg",
                          fit: BoxFit.fill,
                        ),
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return SizedBox(
                            width: 17,
                            height: 17,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: kWhiteColor,
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 10),
                      child: Column(
                        children: [
                          Text(
                            videotitle,
                            style: const TextStyle(
                                color: kTextsecondarytopColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            videoDescription,
                            style: const TextStyle(
                                color: kTextsecondarytopColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    CupertinoButton(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 55, vertical: 10),
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(30),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                              color: kTextsecondarytopColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        onPressed: () {
                          setState(() {
                            upnextVidepPlay = false;
                            rePlayVideo = true;
                            onetimecall = false;
                            _controller.pause();
                          });
                          widget.callbackPlay(upnextVidepPlay.toString());
                        }),
                    const SizedBox(width: 10),
                    CupertinoButton(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 45, vertical: 12),
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(30),
                        onPressed: videotonext,
                        child: const Text(
                          "Play now",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ))
                  ],
                ),
              ],
            ),
          )
        : Container(
            color: kBackGroundColor,
            width: Get.width,
            height: _isFullScreen
                ? Get.height
                : _controller.value.aspectRatio <= 0.80
                    ? Get.height / 1.5
                    : Platform.isIOS
                        ? 290
                        : 250,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                _controller.value.isInitialized
                    ? _controller.value.aspectRatio <= 0.80
                        ? _isFullScreen
                            ? VideoPlayer(
                                _controller,
                              )
                            : SizedBox(
                                width: currentIndex == 0
                                    ? Get.width - 23
                                    : currentIndex == 1
                                        ? Get.width - 30
                                        : currentIndex == 2
                                            ? Get.width - 60
                                            : currentIndex == 3
                                                ? Get.width - 80
                                                : currentIndex == 4
                                                    ? Get.width - 110
                                                    : currentIndex == 5
                                                        ? Get.width - 160
                                                        : currentIndex == 6
                                                            ? Get.width - 170
                                                            : currentIndex == 7
                                                                ? Get.width -
                                                                    190
                                                                : Get.width -
                                                                    23,
                                height: currentIndex == 0
                                    ? Get.height
                                    : currentIndex == 1
                                        ? Get.height - 100
                                        : currentIndex == 2
                                            ? Get.height - 100
                                            : currentIndex == 3
                                                ? Get.height - 200
                                                : currentIndex == 4
                                                    ? Get.height - 250
                                                    : currentIndex == 5
                                                        ? Get.height - 340
                                                        : currentIndex == 6
                                                            ? Get.height - 380
                                                            : currentIndex == 7
                                                                ? Get.height -
                                                                    400
                                                                : Get.height,
                                child: AspectRatio(
                                  aspectRatio: _controller.value.aspectRatio,
                                  child: VideoPlayer(
                                    _controller,
                                  ),
                                ),
                              )
                        : Padding(
                            padding: EdgeInsets.only(
                                top: _isFullScreen
                                    ? 0
                                    : Platform.isIOS
                                        ? 40
                                        : 28.0),
                            child: VideoPlayer(
                              _controller,
                            ),
                          )
                    // _isFullScreen
                    //     ? VideoPlayer(
                    //         _controller,
                    //       )
                    //     : AspectRatio(
                    //         aspectRatio: _controller.value.aspectRatio,
                    //         child: VideoPlayer(
                    //           _controller,
                    //         ))
                    : const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: CircularProgressIndicator(
                            color: Colors.white60,
                            backgroundColor: kButtonSecondaryColor,
                            strokeWidth: 2,
                          ),
                        ),
                      ),
                _buildControls()
              ],
            ),
          );
  }

  Widget _buildControls() {
    return GestureDetector(
      onTap: () {
        setState(() {
          showOverlay = !showOverlay;
        });
      },
      child: AnimatedOpacity(
        opacity: showOverlay ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
          color: const Color(0xFF121330).withOpacity(0.5),
          child: Column(
            children: [
              SizedBox(
                  height: _isFullScreen
                      ? _controller.value.aspectRatio <= 0.80
                          ? 20
                          : 0
                      : currentIndex == 0
                          ? 4
                          : currentIndex == 1
                              ? 20
                              : currentIndex == 2
                                  ? 30
                                  : currentIndex == 3
                                      ? 40
                                      : currentIndex == 4
                                          ? 50
                                          : currentIndex == 5
                                              ? 70
                                              : currentIndex == 6
                                                  ? 75
                                                  : currentIndex == 7
                                                      ? 80
                                                      : 4),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: _isFullScreen
                        ? _controller.value.aspectRatio <= 0.80
                            ? 10
                            : 50
                        : 10,
                    vertical: _isFullScreen
                        ? Platform.isIOS
                            ? 40
                            : 10
                        : Platform.isIOS
                            ? 40
                            : 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (showOverlay) {
                          Get.back();
                          _exitFullScreen();
                          Future.delayed(const Duration(milliseconds: 2000),
                              () async {
                            showOverlay = !showOverlay;
                          });
                        } else {
                          setState(() {
                            showOverlay = !showOverlay;
                          });
                        }
                      },
                      icon: SizedBox(
                        height: 16,
                        width: 26,
                        child: Image.asset(
                          "assets/icons/back_white.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (showOverlay) {
                          videoQualitySelectBottomsheet();
                          Future.delayed(const Duration(milliseconds: 2000),
                              () async {
                            showOverlay = !showOverlay;
                          });
                        } else {
                          setState(() {
                            showOverlay = !showOverlay;
                          });
                        }
                      },
                      icon: SizedBox(
                        height: 23,
                        width: 23,
                        child: Image.asset(
                          "assets/icons/setting.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  height: _isFullScreen
                      ? _controller.value.aspectRatio <= 0.80
                          ? 260
                          : Platform.isIOS
                              ? 40
                              : 60
                      : _controller.value.aspectRatio <= 0.80
                          ? currentIndex == 0
                              ? 170
                              : currentIndex == 1
                                  ? 150
                                  : currentIndex == 2
                                      ? 120
                                      : currentIndex == 3
                                          ? 90
                                          : currentIndex == 4
                                              ? 70
                                              : currentIndex == 5
                                                  ? 45
                                                  : currentIndex == 6
                                                      ? 10
                                                      : currentIndex == 7
                                                          ? 10
                                                          : 170
                          : 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      if (!rePlayVideo) {
                        if (showOverlay) {
                          videotoprevious();
                          Future.delayed(const Duration(milliseconds: 2000),
                              () async {
                            showOverlay = !showOverlay;
                          });
                        } else {
                          setState(() {
                            showOverlay = !showOverlay;
                          });
                        }
                      }
                    },
                    icon: SizedBox(
                      height: 25,
                      width: 25,
                      child: Image.asset(
                        "assets/icons/previousNext.png",
                        fit: BoxFit.cover,
                        color:
                            rePlayVideo ? kButtonSecondaryColor : kWhiteColor,
                      ),
                    ),
                  ),
                  SizedBox(width: _isFullScreen ? 60 : 33),
                  rePlayVideo
                      ? IconButton(
                          onPressed: () {
                            if (showOverlay) {
                              setState(() {
                                setState(() {
                                  rePlayVideo = false;
                                });
                                videoPlayerController(
                                    widget.videoUrl.toString());
                              });
                              Future.delayed(const Duration(milliseconds: 2000),
                                  () async {
                                showOverlay = !showOverlay;
                              });
                            } else {
                              setState(() {
                                showOverlay = !showOverlay;
                              });
                            }
                          },
                          icon: const SizedBox(
                            width: 40,
                            height: 40,
                            child: Icon(
                              Icons.replay,
                              color: kWhiteColor,
                              size: 32,
                            ),
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            if (showOverlay) {
                              setState(() {
                                _isPlaying
                                    ? _controller.pause()
                                    : _controller.play();
                                _isPlaying = !_isPlaying;
                              });
                              Future.delayed(const Duration(milliseconds: 2000),
                                  () async {
                                showOverlay = !showOverlay;
                              });
                            } else {
                              setState(() {
                                showOverlay = !showOverlay;
                              });
                            }
                          },
                          icon: SizedBox(
                            width: 40,
                            height: 40,
                            child: Image.asset(
                              _isPlaying
                                  ? "assets/icons/vdeoPause.png"
                                  : "assets/icons/Play.png",
                              scale: 3,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                  SizedBox(width: _isFullScreen ? 60 : 30),
                  IconButton(
                    onPressed: () {
                      if (showOverlay) {
                        videotonext();
                        Future.delayed(const Duration(milliseconds: 2000),
                            () async {
                          showOverlay = !showOverlay;
                        });
                      } else {
                        setState(() {
                          showOverlay = !showOverlay;
                        });
                      }
                    },
                    icon: SizedBox(
                      height: 25,
                      width: 25,
                      child: Image.asset(
                        "assets/icons/nextVideo.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                  height: _isFullScreen
                      ? _controller.value.aspectRatio <= 0.80
                          ? 280
                          : 100
                      : _controller.value.aspectRatio <= 0.80
                          ? currentIndex == 0
                              ? 190
                              : currentIndex == 1
                                  ? 160
                                  : currentIndex == 2
                                      ? 140
                                      : currentIndex == 3
                                          ? 120
                                          : currentIndex == 4
                                              ? 100
                                              : currentIndex == 5
                                                  ? 75
                                                  : currentIndex == 6
                                                      ? 70
                                                      : currentIndex == 7
                                                          ? 50
                                                          : 190
                          : Platform.isIOS
                              ? 50
                              : 40),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: _isFullScreen ? 30 : 10),
                color: Colors.black.withOpacity(0.7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatDuration(_controller.value.position),
                      style: const TextStyle(color: Colors.white),
                    ),
                    Expanded(
                      child: Slider(
                        activeColor: kButtonColor,
                        inactiveColor: kButtonSecondaryColor,
                        value: _sliderValue,
                        min: 0.0,
                        max: _controller.value.duration.inMilliseconds
                            .toDouble(),
                        onChanged: _onSliderChange,
                      ),
                    ),
                    Text(
                      _formatDuration(_controller.value.duration),
                      style: const TextStyle(color: Colors.white),
                    ),
                    SizedBox(width: _isFullScreen ? 25 : 5),
                    IconButton(
                      onPressed: () {
                        if (showOverlay) {
                          _toggleFullScreen();
                          Future.delayed(const Duration(milliseconds: 500),
                              () async {
                            setState(() {
                              showOverlay = !showOverlay;
                            });
                          });
                        } else {
                          setState(() {
                            showOverlay = !showOverlay;
                          });
                        }
                      },
                      icon: SizedBox(
                        height: 20,
                        width: 20,
                        child: Image.asset(
                          _isFullScreen
                              ? "assets/icons/fullscreen.png"
                              : "assets/icons/smallscreen.png",
                          color: kWhiteColor,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    // if (_controller.value.position == _controller.value.duration) {
    //   videotonext();
    // }
    setState(() {
      tsecond = seconds;
    });
    return "$minutes:$seconds";
  }

  void _onSliderChange(double value) {
    if (showOverlay) {
      setState(() {
        _sliderValue = value;
        _controller.seekTo(Duration(milliseconds: value.toInt()));
        _isPlaying = true;
        _controller.play();
      });
      Future.delayed(const Duration(milliseconds: 5000), () async {
        setState(() {
          showOverlay = !showOverlay;
        });
      });
    } else {
      setState(() {
        showOverlay = !showOverlay;
      });
    }
  }

  videoAutotonext() {
    widget.callbackPlay(upnextVidepPlay.toString());
    videoController.fetcheAutoSkipVideo(widget.videoid).then((value) => {
          if (value[0] != "")
            {
              setState(() {
                videoThumbhnilImage = value[0];
                videotitle = value[1];
                videoDescription = value[2];
              })
            }
        });
  }

  videotonext() {
    videoController.fetcheSkipVideo(widget.videoid).then((value) => {
          if (value == "done")
            {
              videoDetailController.videoId(),
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const VideoDetailsPage(),
                ),
              ),
            }
        });
  }

  videotoprevious() {
    videoController.fetchePreviousVideo(widget.videoid).then((value) => {
          if (value == "done")
            {
              videoDetailController.videoId(),
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const VideoDetailsPage(),
                ),
              ),
            }
        });
  }

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen
          ? _exitFullScreen()
          : _controller.value.aspectRatio <= 0.80
              ? _enterpotraitFullScreen()
              : _enterFullScreen();
      _isFullScreen = !_isFullScreen;
    });
  }

  void _enterpotraitFullScreen() {
    widget.callbackfullscreen("true");
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void _enterFullScreen() {
    setState(() {
      _isFullScreen = false;
    });
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    setState(() {
      _isFullScreen = false;
    });
  }

  void _exitFullScreen() {
    widget.callbackfullscreen("false");
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  videoQualitySelectBottomsheet() {
    var videoQualityData = jsonDecode(widget.videoQualityDatas.toString());
    buttonStates =
        List.generate(videoQualityData['source'].length, (index) => false);
    if (buttonStates.isNotEmpty) {
      buttonStates[buttonStates.length - 1] = true;
    }

    if (localValue) {
      box.write('videobuttonStates', buttonStates);
    }
    var activeButton = box.read('videobuttonStates');
    FocusScope.of(context).requestFocus(FocusNode());
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: kAppBottomSheetColor,
        context: context,
        builder: (context) {
          return StatefulBuilder(// this is new
              builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: SizedBox(
                height: Get.height - 50,
                width: _isFullScreen ? Get.width - 380 : Get.width,
                child: Column(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(top: 10, left: 20, bottom: 15),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: kTextSecondaryColor, width: 0.4))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: SizedBox(
                              height: 16,
                              width: 26,
                              child: Image.asset(
                                "assets/icons/back_white.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Center(
                            child: GestureDetector(
                              child: const Text(
                                "Video Quality",
                                style: TextStyle(
                                  color: kWhiteColor,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            "        ",
                            style: TextStyle(
                              color: kWhiteColor,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    videoQualityData == null
                        ? const Padding(
                            padding: EdgeInsets.only(top: 290.0),
                            child: Center(
                              child: Text(
                                "No Video Quality found",
                                style: TextStyle(
                                    color: kWhiteColor,
                                    fontSize: 15,
                                    fontFamily: kFuturaPTDemi),
                              ),
                            ),
                          )
                        : SizedBox(
                            height: Get.height - 125,
                            child: ListView.builder(
                              itemCount: videoQualityData['source'].length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var discoverData = videoQualityData['source'];

                                if (discoverData!.isEmpty) {
                                  return const Center(
                                    child: Text(
                                      "No Video found",
                                      style: TextStyle(
                                          color: kWhiteColor,
                                          fontSize: 15,
                                          fontFamily: kFuturaPTDemi),
                                    ),
                                  );
                                } else {
                                  var data = discoverData[index];
                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (buttonStates.isNotEmpty) {
                                              buttonStates[buttonStates.length -
                                                  1] = false;
                                            }
                                            buttonStates[index] =
                                                !buttonStates[index];
                                            localValue = false;
                                            box.write('videobuttonStates',
                                                buttonStates);
                                            videoquality = false;
                                            videoPlayerController(
                                                data['Data']['Url']);
                                          });
                                          Get.back();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0, vertical: 5),
                                          child: Container(
                                            width: _isFullScreen
                                                ? Get.width - 300
                                                : Get.width,
                                            height: 70,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Card(
                                                color: kCardColor,
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color:
                                                            activeButton[index]
                                                                ? kButtonColor
                                                                : kCardColor,
                                                        width: 2.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.0)),
                                                child: Center(
                                                    child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      data['Quality'], // 1080
                                                      style: const TextStyle(
                                                        color: kWhiteColor,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      data['Quality'] == "2160p"
                                                          ? "FHD"
                                                          : data['Quality'] ==
                                                                  "1080p"
                                                              ? "HD"
                                                              : "",
                                                      style: const TextStyle(
                                                        color: kButtonColor,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ))),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                          ),
                  ],
                ),
              ),
            );
          });
        });
  }
}
