import 'package:familiada/src/%20button_negative.dart';
import 'package:familiada/src/game_model.dart';
import 'package:flutter/material.dart';

class TeamWidget extends StatelessWidget {
  final TeamModel team;
  final GameModel game;
  TeamWidget({required this.team, required this.game});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            team.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            "Punkty:\n${team.points}",
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          isShowOneAnswer()
              ? Expanded(
                  child: ButtonNegative(
                    onPressed: () => game.badAnswerForBattle(team),
                    isShowX: team.errorForBattle,
                    height: 0,
                  ),
                )
              : Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonNegative(
                        onPressed: () => game.badAnswer(team),
                        isShowX: team.errorsForQuestion == 3,
                      ),
                      ButtonNegative(
                        onPressed: () => game.badAnswer(team),
                        isShowX: team.errorsForQuestion >= 2,
                      ),
                      ButtonNegative(
                          onPressed: () => game.badAnswer(team),
                          isShowX: team.errorsForQuestion >= 1),
                    ],
                  ),
                ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () => game.addPoints(team),
                    child: Text("Dodaj punkty z pytania  ")),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      game.currentAnswers
                              .where((element) => !element.isShown)
                              .isNotEmpty
                          ? showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                    title:
                                        const Text('Pokaz reszte odpowiedzi'),
                                    content: const Text(
                                      'Nie zostały odkryte wszystkie odpowiedzi',
                                    ));
                              },
                            )
                          : game.nextQuestion(team);
                    },
                    child: Text(
                        game.currentQuestionIndex < (game.questions.length - 1)
                            ? "nastepne pytanie "
                            : "przejdz do podsumowania")),
                SizedBox(
                  height: 20,
                ),
                Row(children: [
                  Text("Dodaj PKT"),
                  ElevatedButton(
                    child: Text("-10"),
                    onPressed: () {
                      game.updateDebugPoints(-10);
                    },
                  ),
                  ElevatedButton(
                    child: Text("-"),
                    onPressed: () {
                      game.updateDebugPoints(-1);
                    },
                  ),
                  Text(game.debugPoints.toString()),
                  ElevatedButton(
                    child: Text("+"),
                    onPressed: () {
                      game.updateDebugPoints(1);
                    },
                  ),
                  ElevatedButton(
                    child: Text("+10"),
                    onPressed: () {
                      game.updateDebugPoints(10);
                    },
                  ),
                ]),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () => game.addDebugPoints(
                          team,
                          game.debugPoints,
                        ),
                    child: Text("Dodaj punkty jakby się coś wywalilo  ")),
              ],
            ),
          )
        ],
      ),
    );
  }

  bool isShowOneAnswer() {
    return game.currentAnswers
            .where((element) => element.isShown == true)
            .firstOrNull ==
        null;
  }
}
