import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/game_controller.dart';

class ResetBoardDialog {
  static void show({required String text}) {
    Get.dialog(
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            padding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
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
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: Get.theme.primaryTextTheme.bodyText1
                      ?.copyWith(fontSize: 24),
                ),
                const SizedBox(
                  height: 18,
                ),
                GetBuilder<GameController>(
                    init: GameController(),
                    builder: (gameController) {
                      return MaterialButton(
                        elevation: 5,
                        onPressed: () {
                          Get.back();
                          gameController.resetGame();
                        },
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "Reset",
                          style: Get.theme.primaryTextTheme.bodyText1
                              ?.copyWith(fontSize: 20),
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
