import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/game_controller.dart';

class MenuDialog {
  static void show() {
    Get.dialog(
      GetBuilder<GameController>(
          init: GameController(),
          builder: (gameController) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                  width: 280,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Get.theme.disabledColor,
                    border: Border.all(
                      width: 1,
                      color: Get.theme.focusColor,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () {
                            gameController.playsound("click");
                            Get.back();
                          },
                          child: Text(
                            "CLOSE",
                            style:
                                Get.theme.primaryTextTheme.bodyText1?.copyWith(
                              color: Colors.red,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "X",
                              style: Get.theme.primaryTextTheme.headline1
                                  ?.copyWith(fontSize: 50, color: Colors.red),
                            ),
                            TextSpan(
                              text: " - ",
                              style: Get.theme.primaryTextTheme.headline1
                                  ?.copyWith(fontSize: 50, color: Colors.green),
                            ),
                            TextSpan(
                              text: "O",
                              style: Get.theme.primaryTextTheme.headline1
                                  ?.copyWith(
                                      fontSize: 50, color: Colors.yellow),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      ListTile(
                        title: Text(
                          "AUTOPLAY",
                          style: Get.theme.primaryTextTheme.bodyText1,
                        ),
                        trailing: TextButton(
                          onPressed: () {
                            gameController.updateAutoPlay();
                          },
                          child: Text(
                            (gameController.autoplay) ? "ON" : "OFF",
                            style: Get.theme.primaryTextTheme.bodyText1
                                ?.copyWith(color: Colors.green),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "THEME",
                          style: Get.theme.primaryTextTheme.bodyText1,
                        ),
                        trailing: TextButton(
                          onPressed: () {
                            gameController.playsound("click");
                            Get.changeThemeMode((Get.isDarkMode)
                                ? ThemeMode.light
                                : ThemeMode.dark);
                            gameController.update();
                          },
                          child: Text(
                            (Get.isDarkMode) ? "DARK" : "LIGHT",
                            style: Get.theme.primaryTextTheme.bodyText1
                                ?.copyWith(color: Colors.green),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          gameController.resetGame();
                          Get.back();
                        },
                        child: Text(
                          "RESET",
                          style: Get.theme.primaryTextTheme.bodyText1
                              ?.copyWith(color: Colors.green),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (!kIsWeb) {
                            if (Platform.isAndroid || Platform.isIOS) {
                              gameController.adsController.showRewardedAd(
                                  onRewarded: () {
                                gameController.restartGame();
                                Get.back();
                              });
                            }
                          } else {
                            gameController.restartGame();
                            Get.back();
                          }
                        },
                        child: Text(
                          "RESTART",
                          style: Get.theme.primaryTextTheme.bodyText1
                              ?.copyWith(color: Colors.green),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (!kIsWeb) {
                            if (Platform.isAndroid || Platform.isIOS) {
                              gameController.adsController.showRewardedAd(
                                  onRewarded: () {
                                gameController.playsound("click");
                                exit(0);
                              });
                            }
                          } else {
                            gameController.playsound("click");
                            exit(0);
                          }
                        },
                        child: Text(
                          "QUIT",
                          style: Get.theme.primaryTextTheme.bodyText1
                              ?.copyWith(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
