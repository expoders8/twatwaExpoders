import 'package:get_storage/get_storage.dart';

const String baseUrl = "https://opentrendapimanagement.azure-api.net";
const String ocpApimSubscriptionKey = "c5c0f404c1b243cbb7335bd9c550d0f4";
const String androidAppId = "com.app.opentrend";
const String iOsAppId = "";

const String playStoreUrl =
    "https://play.google.com/store/apps/details?id=$androidAppId";
const String appStoreUrl = "https://apps.apple.com/in/developer/id=$iOsAppId";

final box = GetStorage();
