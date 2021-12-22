import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:unpaid/controllers/ad_manager.dart';
import '../models/game_buttons.dart';
import '../views/dialogs/reset_board_dialog.dart';

enum Player { playerX, playerO }

class GameController extends GetxController {
  int boardSize = 3;
  Player startGameTurn = Player.playerX;
  Player turn = Player.playerX;
  int xWins = 0;
  int oWins = 0;
  int draw = 0;
  bool autoplay = false;

  void playsound(String fileName) {
    if (!kIsWeb) {
      final player = AudioCache(prefix: "assets/audio/");
      player.play('$fileName.wav');
    }
  }

  List<GameButtons> gamebuttons = [];

  dynamic adsController;
  @override
  void onInit() {
    if (!kIsWeb) {
      if (Platform.isAndroid || Platform.isIOS) {
        adsController = Get.put<AdsController>(AdsController());
      }
    }

    initGameButton();
    super.onInit();
  }

  void autoplayON() {
    List<GameButtons> check =
        gamebuttons.where((element) => element.text.isEmpty).toList();

    if (check.isNotEmpty) {
      final _random = Random();
      var element = check[_random.nextInt(check.length)];
      element.text = "O";
      element.enabled = false;
      update();
    }
  }

  void initGameButton() {
    gamebuttons = List.generate(
      boardSize * boardSize,
      (index) => GameButtons(enabled: true, text: ""),
    );
    update();
  }

  void updateGameButton({required int index}) {
    playsound("click");
    gamebuttons[index].text = (turn == Player.playerX) ? "X" : "O";
    gamebuttons[index].enabled = false;
    update();

    if (autoplay) {
      autoplayON();
    } else {
      turn = (turn == Player.playerX) ? Player.playerO : Player.playerX;
    }
    checkWinner();
  }

  void checkWinner() {
    if ((gamebuttons[0].text == "X" &&
            gamebuttons[1].text == "X" &&
            gamebuttons[2].text == "X") ||
        (gamebuttons[3].text == "X" &&
            gamebuttons[4].text == "X" &&
            gamebuttons[5].text == "X") ||
        (gamebuttons[6].text == "X" &&
            gamebuttons[7].text == "X" &&
            gamebuttons[8].text == "X") ||
        (gamebuttons[0].text == "X" &&
            gamebuttons[3].text == "X" &&
            gamebuttons[6].text == "X") ||
        (gamebuttons[1].text == "X" &&
            gamebuttons[4].text == "X" &&
            gamebuttons[7].text == "X") ||
        (gamebuttons[2].text == "X" &&
            gamebuttons[5].text == "X" &&
            gamebuttons[8].text == "X") ||
        (gamebuttons[0].text == "X" &&
            gamebuttons[4].text == "X" &&
            gamebuttons[8].text == "X") ||
        (gamebuttons[2].text == "X" &&
            gamebuttons[4].text == "X" &&
            gamebuttons[6].text == "X")) {
      playsound("over");
      ResetBoardDialog.show(text: "X Won's");
      xWins++;
      disableAllButtons();
    } else if ((gamebuttons[0].text == "O" &&
            gamebuttons[1].text == "O" &&
            gamebuttons[2].text == "O") ||
        (gamebuttons[3].text == "O" &&
            gamebuttons[4].text == "O" &&
            gamebuttons[5].text == "O") ||
        (gamebuttons[6].text == "O" &&
            gamebuttons[7].text == "O" &&
            gamebuttons[8].text == "O") ||
        (gamebuttons[0].text == "O" &&
            gamebuttons[3].text == "O" &&
            gamebuttons[6].text == "O") ||
        (gamebuttons[1].text == "O" &&
            gamebuttons[4].text == "O" &&
            gamebuttons[7].text == "O") ||
        (gamebuttons[2].text == "O" &&
            gamebuttons[5].text == "O" &&
            gamebuttons[8].text == "O") ||
        (gamebuttons[0].text == "O" &&
            gamebuttons[4].text == "O" &&
            gamebuttons[8].text == "O") ||
        (gamebuttons[2].text == "O" &&
            gamebuttons[4].text == "O" &&
            gamebuttons[6].text == "O")) {
      playsound("over");
      ResetBoardDialog.show(text: "O Won's.");
      oWins++;
      disableAllButtons();
    } else if (gamebuttons.every((element) => element.enabled == false)) {
      playsound("over");
      ResetBoardDialog.show(text: "It's a draw.");
      draw++;
    }
  }

  void disableAllButtons() {
    for (var element in gamebuttons) {
      element.enabled = false;
    }
    update();
  }

  void updateAutoPlay() {
    playsound("click");
    autoplay = !autoplay;
    resetGame();
    update();
  }

  void resetGame() {
    playsound("click");
    if (!kIsWeb) {
      if (Platform.isAndroid || Platform.isIOS) {
        adsController.showInterstitialAd();
      }
    }

    if (!autoplay) {
      startGameTurn =
          (startGameTurn == Player.playerX) ? Player.playerO : Player.playerX;
      turn = startGameTurn;
    } else {
      turn = Player.playerX;
    }

    initGameButton();
  }

  void restartGame() {
    playsound("click");
    startGameTurn = Player.playerX;
    turn = Player.playerX;

    xWins = 0;
    oWins = 0;
    draw = 0;
    initGameButton();
  }
}
