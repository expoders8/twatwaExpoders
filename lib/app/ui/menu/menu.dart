import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

import '../../../config/constant/constant.dart';
import '../home/tab_page.dart';
import '../../../config/constant/color_constant.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  double scrollPosition = 400.0;
  int selectIndex = 3;
  int selectPage = 2;
  ScrollController scrollController = ScrollController();

  // @override
  // void initState() {
  //   var indexx = box.read("menuIndex");
  //   setState(() {
  //     selectPage = int.parse(indexx.toString()) ?? 2;
  //   });
  //   super.initState();
  // }
  // final List<String> titles = [
  //   "Discover",
  //   "Premium Show",
  //   "Education Videos",
  //   "Talent Videos",
  //   "Jobs Videos",
  // ];
  // final List<String> imageIcon = [
  //   "assets/icons/searchDescover.png",
  //   "assets/icons/premiumShows.png",
  //   "assets/icons/education.png",
  //   "assets/icons/jobs.png",
  //   "assets/icons/talent.png",
  // ];

  // final List<String> imageList = [
  //   "assets/icons/menu1.png",
  //   "assets/icons/menu2.png",
  //   "assets/icons/menu3.png",
  //   "assets/icons/menu4.png",
  //   "assets/icons/menu5.png",
  // ];
  // final List colorList = [
  //   const Color(0xFFCD5B5B),
  //   const Color(0xFFDC4AC6),
  //   const Color(0xFFD86C08),
  //   const Color(0xFF46AFE3),
  //   const Color(0xFF5E33E0)
  // ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> images = [
      Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        const Color(0xFFCD5B5B).withOpacity(0.5),
                        BlendMode.srcOver),
                    image: const AssetImage("assets/images/menu11.png"),
                    fit: BoxFit.cover),
              ),
              child: Image.asset(
                "assets/icons/searchDescover.png", // Use the corresponding icon path
                scale: 15, // Adjust the scale as needed
              ),
            ),
          ),
          const Positioned(
            top: 0, // Adjust the top position if needed
            left: 0, // Adjust the left position if needed
            right: 0, // Adjust the right position if needed
            bottom: -90, // Adjust the bottom position if needed
            child: Center(
              child: Text(
                "Discover",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
      Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        const Color(0xFFDC4AC6).withOpacity(0.5),
                        BlendMode.srcOver),
                    image: const AssetImage("assets/images/menu22.png"),
                    fit: BoxFit.cover),
              ),
              child: Image.asset(
                "assets/icons/premiumShows.png",
                scale: 15, // Adjust the scale as needed
              ),
            ),
          ),
          const Positioned(
            top: 0, // Adjust the top position if needed
            left: 0, // Adjust the left position if needed
            right: 0, // Adjust the right position if needed
            bottom: -90, // Adjust the bottom position if needed
            child: Center(
              child: Text(
                "Premium Show",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
      Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        const Color(0xFFD86C08).withOpacity(0.5),
                        BlendMode.srcOver),
                    image: const AssetImage("assets/images/menu33.png"),
                    fit: BoxFit.cover),
              ),
              child: Image.asset(
                "assets/icons/education.png",
                scale: 15, // Adjust the scale as needed
              ),
            ),
          ),
          const Positioned(
            top: 0, // Adjust the top position if needed
            left: 0, // Adjust the left position if needed
            right: 0, // Adjust the right position if needed
            bottom: -90, // Adjust the bottom position if needed
            child: Center(
              child: Text(
                "Education Videos",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
      Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        const Color(0xFF46AFE3).withOpacity(0.5),
                        BlendMode.srcOver),
                    image: const AssetImage("assets/images/authBackground.png"),
                    fit: BoxFit.cover),
              ),
              child: Image.asset(
                "assets/icons/jobs.png",
                scale: 15, // Adjust the scale as needed
              ),
            ),
          ),
          const Positioned(
            top: 0, // Adjust the top position if needed
            left: 0, // Adjust the left position if needed
            right: 0, // Adjust the right position if needed
            bottom: -90, // Adjust the bottom position if needed
            child: Center(
              child: Text(
                "Jobs Videos",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
      Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        const Color(0xFF5E33E0).withOpacity(0.5),
                        BlendMode.srcOver),
                    image: const AssetImage("assets/images/menu44.png"),
                    fit: BoxFit.cover),
              ),
              child: Image.asset(
                "assets/icons/talent.png",
                scale: 15, // Adjust the scale as needed
              ),
            ),
          ),
          const Positioned(
            top: 0, // Adjust the top position if needed
            left: 0, // Adjust the left position if needed
            right: 0, // Adjust the right position if needed
            bottom: -90, // A
            child: Center(
              child: Text(
                "Talent Videos",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
    ];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kBackGroundColor,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Image.asset(
                "assets/icons/back.png",
                scale: 9,
              ),
            ),
          ),
          title: const Text(
            "Menu",
            style: TextStyle(color: kWhiteColor, fontSize: 19),
          ),
          elevation: 1,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: VerticalCardPager(
              initialPage: selectPage,
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 4),
              titles: ["", "", "", "", ""],
              images: images,
              onPageChanged: (page) {},
              align: ALIGN.CENTER,
              onSelectedItem: (index) {
                if (index == 0) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const TabPage(
                        selectedTabIndex: 1,
                        selectedVideoType: "Discover",
                      ),
                    ),
                  );
                } else if (index == 1) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const TabPage(
                        selectedTabIndex: 1,
                        selectedVideoType: "Premium Shows",
                      ),
                    ),
                  );
                } else if (index == 2) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const TabPage(
                        selectedTabIndex: 1,
                        selectedVideoType: "Education Videos",
                      ),
                    ),
                  );
                } else if (index == 3) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const TabPage(
                        selectedTabIndex: 1,
                        selectedVideoType: "Jobs Videos",
                      ),
                    ),
                  );
                } else if (index == 4) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const TabPage(
                        selectedTabIndex: 1,
                        selectedVideoType: "Talent Videos",
                      ),
                    ),
                  );
                }
                // box.write('menuIndex', jsonEncode(index));
                print(index);
              },
            ),
          ),

          // body: SingleChildScrollView(
          //   child: Center(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         const SizedBox(height: 10),
          //         GestureDetector(
          //           onTap: () {
          //             setState(() {
          //               selectIndex = 1;
          //             });
          //             Navigator.of(context).push(
          //               MaterialPageRoute(
          //                 builder: (context) => const TabPage(
          //                   selectedTabIndex: 1,
          //                   selectedVideoType: "Discover",
          //                 ),
          //               ),
          //             );
          //           },
          //           child: Column(
          //             children: [
          //               Container(
          //                 height: selectIndex == 1 ? 130 : 60,
          //                 width: selectIndex == 1 ? 130 : 60,
          //                 decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(100),
          //                   image: DecorationImage(
          //                       colorFilter: ColorFilter.mode(
          //                           const Color(0xFFCD5B5B).withOpacity(0.5),
          //                           BlendMode.srcOver),
          //                       image: const AssetImage(
          //                         "assets/icons/menu1.png",
          //                       ),
          //                       fit: BoxFit.cover),
          //                 ),
          //                 child: Image.asset(
          //                   "assets/icons/searchDescover.png",
          //                   scale: 20,
          //                 ),
          //               ),
          //               const SizedBox(height: 10),
          //               Text(
          //                 "Discover",
          //                 style: TextStyle(
          //                   color: kWhiteColor,
          //                   fontSize: selectIndex == 1 ? 20 : 16,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //         const SizedBox(height: 20),
          //         GestureDetector(
          //           onTap: () {
          //             setState(() {
          //               selectIndex = 2;
          //             });
          //             Navigator.of(context).push(
          //               MaterialPageRoute(
          //                 builder: (context) => const TabPage(
          //                   selectedTabIndex: 1,
          //                   selectedVideoType: "Premium Shows", selectedVideoType: "Education Videos",
          //                 ),
          //               ),
          //             );
          //           },
          //           child: Column(
          //             children: [
          //               Container(
          //                 height: selectIndex == 2 ? 130 : 80,
          //                 width: selectIndex == 2 ? 130 : 80,
          //                 decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(100),
          //                   image: DecorationImage(
          //                       colorFilter: ColorFilter.mode(
          //                           const Color(0xFFDC4AC6).withOpacity(0.5),
          //                           BlendMode.srcOver),
          //                       image: const AssetImage(
          //                         "assets/icons/menu2.png",

          //                       ),
          //                       fit: BoxFit.cover),
          //                 ),
          //                 child: Padding(
          //                   padding: const EdgeInsets.only(bottom: 2.0),
          //                   child: Image.asset(
          //                     "assets/icons/premiumShows.png",
          //                     scale: 20,
          //                   ),
          //                 ),
          //               ),
          //               const SizedBox(height: 15),
          //               Text(
          //                 "Premium Shows",
          //                 style: TextStyle(
          //                   color: kWhiteColor,
          //                   fontSize: selectIndex == 2 ? 20 : 18,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //         const SizedBox(height: 20),
          //         GestureDetector(
          //           onTap: () {
          //             setState(() {
          //               selectIndex = 3;
          //             });
          //             Navigator.of(context).push(
          //               MaterialPageRoute(
          //                 builder: (context) => const TabPage(
          //                   selectedTabIndex: 1,
          //                   selectedVideoType: "Education Videos",
          //                 ),
          //               ),
          //             );
          //           },
          //           child: Column(
          //             children: [
          //               Container(
          //                 height: selectIndex == 3 ? 130 : 80,
          //                 width: selectIndex == 3 ? 130 : 80,
          //                 decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(100),
          //                   image: DecorationImage(
          //                       colorFilter: ColorFilter.mode(
          //                           const Color(0xFFD86C08).withOpacity(0.5),

          //                           BlendMode.srcOver),
          //                       image: const AssetImage(
          //                         "assets/icons/menu3.png",
          //                       ),
          //                       fit: BoxFit.cover),
          //                 ),
          //                 child: Padding(
          //                   padding: const EdgeInsets.only(bottom: 0.0),
          //                   child: Image.asset(
          //                     "assets/icons/education.png",
          //                     scale: 19,
          //                   ),
          //                 ),
          //               ),
          //               const SizedBox(height: 15),
          //               Text(
          //                 "Education Videos",
          //                 style: TextStyle(
          //                   color: kWhiteColor,
          //                   fontSize: selectIndex == 3 ? 20 : 18,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //         const SizedBox(height: 20),
          //         GestureDetector(
          //           onTap: () {
          //             setState(() {
          //               selectIndex = 4;
          //             });
          //             Navigator.of(context).push(
          //               MaterialPageRoute(
          //                 builder: (context) => const TabPage(
          //                   selectedTabIndex: 1,
          //                   selectedVideoType: "Talent Videos",
          //                 ),
          //               ),
          //             );
          //           },
          //           child: Column(
          //             children: [
          //               Container(
          //                 height: selectIndex == 4 ? 130 : 80,
          //                 width: selectIndex == 4 ? 130 : 80,
          //                 decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(100),
          //                   color: kBackGroundColor,
          //                   image: DecorationImage(
          //                     colorFilter: ColorFilter.mode(
          //                         const Color(0xFF46AFE3).withOpacity(0.5),

          //                         BlendMode.srcOver),
          //                     image: const AssetImage(
          //                       "assets/icons/menu4.png",
          //                     ),
          //                   ),
          //                 ),
          //                 child: Image.asset(
          //                   "assets/icons/talent.png",
          //                   scale: 15,
          //                 ),
          //               ),
          //               const SizedBox(height: 15),
          //               Text(
          //                 "Talent Videos",
          //                 style: TextStyle(
          //                   color: kWhiteColor,
          //                   fontSize: selectIndex == 4 ? 20 : 18,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //         const SizedBox(height: 20),
          //         GestureDetector(
          //           onTap: () {
          //             setState(() {
          //               selectIndex = 5;
          //             });
          //             Navigator.of(context).push(
          //               MaterialPageRoute(
          //                 builder: (context) => const TabPage(
          //                   selectedTabIndex: 1,
          //                   selectedVideoType: "Jobs Videos",Talent Videos
          //                 ),
          //               ),
          //             );
          //           },
          //           child: Column(
          //             children: [
          //               Container(
          //                 height: selectIndex == 5 ? 130 : 60,
          //                 width: selectIndex == 5 ? 130 : 60,
          //                 decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(100),
          //                   image: DecorationImage(
          //                       colorFilter: ColorFilter.mode(
          //                           const Color(0xFF5E33E0).withOpacity(0.5),
          //                           BlendMode.srcOver),
          //                       image: const AssetImage(
          //                         "assets/icons/menu5.png",
          //                       ),
          //                       fit: BoxFit.cover),
          //                 ),
          //                 child: Padding(
          //                   padding: const EdgeInsets.only(bottom: 2.0),
          //                   child: Image.asset(
          //                     "assets/icons/jobs.png",

          //                     scale: 19,
          //                   ),
          //                 ),
          //               ),
          //               const SizedBox(height: 15),
          //               Text(
          //                 "Jobs Videos",
          //                 style: TextStyle(
          //                   color: kWhiteColor,
          //                   fontSize: selectIndex == 5 ? 20 : 16,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ));
  }
}
