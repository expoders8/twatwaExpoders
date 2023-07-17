import 'package:Twatwa/app/ui/auth/login/login.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.loginPage;

  static final routes = [
    GetPage(
      name: _Paths.loginPage,
      page: () => const LoginPage(),
    ),
  ];
}
