import 'package:flutter/material.dart';

class Countdown extends AnimatedWidget {
  Countdown({Key key, this.animation}) : super(key: key, listenable: animation);
  final Animation<int> animation;

  @override
  build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: animation.value == 0 ? "Resend Otp" :
        "If your code does not arrive in ${animation.value.toString()} seconds, touch",
        style: Theme.of(context).textTheme.caption.copyWith(
            color: Colors.black87,
            letterSpacing: 1.0,
            fontWeight: FontWeight.normal),
        children: <TextSpan>[
          TextSpan(
            text: " here",
            style: Theme.of(context).textTheme.caption.copyWith(
                color: Colors.blue,
                letterSpacing: 1.0,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
