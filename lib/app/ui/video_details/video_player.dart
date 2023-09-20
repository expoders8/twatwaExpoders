import 'dart:convert';
import 'dart:developer';

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

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;
  final String videoid;
  final String videoQualityDatas;
  const VideoPlayerScreen(
      {super.key,
      required this.videoUrl,
      required this.videoQualityDatas,
      required this.videoid});

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
      showOverlay = true,
      _isPlaying = false,
      localValue = true,
      videoquality = true,
      _isFullScreen = false;
  List<bool> buttonStates = List.generate(10, (index) => false);
  String tsecond = "";
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

  videoPlayerController(String url) {
    Future.delayed(const Duration(milliseconds: 180), () async {
      showOverlay = false;
      _isPlaying = true;
    });
    _controller = VideoPlayerController.networkUrl(Uri.parse(url))
      ..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      });
    _controller.addListener(() {
      if (_controller.value.isPlaying) {
        setState(() {
          _sliderValue = _controller.value.position.inMilliseconds.toDouble();
        });
      }
      if (_controller.value.position == _controller.value.duration) {
        if (videoquality) {
          if (tsecond != "00") {
            _playNextVideo();
          }
        }
      }
    });
    _controller.play();
  }

  _playNextVideo() {
    videotonext();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackGroundColor,
      width: Get.width,
      height: _isFullScreen
          ? Get.height
          : _controller.value.aspectRatio <= 0.80
              ? 480
              : 250,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          _controller.value.isInitialized
              ? _controller.value.aspectRatio <= 0.80
                  ? _isFullScreen
                      ? VideoPlayer(
                          _controller,
                        )
                      : AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(
                            _controller,
                          ))
                  : Padding(
                      padding: EdgeInsets.only(top: _isFullScreen ? 0 : 28.0),
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
                )),
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
                      : 4),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: _isFullScreen
                        ? _controller.value.aspectRatio <= 0.80
                            ? 10
                            : 50
                        : 10,
                    vertical: _isFullScreen ? 10 : 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        _exitFullScreen();
                      },
                      child: SizedBox(
                        height: 16,
                        width: 26,
                        child: Image.asset(
                          "assets/icons/back_white.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
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
                      child: Container(
                        padding: const EdgeInsets.all(13),
                        height: 50,
                        width: 50,
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
                          : 60
                      : _controller.value.aspectRatio <= 0.80
                          ? 110
                          : 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
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
                    },
                    icon: SizedBox(
                      height: 25,
                      width: 25,
                      child: Image.asset(
                        "assets/icons/previousNext.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: _isFullScreen ? 60 : 33),
                  IconButton(
                    onPressed: () {
                      if (showOverlay) {
                        setState(() {
                          _isPlaying ? _controller.pause() : _controller.play();
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
                          ? 170
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void _enterFullScreen() {
    setState(() {
      _controller.play();
      _isFullScreen = false;
      _isPlaying = true;
    });
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    setState(() {
      _controller.play();
      _isFullScreen = false;
      _isPlaying = true;
    });
  }

  void _exitFullScreen() {
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
                          const EdgeInsets.only(top: 25, left: 20, bottom: 15),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: kTextSecondaryColor, width: 0.4))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Image.asset(
                                "assets/icons/back.png",
                                scale: 9,
                                color: kWhiteColor,
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
