import 'dart:convert';

import 'package:familiada/src/game_model.dart';
import 'package:familiada/src/home_final.dart';
import 'package:familiada/src/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: readJson(),
      builder: (context, snapshot) => ChangeNotifierProvider(
        create: (context) =>
            GameModel(snapshot.requireData.first, snapshot.requireData.last),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SalsoFamiliada',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomeFinalScreen(),
        ),
      ),
    );
  }
}

Future<List<List<QuestionModel>>> readJson() async {
  final questionData =
      await json.decode(await rootBundle.loadString('assets/questions.json'));
  final questionFinallyData =
      await json.decode(await rootBundle.loadString('assets/final_questions.json'));
  final List<List<QuestionModel>> listQuestions = [];
  final questions = (questionData["questions"] as List)
      .map((e) => QuestionModel.fromJson(e))
      .toList();

  final questionsFinally = (questionFinallyData["questions"] as List)
      .map((e) => QuestionModel.fromJson(e))
      .toList();

  listQuestions.add(questions);
  listQuestions.add(questionsFinally);

  return listQuestions;
}
