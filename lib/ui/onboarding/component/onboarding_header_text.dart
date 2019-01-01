import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class OnBoardingHeaderText extends StatelessWidget {
  final String text;

  const OnBoardingHeaderText({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AutoSizeText(
          text,
          style: Theme.of(context)
              .textTheme
              .headline
              .copyWith(color: Colors.blueGrey, letterSpacing: 1.2),
          softWrap: true,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
