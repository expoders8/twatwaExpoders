import 'package:get/get.dart';

import '../ui/auth/otp/otp.dart';
import '../ui/home/tab_page.dart';
import '../ui/auth/login/login.dart';
import '../ui/auth/signup/signup.dart';
import '../ui/auth/forgotpassword/forgotpassword.dart';
import '../ui/favourite/create_and_edit_playlist.dart';
import '../ui/uploadvideo/success_video_uploaded.dart';

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
  ];
}
