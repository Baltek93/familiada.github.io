import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

class GameModel extends ChangeNotifier {
  List<QuestionModel> questions;
  List<QuestionModel> finalQuestions;
  bool isRunIntro = true;
  bool isRunFinal = true;
  final player = AudioPlayer(); // Create a player
  bool isFinishedFirstStage = false;
  int multiplier = 1;
  int debugPoints = 0;
  int finalPoints = 0;
  GameModel(this.questions, this.finalQuestions);

  List<TeamModel> teams = [
    TeamModel(
      "Team Papi",
    ),
    TeamModel("Team Mami")
  ]; // Zakładamy dwóch graczy/drużyn
  int currentQuestionIndex = 0;

  Future<void> runIntro() async {
    if (isRunIntro) {
      // FlameAudio.bgm.play('', volume: 1);
      await player.setAsset(
          'assets/audio/intro.mp3'); // Schemes: (https: | file: | asset: )
      player.play(); // Play without waiting for completion
      await player.setVolume(1); // Half as loud
      isRunIntro = false;
      notifyListeners();
    }
  }

  Future<void> runFinal() async {
    if (isRunFinal) {
      // FlameAudio.bgm.play('', volume: 1);
      await player.setAsset(
          'assets/audio/final.mp3'); // Schemes: (https: | file: | asset: )
      player.play(); // Play without waiting for completion
      await player.setVolume(1); // Half as loud
      isRunFinal = false;
      notifyListeners();
    }
  }

  Future<void> nextQuestion(TeamModel teamModel) async {
    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex++;
    } else {
      isFinishedFirstStage = true;
    }
    clearErrors();
    await player.setAsset('assets/audio/przed_po.mp3');
    player.play();
    notifyListeners();
  }

  void updateScore(TeamModel team, int points) {
    team.points += points * multiplier;
    multiplier = 1;
  }

  void clearErrors() {
    teams.forEach((element) {
      element.errorsForQuestion = 0;
      element.errorForBattle = false;
    });
  }

  QuestionModel get currentQuestion => questions[currentQuestionIndex];
  List<AnswerModel> get currentAnswers =>
      questions[currentQuestionIndex].answers;

  int actualPointsQuestionShown() {
    var tempPoints = 0;
    currentQuestion.answers.forEach((element) {
      if (element.isShown) {
        tempPoints += element.points;
      }
    });
    return tempPoints;
  }

  TeamModel winTeam() {
    if (teams[0].points > teams[1].points) {
      return teams[0];
    } else {
      return teams[1];
    }
  }

  void reset() {
    questions.forEach((question) {
      question.isShownQuestion = false;
      question.answers.forEach((element) {
        element.isShown = false;
      });
    });
  }

  Future<void> showAnswer(int i) async {
    if (questions[currentQuestionIndex].answers.length >= i) {
      questions[currentQuestionIndex].answers[i].isShown = true;
      questions[currentQuestionIndex].answers[i].sound != null
          ? await player
              .setAsset(questions[currentQuestionIndex].answers[i].sound!)
          : await player.setAsset('assets/audio/good_answer_v2.mp3');
      player.play();
      notifyListeners();
    }
  }

  Future<void> badAnswer(TeamModel team) async {
    await player.setAsset('assets/audio/bad_answer_v2.mp3');
    player.play();
    team.errorsForQuestion++;
    notifyListeners();
  }

  showCurrentQuestion() {
    currentQuestion.isShownQuestion = true;
    notifyListeners();
  }

  void updateMultipler(int i) {
    multiplier += i;
    notifyListeners();
  }

  void updateDebugPoints(int i) {
    debugPoints += i;
    notifyListeners();
  }

  badAnswerForBattle(TeamModel team) async {
    await player.setAsset('assets/audio/bad_answer.mp3');
    player.play();
    team.errorForBattle = true;
    notifyListeners();
  }

  addPoints(TeamModel teamModel) {
    var points = 0;
    currentQuestion.answers.forEach((element) {
      if (element.isShown) {
        points += element.points;
      }
    });
    updateScore(teamModel, points);
    notifyListeners();
  }

  addDebugPoints(TeamModel team, int? points) {
    updateScore(team, points ?? 0);
    notifyListeners();
  }

  addFinalPoints(int? points) async {
    if (points != null) {
      if (points > 0) {
        await player.setAsset('assets/audio/good_answer_v2.mp3');
      } else {
        await player.setAsset('assets/audio/bad_answer_v2.mp3');
      }
      player.play();
      finalPoints += points;
    }
    notifyListeners();
  }
}

class QuestionModel {
  String questionTitle;
  bool isShownQuestion;
  List<AnswerModel> answers;
  QuestionModel(this.answers, this.questionTitle, this.isShownQuestion);

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    var jsonAnswer =
        (json['answers'] as List).map((e) => AnswerModel.fromJson(e)).toList();
    jsonAnswer.sort((a, b) => b.points.compareTo(a.points));
    return QuestionModel(
      jsonAnswer,
      json['question'] as String,
      false,
    );
  }
}

class AnswerModel {
  String name;
  int points;
  bool isShown;
  String? sound;
  AnswerModel(this.name, this.points, this.isShown, this.sound);

  AnswerModel.fromJson(Map<String, dynamic> json)
      : name = json['text'] as String,
        points = json['points'] as int,
        isShown = json['isShow'] as bool,
        sound = json['sounds'] != null ? json['sounds'] as String? : null;
}

class TeamModel {
  String name;
  int points;
  int errorsForQuestion;
  bool errorForBattle;
  TeamModel(this.name,
      {this.points = 0,
      this.errorsForQuestion = 0,
      this.errorForBattle = false});
}
