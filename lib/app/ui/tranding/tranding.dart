import 'dart:io';
import 'package:flutter/material.dart';

import '../widgets/appbar.dart';
import '../../view/jobs_view.dart';
import '../../view/talent_view.dart';
import '../../view/discover_view.dart';
import '../../view/trending_view.dart';
import '../../view/education_view.dart';
import '../../view/premiumshows_view.dart';
import '../../../config/constant/color_constant.dart';

// ignore: camel_case_types
class TrendingPage extends StatefulWidget {
  final String? type;
  const TrendingPage({super.key, this.type = "Tranding"});

  @override
  State<TrendingPage> createState() => _TrendingPageState();
}

// ignore: camel_case_types
class _TrendingPageState extends State<TrendingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackGroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Platform.isAndroid ? 60 : 95),
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 20, right: 5),
            child: AppBarWidget(
              title: widget.type.toString(),
            ),
          ),
        ),
        body: widget.type == "Discover"
            ? const DiscoverViewPage()
            : widget.type == "Education Videos"
                ? const EducationViewPage()
                : widget.type == "Premium Shows"
                    ? const PremiumShowsViewPage()
                    : widget.type == "Talent Videos"
                        ? const TalentViewPage()
                        : widget.type == "Jobs Videos"
                            ? const JobsViewPage()
                            : const TrendingViewPage());
  }
}
