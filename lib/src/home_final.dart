import 'package:familiada/src/big_final_screen.dart';
import 'package:flutter/material.dart';
import 'participant_screen.dart';

class HomeFinalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/images/background.jpg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BigFinalScreen()),
                      );
                    },
                    child: Text('Wcisnij Mami by zacząć Wielki Finał'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
