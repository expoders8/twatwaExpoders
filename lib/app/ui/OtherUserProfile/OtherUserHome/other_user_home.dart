import 'package:flutter/material.dart';

import '../../../../config/constant/font_constant.dart';
import '../../../../config/constant/color_constant.dart';

class OtherUserHomePage extends StatefulWidget {
  const OtherUserHomePage({super.key});

  @override
  State<OtherUserHomePage> createState() => _OtherUserHomePageState();
}

class _OtherUserHomePageState extends State<OtherUserHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        scrollDirection: Axis.vertical,
        itemCount: 10,
        itemBuilder: (context, index) {
          return SizedBox(
              height: 90,
              child: Card(
                color: kCardColor,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4)),
                            height: 100,
                            width: 100,
                            child: Image.asset(
                              "assets/images/imagebg.png",
                            ),
                          ),
                          const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8.0, top: 7),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 135,
                                      child: Text(
                                        "We Don’t Talk Anymore feat. Selena Gomez",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: kTextsecondarytopColor,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "681,298 views",
                                      style: TextStyle(
                                        color: kTextsecondarybottomColor,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 5, top: 9),
                        child: const Text(
                          "3:43",
                          style: TextStyle(
                              color: kButtonSecondaryColor,
                              fontSize: 11,
                              fontFamily: kFuturaPTDemi),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border:
                                  Border.all(width: 0.7, color: kWhiteColor)),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            width: 34,
                            height: 34,
                            child: Image.asset(
                              "assets/icons/Play.png",
                              scale: 9,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
