import 'package:get_storage/get_storage.dart';

const String baseUrl = "https://opentrend-api.azurewebsites.net/";
const String videobBaseUrl = "https://opentrend-video-api.azurewebsites.net/";
const String androidAppId = "com.app.opentrend";
const String iOsAppId = "";

const String playStoreUrl =
    "https://play.google.com/store/apps/details?id=$androidAppId";
const String appStoreUrl = "https://apps.apple.com/in/developer/id=$iOsAppId";

final box = GetStorage();
