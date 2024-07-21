import 'package:flutter/material.dart';


/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class MainScreen extends StatelessWidget {
  const MainScreen({super.key,});

  static const routeName = '/mainscreen';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mainscreen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          
        ),
      ),
    );
  }
}
