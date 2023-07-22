import 'package:flutter/material.dart';

import '../../../config/constant/color_constant.dart';

class CardWidget extends StatefulWidget {
  final List videos;
  const CardWidget({
    super.key,
    required this.videos,
  });

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              SizedBox(
                width: 150,
                height: 100,
                child: Image.asset(
                  "assets/images/authBackground.png",
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 10,
                top: 7,
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(135, 0, 0, 0),
                      borderRadius: BorderRadius.circular(4)),
                  padding: const EdgeInsets.all(4),
                  child: const Text(
                    "12:23",
                    style: TextStyle(color: kWhiteColor, fontSize: 12),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(height: 10),
              Text(
                "Shawn Mendes - Treat \nYou Better",
                style: TextStyle(
                    color: kTextsecondarytopColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 5),
              Text(
                "1,854,681,298 views",
                style:
                    TextStyle(color: kTextsecondarybottomColor, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
