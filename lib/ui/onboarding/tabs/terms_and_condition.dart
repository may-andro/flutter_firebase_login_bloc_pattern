import 'package:flutter/material.dart';
import 'package:flutter_login_screen/ui/onboarding/component/previous_button.dart';

class TermsAndConditionTab extends StatelessWidget {
  final VoidCallback onBackPressed;

  TermsAndConditionTab({@required this.onBackPressed});

  @override
  Widget build(BuildContext context) => Stack(
    children: <Widget>[
      PreviousButton(
        onPressed: onBackPressed,
      ),

      Center(
        child: Text('Terms and Constions'),
      )
    ],
  );
}
