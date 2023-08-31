import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../config/constant/color_constant.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerScreen({super.key, required this.videoUrl});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  double _sliderValue = 0.0;
  late VideoPlayerController _controller;
  bool isChecked = false,
      showOverlay = true,
      _isPlaying = false,
      click = false,
      _isFullScreen = false,
      _isLoaded = false;
  int selectvideoQualityIndex = 6;
  String qualityname = "";
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
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});
      });

    _controller.addListener(() {
      if (_controller.value.isPlaying) {
        setState(() {
          _sliderValue = _controller.value.position.inMilliseconds.toDouble();
        });
      }
    });
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: _isFullScreen ? Get.height : 240,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          _controller.value.isInitialized
              ? VideoPlayer(_controller)
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
          color: Colors.black.withOpacity(0.7),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: _isFullScreen ? 50 : 10,
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
                        videoQualitySelectBottomsheet();
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
              SizedBox(height: _isFullScreen ? 60 : 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 25,
                    width: 25,
                    child: Image.asset(
                      "assets/icons/previousNext.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: _isFullScreen ? 60 : 33),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isPlaying ? _controller.pause() : _controller.play();
                        _isPlaying = !_isPlaying;
                      });
                      Future.delayed(const Duration(milliseconds: 2000),
                          () async {
                        showOverlay = !showOverlay;
                      });
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
                  SizedBox(
                    height: 25,
                    width: 25,
                    child: Image.asset(
                      "assets/icons/nextVideo.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              SizedBox(height: _isFullScreen ? 100 : 40),
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
                        _toggleFullScreen();
                        Future.delayed(const Duration(milliseconds: 500),
                            () async {
                          setState(() {
                            showOverlay = !showOverlay;
                          });
                        });
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
    return "$minutes:$seconds";
  }

  void _onSliderChange(double value) {
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
  }

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen ? _exitFullScreen() : _enterFullScreen();
      _isFullScreen = !_isFullScreen;
    });
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
                    SizedBox(
                      height: Get.height - 125,
                      child: ListView.builder(
                        itemCount: 1,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectvideoQualityIndex = 0;
                                    qualityname = "1080p";
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
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Card(
                                        color: kCardColor,
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color:
                                                    selectvideoQualityIndex == 0
                                                        ? kButtonColor
                                                        : kCardColor,
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(4.0)),
                                        child: Center(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              "1080p",
                                              style: TextStyle(
                                                color: kWhiteColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "FHD",
                                              style: TextStyle(
                                                color: kButtonColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ))),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectvideoQualityIndex = 1;
                                    qualityname = "720p";
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
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Card(
                                        color: kCardColor,
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color:
                                                    selectvideoQualityIndex == 1
                                                        ? kButtonColor
                                                        : kCardColor,
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(4.0)),
                                        child: Center(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              "720p",
                                              style: TextStyle(
                                                color: kWhiteColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "HD",
                                              style: TextStyle(
                                                color: kButtonColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ))),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectvideoQualityIndex = 2;
                                    qualityname = "480p";
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
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Card(
                                        color: kCardColor,
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color:
                                                    selectvideoQualityIndex == 2
                                                        ? kButtonColor
                                                        : kCardColor,
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(4.0)),
                                        child: Center(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              "480p",
                                              style: TextStyle(
                                                color: kWhiteColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "",
                                              style: TextStyle(
                                                color: kButtonColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ))),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectvideoQualityIndex = 3;
                                    qualityname = "360p";
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
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Card(
                                        color: kCardColor,
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color:
                                                    selectvideoQualityIndex == 3
                                                        ? kButtonColor
                                                        : kCardColor,
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(4.0)),
                                        child: Center(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              "360p",
                                              style: TextStyle(
                                                color: kWhiteColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "",
                                              style: TextStyle(
                                                color: kButtonColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ))),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectvideoQualityIndex = 4;
                                    qualityname = "240p";
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
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Card(
                                        color: kCardColor,
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color:
                                                    selectvideoQualityIndex == 4
                                                        ? kButtonColor
                                                        : kCardColor,
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(4.0)),
                                        child: Center(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              "240p",
                                              style: TextStyle(
                                                color: kWhiteColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "",
                                              style: TextStyle(
                                                color: kButtonColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ))),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectvideoQualityIndex = 5;
                                    qualityname = "144p";
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
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Card(
                                        color: kCardColor,
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color:
                                                    selectvideoQualityIndex == 5
                                                        ? kButtonColor
                                                        : kCardColor,
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(4.0)),
                                        child: Center(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              "144p",
                                              style: TextStyle(
                                                color: kWhiteColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "",
                                              style: TextStyle(
                                                color: kButtonColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ))),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectvideoQualityIndex = 6;
                                    qualityname = "Auto";
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
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Card(
                                      color: kCardColor,
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color:
                                                  selectvideoQualityIndex == 6
                                                      ? kButtonColor
                                                      : kCardColor,
                                              width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(4.0)),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              "Auto",
                                              style: TextStyle(
                                                color: kWhiteColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "",
                                              style: TextStyle(
                                                color: kButtonColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
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
