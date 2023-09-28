import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config/constant/color_constant.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({Key? key}) : super(key: key);
  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Container(
        color: kBackGroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 150,
              width: 150,
              margin: const EdgeInsets.only(bottom: 25),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/icons/no-wifi.png"),
                ),
              ),
            ),
            const DefaultTextStyle(
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kTextSecondaryColor),
              child: Text('No Internet Connection'),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: DefaultTextStyle(
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: kButtonSecondaryColor),
                child: Text(
                    'You are not connected to the internet. Make sure Internet is on, Airplane Mode is off.'),
              ),
            ),
            SizedBox(
              width: 170,
              child: CupertinoButton(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                color: kButtonSecondaryColor,
                onPressed: () async {
                  AppSettings.openDeviceSettings();
                },
                child: Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    const Text(
                      'Go to Settings',
                      style:
                          TextStyle(fontSize: 14, color: kTextSecondaryColor),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: Image.asset(
                        "assets/icons/setting.png",
                        fit: BoxFit.cover,
                        color: kTextSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
