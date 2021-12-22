import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'config/custom_theme.dart';
import 'views/screens/game_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    if (Platform.isAndroid || Platform.isIOS) {
      await MobileAds.instance.initialize().then((InitializationStatus status) {
        MobileAds.instance.updateRequestConfiguration(
          RequestConfiguration(
              tagForChildDirectedTreatment:
                  TagForChildDirectedTreatment.unspecified,
              testDeviceIds: <String>["398CA3A0982891A5BFDADDCB1508E1C4"]),
        );
      });
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      theme: CustomThemes.lightTheme,
      darkTheme: CustomThemes.darkTheme,
      themeMode: (Get.isDarkMode) ? ThemeMode.dark : ThemeMode.light,
      initialRoute: "/",
      routes: {
        "/": (context) => const GameScreen(),
      },
    );
  }
}
