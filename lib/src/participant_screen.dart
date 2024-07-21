import 'dart:convert';

import 'package:familiada/src/big_final_screen.dart';
import 'package:familiada/src/game_model.dart';
import 'package:familiada/src/teams_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ParticipantScreen extends StatelessWidget {
  late GameModel gameModel;
  @override
  Widget build(BuildContext context) {
    gameModel = Provider.of<GameModel>(context);
    gameModel.runIntro();
    var answerTextStyle = Theme.of(context).textTheme.headlineLarge?.copyWith(
          color: Theme.of(context).colorScheme.primary,
        );

    ServicesBinding.instance.keyboard.addHandler(_onKey);
    return Scaffold(
      appBar: AppBar(
        title: null,
        leading: BackButton(
          onPressed: () {
            gameModel.reset();
            Navigator.pop(context);
          },
        ),
      ),
      body: gameModel.isFinishedFirstStage
          ? summaryScreen(gameModel, context)
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TeamWidget(
                  team: gameModel.teams[0],
                  game: gameModel,
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            GestureDetector(
                              onTap: () => gameModel.showCurrentQuestion(),
                              child: Text(
                                gameModel.currentQuestion.isShownQuestion
                                    ? '${gameModel.currentQuestion.questionTitle}'
                                    : questionHideText(gameModel
                                        .currentQuestion.questionTitle.length),
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 20),
                            ...gameModel.currentAnswers
                                .map((answer) => Padding(
                                      padding: const EdgeInsets.only(top: 32),
                                      child: GestureDetector(
                                        onTap: () {
                                          gameModel.showAnswer(gameModel
                                              .currentAnswers
                                              .indexOf(answer));
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  (gameModel.currentAnswers
                                                                  .indexOf(
                                                                      answer) +
                                                              1)
                                                          .toString() +
                                                      ". ",
                                                  style: answerTextStyle,
                                                ),
                                                Text(
                                                    answer.isShown == true
                                                        ? answer.name
                                                        : anwerHideText,
                                                    style: answerTextStyle),
                                              ],
                                            ),
                                            Text(
                                              answer.isShown == true
                                                  ? answer.points.toString()
                                                  : anwerHidePointText,
                                              style: answerTextStyle,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))
                                .toList(),
                            SizedBox(height: 48),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Suma     " +
                                      gameModel
                                          .actualPointsQuestionShown()
                                          .toString(),
                                  style: answerTextStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(children: [
                          Text("Mnoznik"),
                          ElevatedButton(
                            child: Text("-"),
                            onPressed: () {
                              gameModel.updateMultipler(-1);
                            },
                          ),
                          Text(gameModel.multiplier.toString()),
                          ElevatedButton(
                            child: Text("+"),
                            onPressed: () {
                              gameModel.updateMultipler(1);
                            },
                          ),
                        ]),
                      ],
                    ),
                  ),
                ),
                TeamWidget(
                  team: gameModel.teams[1],
                  game: gameModel,
                ),
              ],
            ),
    );
  }

  Widget summaryScreen(GameModel gameModel, BuildContext context) {
    var winTeam = gameModel.winTeam();
    return Center(
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Wygrała druzyna ${winTeam.name}\nSuma punktów wyniosła: ${winTeam.points}",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  bool _onKey(
    KeyEvent event,
  ) {
    final key = event.logicalKey.keyLabel;

    if (event is KeyDownEvent) {
      print("Key down: $key");
    } else if (event is KeyUpEvent) {
      if (key == "0") {
        gameModel.showCurrentQuestion();
      }
      if (key == "1") {
        gameModel.showAnswer(0);
      }
      if (key == "2") {
        gameModel.showAnswer(1);
      }
      if (key == "3") {
        gameModel.showAnswer(2);
      }
      if (key == "4") {
        gameModel.showAnswer(3);
      }
      if (key == "5") {
        gameModel.showAnswer(4);
      }
      if (key == "6") {
        gameModel.showAnswer(5);
      }
      if (key == "7") {
        gameModel.showAnswer(6);
      }
      if (key == "8") {
        gameModel.showAnswer(7);
      }
      print("Key up: $key");
    } else if (event is KeyRepeatEvent) {
      print("Key repeat: $key");
    }

    return false;
  }
}

String anwerHideText =
    "........................................................ ";
String anwerHidePointText = " __";

String questionHideText(int lenght) {
  String a = "";
  for (var i = 0; i < lenght; i++) {
    a += ".";
  }
  a += a;
  return a;
}
