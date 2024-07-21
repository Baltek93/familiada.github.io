import 'package:familiada/src/game_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BigFinalScreen extends StatelessWidget {
  late GameModel game;
  @override
  Widget build(BuildContext context) {
    game = Provider.of<GameModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Wielki Finał"),
          leading: BackButton(
            onPressed: () {
              game.reset();
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    columnQuestion(context, false),
                    SizedBox(
                      width: 20,
                    ),
                    columnQuestion(context, true),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Suma ${game.finalPoints}",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                  onPressed: () => game.addFinalPoints(
                    game.debugPoints,
                  ),
                  child: Text("Dodaj pkt"),
                ),
              ],
            ),
          ],
        ));
  }

  Widget columnQuestion(BuildContext context, bool isReverse) {
    var answerTextStyle = Theme.of(context).textTheme.headlineLarge?.copyWith(
          color: Theme.of(context).colorScheme.primary,
        );
    return Column(
      children: [
        ...game.finalQuestions.map(
          (e) => GestureDetector(
            child: Row(
              children: [
                if (!isReverse)
                  SizedBox(
                    width: 400,
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(),
                    ),
                  ),
                SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 25,
                  height: 40,
                  child: TextField(
                      decoration: InputDecoration(),
                      onSubmitted: (value) =>
                          {game.addFinalPoints(int.tryParse(value))}),
                ),
                SizedBox(
                  width: 20,
                ),
                if (isReverse)
                  SizedBox(
                    width: 400,
                    height: 40,
                    child: TextField(decoration: InputDecoration()),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String anwerHideText =
      "........................................................ ";
  String anwerHidePointText = " __  ";

  String questionHideText(int lenght) {
    String a = "";
    for (var i = 0; i < lenght; i++) {
      a += ".";
    }
    a += a;
    return a;
  }
}
