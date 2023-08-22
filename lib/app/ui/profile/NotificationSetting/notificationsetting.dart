import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../config/constant/color_constant.dart';
import '../../../../config/constant/constant.dart';
import '../../../services/notification_service.dart';

class NotificationSettingPage extends StatefulWidget {
  const NotificationSettingPage({super.key});

  @override
  State<NotificationSettingPage> createState() =>
      _NotificationSettingPageState();
}

class _NotificationSettingPageState extends State<NotificationSettingPage> {
  bool _switchValue = false,
      _switchValue1 = false,
      _switchValue2 = true,
      _switchValue3 = false,
      _switchValue4 = false,
      _switchValue5 = true,
      _switchValue6 = true;

  String userId = "", id = "";
  NotificationService notificationService = NotificationService();
  @override
  void initState() {
    getUser();
    callapi();
    super.initState();
  }

  Future getUser() async {
    var data = box.read('user');
    var getUserData = jsonDecode(data);
    if (getUserData != null) {
      setState(() {
        userId = getUserData['id'] ?? "";
      });
    }
  }

  callapi() async {
    Future.delayed(const Duration(milliseconds: 100), () async {
      await notificationService.getNotificationSetting(userId).then(
            (value) => {
              if (value['success'])
                {
                  setState(() {
                    id = value['data']['id'];
                    _switchValue = value['data']['subscriptionAlert'];
                    _switchValue1 = value['data']['recommendedVideoAlert'];
                    _switchValue2 = value['data']['activityOnChannelAlert'];
                    _switchValue3 = value['data']['activityOnCommentAlert'];
                    _switchValue4 = value['data']['replyOnCommentAlert'];
                    _switchValue5 = value['data']['mentionAlert'];
                    _switchValue6 =
                        value['data']['activityOnOtherChannelAlert'];
                  }),
                },
            },
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            child: Column(
              children: [
                Card(
                  color: kCardColor,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Subscriptions",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: kTextsecondarytopColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Notify me about activity from the channels \nI’m subscribed to",
                                style: TextStyle(
                                  color: kTextsecondarybottomColor,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30.0, top: 2),
                            child: CupertinoSwitch(
                              activeColor: kButtonSecondaryColor,
                              thumbColor: kButtonColor,
                              value: _switchValue,
                              onChanged: (value) {
                                setState(() {
                                  _switchValue = value;
                                  updateNotificationSetting();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  color: kCardColor,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Recommended videos",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: kTextsecondarytopColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Notify me of videos I might like based \non what I watch",
                                style: TextStyle(
                                  color: kTextsecondarybottomColor,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30.0, top: 2),
                            child: CupertinoSwitch(
                              activeColor: kButtonSecondaryColor,
                              thumbColor: kButtonColor,
                              value: _switchValue1,
                              onChanged: (value) {
                                setState(() {
                                  _switchValue1 = value;
                                  updateNotificationSetting();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  color: kCardColor,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Activity on my channel",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: kTextsecondarytopColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Notify me about comments and other \nactivity on my channel or videos",
                                style: TextStyle(
                                  color: kTextsecondarybottomColor,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30.0, top: 2),
                            child: CupertinoSwitch(
                              activeColor: kButtonSecondaryColor,
                              thumbColor: kButtonColor,
                              value: _switchValue2,
                              onChanged: (value) {
                                setState(() {
                                  _switchValue2 = value;
                                  updateNotificationSetting();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  color: kCardColor,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Activity on my comments",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: kTextsecondarytopColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Notify me about activity on my comments \non others’ videos",
                                style: TextStyle(
                                  color: kTextsecondarybottomColor,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30.0, top: 2),
                            child: CupertinoSwitch(
                              activeColor: kButtonSecondaryColor,
                              thumbColor: kButtonColor,
                              value: _switchValue3,
                              onChanged: (value) {
                                setState(() {
                                  _switchValue3 = value;
                                  updateNotificationSetting();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  color: kCardColor,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Replies to my comments",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: kTextsecondarytopColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Notify me about replies to my comments",
                                style: TextStyle(
                                  color: kTextsecondarybottomColor,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 30.0, bottom: 5),
                            child: CupertinoSwitch(
                              activeColor: kButtonSecondaryColor,
                              thumbColor: kButtonColor,
                              value: _switchValue4,
                              onChanged: (value) {
                                setState(() {
                                  _switchValue4 = value;
                                  updateNotificationSetting();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  color: kCardColor,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Mentions",
                                style: TextStyle(
                                    color: kTextsecondarytopColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Notify me when others mention my channel",
                                style: TextStyle(
                                  color: kTextsecondarybottomColor,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 30.0, bottom: 5),
                            child: CupertinoSwitch(
                              activeColor: kButtonSecondaryColor,
                              thumbColor: kButtonColor,
                              value: _switchValue5,
                              onChanged: (value) {
                                setState(() {
                                  _switchValue5 = value;
                                  updateNotificationSetting();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  color: kCardColor,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Activity on other channels",
                                style: TextStyle(
                                    color: kTextsecondarytopColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Notify me occasionally when my content is \nshared on other channels",
                                style: TextStyle(
                                  color: kTextsecondarybottomColor,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30.0, top: 5),
                            child: CupertinoSwitch(
                              activeColor: kButtonSecondaryColor,
                              thumbColor: kButtonColor,
                              value: _switchValue6,
                              onChanged: (value) {
                                setState(() {
                                  _switchValue6 = value;
                                  updateNotificationSetting();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  updateNotificationSetting() async {
    Future.delayed(const Duration(milliseconds: 100), () async {
      await notificationService
          .updateNotificationSetting(
            id,
            userId,
            _switchValue,
            _switchValue1,
            _switchValue2,
            _switchValue3,
            _switchValue4,
            _switchValue5,
            _switchValue6,
          )
          .then((value) => {
                if (value['success']) {callapi()}
              });
    });
  }

  buildCardWidget(String title1, String title2, bool value) {
    return Card(
      color: kCardColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 135,
                    child: Text(
                      title1,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: kTextsecondarytopColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title1,
                    style: const TextStyle(
                      color: kTextsecondarybottomColor,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 50.0, top: 10),
                child: CupertinoSwitch(
                  activeColor: kButtonSecondaryColor,
                  thumbColor: kButtonColor,
                  value: _switchValue6,
                  onChanged: (value) {
                    setState(() {
                      _switchValue6 = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
