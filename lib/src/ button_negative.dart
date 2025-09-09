import 'package:flutter/material.dart';

class ButtonNegative extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isShowX;
  final double width;
  final double height;

  ButtonNegative({
    required this.onPressed,
    required this.isShowX,
    this.width = 100,
    this.height = 100,
  });
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          isShowX ? "X" : "",
          style: TextStyle(fontSize: 50),
        ),
      ),
    );
  }
}
