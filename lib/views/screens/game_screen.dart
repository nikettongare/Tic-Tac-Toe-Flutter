import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/game_controller.dart';
import '/views/dialogs/menu_dialog.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: GetBuilder<GameController>(
          init: GameController(),
          builder: (gameController) {
            return Scaffold(
              body: (height >= 400 && width >= 200)
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!kIsWeb)
                            if ((height >= 530) &&
                                (Platform.isAndroid || Platform.isIOS))
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: SizedBox(
                                  height: gameController
                                      .adsController.myBanner0.size.height
                                      .toDouble(),
                                  width: gameController
                                      .adsController.myBanner0.size.width
                                      .toDouble(),
                                  child: gameController.adsController.adWidget0,
                                ),
                              ),
                          SizedBox(
                            height: 90,
                            width: 280,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "X",
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline1
                                          ?.copyWith(
                                            color: Colors.red,
                                          ),
                                    ),
                                    Text(
                                      "${gameController.xWins} Wins",
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .bodyText1
                                          ?.copyWith(
                                            color: Colors.red,
                                          ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "O",
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline1
                                          ?.copyWith(
                                            color: Colors.yellow,
                                          ),
                                    ),
                                    Text(
                                      "${gameController.oWins} Wins",
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .bodyText1
                                          ?.copyWith(
                                            color: Colors.yellow,
                                          ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "D",
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline1
                                          ?.copyWith(
                                            color: Colors.green,
                                          ),
                                    ),
                                    Text(
                                      "${gameController.draw} Draws",
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .bodyText1
                                          ?.copyWith(
                                            color: Colors.green,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          SizedBox(
                            width: max(340, 340),
                            height: (MediaQuery.of(context).size.width < 340)
                                ? MediaQuery.of(context).size.width
                                : 340,
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(10),
                              itemCount: gameController.gamebuttons.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: gameController.boardSize,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                              ),
                              itemBuilder: (context, i) => MaterialButton(
                                elevation: 5,
                                onPressed: () {
                                  if (gameController.gamebuttons[i].enabled ==
                                      true) {
                                    gameController.updateGameButton(index: i);
                                  }
                                },
                                color: (gameController.gamebuttons[i].enabled ==
                                        true)
                                    ? Theme.of(context).focusColor
                                    : Theme.of(context).disabledColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    side: BorderSide(
                                        width: 1,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor)),
                                child: Center(
                                  child: Text(
                                    gameController.gamebuttons[i].text,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .headline1
                                        ?.copyWith(
                                            color: (gameController
                                                        .gamebuttons[i].text ==
                                                    "X")
                                                ? Colors.red
                                                : Colors.yellow),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          SizedBox(
                            height: 52,
                            width: 280,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).focusColor,
                                    shape: BoxShape.circle,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 1.0), //(x,y)
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  child: IconButton(
                                    tooltip: "Reset Board",
                                    onPressed: () {
                                      gameController.resetGame();
                                    },
                                    icon: const Icon(
                                      Icons.loop_rounded,
                                    ),
                                    color: Colors.green,
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 8, 15, 8),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).focusColor,
                                    borderRadius: BorderRadius.circular(6),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 1.0), //(x,y)
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    (gameController.turn == Player.playerX)
                                        ? "X's turn"
                                        : "O's turn",
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1
                                        ?.copyWith(
                                            color: (gameController.turn ==
                                                    Player.playerX)
                                                ? Colors.red
                                                : Colors.yellow),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).focusColor,
                                    shape: BoxShape.circle,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 1.0), //(x,y)
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  child: IconButton(
                                    tooltip: "Settings",
                                    onPressed: () {
                                      gameController.playsound("click");
                                      MenuDialog.show();
                                    },
                                    icon: const Icon(Icons.settings_rounded),
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (!kIsWeb)
                            if ((height >= 465) &&
                                (Platform.isAndroid || Platform.isIOS))
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: SizedBox(
                                  height: gameController
                                      .adsController.myBanner.size.height
                                      .toDouble(),
                                  width: gameController
                                      .adsController.myBanner.size.width
                                      .toDouble(),
                                  child: gameController.adsController.adWidget,
                                ),
                              ),
                        ],
                      ),
                    )
                  : Center(
                      child: Text("Screen Size Not Support",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).primaryTextTheme.bodyText1),
                    ),
            );
          }),
    );
  }
}
