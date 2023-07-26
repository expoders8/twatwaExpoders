import 'package:flutter/material.dart';

import '../../../../config/constant/color_constant.dart';
import '../../../../config/constant/font_constant.dart';

class UpNextPage extends StatefulWidget {
  const UpNextPage({super.key});

  @override
  State<UpNextPage> createState() => _UpNextPageState();
}

class _UpNextPageState extends State<UpNextPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        scrollDirection: Axis.vertical,
        itemCount: 7,
        itemBuilder: (context, index) {
          return SizedBox(
              height: 90,
              child: Card(
                color: kCardColor,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                  child: Row(
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
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 7),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
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
                        margin: const EdgeInsets.only(right: 10, top: 9),
                        child: const Text(
                          "3:43",
                          style: TextStyle(
                              color: kButtonSecondaryColor,
                              fontSize: 11,
                              fontFamily: kFuturaPTDemi),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(width: 0.7, color: kWhiteColor)),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          width: 40,
                          height: 40,
                          child: Image.asset(
                            "assets/icons/Play.png",
                            scale: 9,
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
