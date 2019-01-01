import 'package:flutter/material.dart';

class PreviousButton extends StatelessWidget {
  final VoidCallback onPressed;

  PreviousButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 32.0,
      left: 0.0,
      child: SafeArea(
        child: new ClipRRect(
          borderRadius: new BorderRadius.only(
            bottomRight: new Radius.circular(30.0),
            topRight: new Radius.circular(30.0),
          ),
          child: new MaterialButton(
              elevation: 12.0,
              minWidth: 70.0,
              color: Colors.white,
              onPressed: onPressed,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              )),
        ),
      ),
    );
  }
}
