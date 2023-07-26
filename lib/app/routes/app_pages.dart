import 'package:get/get.dart';

import '../ui/menu/menu.dart';
import '../ui/auth/otp/otp.dart';
import '../ui/home/tab_page.dart';
import '../ui/auth/login/login.dart';
import '../ui/auth/signup/signup.dart';
import '../ui/menu/menu_video_list.dart';
import '../ui/profile/profile.dart';
import '../ui/video_details/video_details.dart';
import '../ui/auth/forgotpassword/forgotpassword.dart';
import '../ui/favourite/create_and_edit_playlist.dart';
import '../ui/uploadVideo/success_video_uploaded.dart';
import '../ui/video_details/comments/comments_reply.dart';
import '../ui/video_details/checkout_Payment/checkout_payment.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.tabPage;

  static final routes = [
    GetPage(
      name: _Paths.loginPage,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: _Paths.signUpPage,
      page: () => const SignUpPage(),
    ),
    GetPage(
      name: _Paths.forgotPasswordPage,
      page: () => const ForgotPasswordPage(),
    ),
    GetPage(
      name: _Paths.otpScreen,
      page: () => const OtpScreen(),
    ),
    GetPage(
      name: _Paths.tabPage,
      page: () => const TabPage(),
    ),
    GetPage(
      name: _Paths.createPlaylistPage,
      page: () => const CreateAndEditPlaylistPage(),
    ),
    GetPage(
      name: _Paths.videoUploadedPage,
      page: () => const VideoUploadedPage(),
    ),
    GetPage(
      name: _Paths.menuPage,
      page: () => const MenuPage(),
    ),
    GetPage(
      name: _Paths.menuVideoListPage,
      page: () => const MenuVideoListPage(),
    ),
    GetPage(
      name: _Paths.videoDetailsPage,
      page: () => const VideoDetailsPage(),
    ),
    GetPage(
      name: _Paths.commentReplyPage,
      page: () => const CommentReplyPage(),
    ),
    GetPage(
      name: _Paths.checkOutPaymentPage,
      page: () => const CheckOutPaymentPage(),
    ),
    GetPage(
      name: _Paths.profilePage,
      page: () => const ProfilePage(),
    ),
  ];
}
