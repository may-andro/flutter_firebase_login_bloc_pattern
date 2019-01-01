import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_screen/ui/onboarding/component/dialog_content.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: Colors.grey[300],
          body: Center(
            child: AutoSizeText(
              'You made it',
              style: Theme.of(context).textTheme.headline.copyWith(
                  color: Colors.blueGrey, fontWeight: FontWeight.w500),
            ),
          ),
        ));
  }

  Future<bool> _onWillPop() {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: DialogContent(
                title: 'Exit!',
                subtitle: 'Do you want to exit?',
                positiveText: 'No',
                negativeText: 'Yes',
                onNegativeCallBack: () {
                  Navigator.of(context).pop(false);
                },onPositiveCallback: () {
                Navigator.of(context).pop(true);
              },
              )
          );
        }) ?? false;
  }
}
