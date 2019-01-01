import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  RoundedButton({@required this.onPressed, @required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
      child: Container(
        height: 48.0,
        width: double.infinity,
        child: RaisedButton(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
          padding: EdgeInsets.all(0.0),
          color: Theme.of(context).primaryColor,
          child: AutoSizeText(text,
              style: Theme.of(context)
                  .textTheme
                  .body1
                  .copyWith(color: Colors.white)),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
