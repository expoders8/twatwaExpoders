import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'app/routes/app_pages.dart';
import 'config/provider/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  return runApp(
    ChangeNotifierProvider<ThemeProvider>(
      child: const MyApp(),
      create: (BuildContext context) {
        const isDark = false;
        return ThemeProvider(isDark);
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Twatwa',
      themeMode: ThemeMode.system,
      theme: Provider.of<ThemeProvider>(context, listen: false).getTheme(),
      initialRoute: Routes.loginPage,
      getPages: AppPages.routes,
    );
  }
}
