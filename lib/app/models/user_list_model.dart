class Videos {
  String image, title, views;
  Videos({
    required this.image,
    required this.title,
    required this.views,
  });
}

class Follower {
  String image;
  String title;
  String views;
  bool follow;
  Follower({
    required this.image,
    required this.title,
    required this.views,
    required this.follow,
  });
}

class Analytics {
  String image;
  String title;
  String views;
  int numberTop;
  String time;
  Analytics({
    required this.image,
    required this.title,
    required this.views,
    required this.numberTop,
    required this.time,
  });
}
