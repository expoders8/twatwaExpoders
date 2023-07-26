import 'package:flutter/material.dart';

import '../../../../config/constant/color_constant.dart';

class MyVideoPage extends StatefulWidget {
  const MyVideoPage({super.key});

  @override
  State<MyVideoPage> createState() => _MyVideoPageState();
}

class _MyVideoPageState extends State<MyVideoPage> {
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
                              "assets/images/imagebg1.png",
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
                                        "The Chainsmokers & Coldplay - Something",
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
                      GestureDetector(
                        onTap: showTypeBottomSheet,
                        child: Container(
                          padding: const EdgeInsets.all(11),
                          width: 40,
                          height: 40,
                          child: Image.asset(
                            "assets/icons/eclips-vartical.png",
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

  showTypeBottomSheet() {
    FocusScope.of(context).requestFocus(FocusNode());
    return showModalBottomSheet<dynamic>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: kAppBottomSheetColor,
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                height: 160,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: const Padding(
                          padding: EdgeInsets.only(top: 18.0, bottom: 9),
                          child: Text(
                            "Edit",
                            style: TextStyle(
                                color: kTextsecondarytopColor, fontSize: 16),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 4.0, bottom: 5),
                        child: Text(
                          "--------------------------------------------------",
                          style: TextStyle(
                              color: kButtonSecondaryColor,
                              fontSize: 10,
                              letterSpacing: 3),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 12.0, bottom: 12),
                        child: Text(
                          "Delete",
                          style: TextStyle(
                              color: kTextsecondarytopColor, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
