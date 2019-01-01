import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_login_screen/ui/onboarding/bloc/login_bloc.dart';
import 'package:flutter_login_screen/ui/onboarding/bloc/login_bloc_provider.dart';
import 'package:flutter_login_screen/ui/onboarding/component/dialog_content.dart';
import 'package:flutter_login_screen/ui/onboarding/tabs/allset_tab.dart';
import 'package:flutter_login_screen/ui/onboarding/tabs/auth_tab.dart';
import 'package:flutter_login_screen/ui/onboarding/tabs/nickname_tab.dart';
import 'package:flutter_login_screen/ui/onboarding/tabs/onboarding_tab.dart';
import 'package:flutter_login_screen/utils/constants.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage>
    with TickerProviderStateMixin {
  PageController _pageController;
  AnimationController animationController;

  var loginBloc;

  int currentPage = NAVIGATE_TO_WELCOME_TAB;
  @override
  void initState() {
    super.initState();

    loginBloc = LoginBloc();

    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 1.0,
    );

    animationController = new AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);

    animationController.forward();

    loginBloc.pageNavigationStream.listen(_navigateToPage);
  }

  Future _navigateToPage(int page) async {
    if (page == NAVIGATE_TO_HOME) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      currentPage = page;
      _pageController.animateToPage(page,
          duration: Duration(milliseconds: 1000), curve: Curves.fastOutSlowIn);
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => LoginBlocProvider(
      loginBloc: loginBloc,
      child: WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            resizeToAvoidBottomPadding: false,
            body: _buildContent(),
            backgroundColor: Colors.grey[300],
          )));

  Widget _buildContent() => AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return PageView(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          physics: new NeverScrollableScrollPhysics(),
          onPageChanged: (int index) {},
          children: <Widget>[
            OnBoardingTab(
              animationController: animationController,
            ),
            AuthTab(),
            NickNameTab(),
            AllSetTab(),
          ],
        );
      });

  Future<bool> _onWillPop() async {
    switch (currentPage) {
      case NAVIGATE_TO_WELCOME_TAB:
        return true;
      case NAVIGATE_TO_AUTH_TAB:
        return showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: DialogContent(
                        title: 'Verification Pending',
                        subtitle:
                            'Your verification is not completed yet! Do you want to exit?',
                        positiveText: 'No',
                        negativeText: 'Yes',
                        onNegativeCallBack: () {
                          loginBloc.pageNavigationSink
                              .add(NAVIGATE_TO_WELCOME_TAB);
                          Navigator.of(context).pop(false);
                        },
                        onPositiveCallback: () {
                          Navigator.of(context).pop(false);
                        },
                      ));
                }) ??
            false;
      case NAVIGATE_TO_NICKNAME_TAB:
        return showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: DialogContent(
                        title: 'Account Pending',
                        subtitle:
                            'Your account is not created yet! Do you want to exit?',
                        positiveText: 'No',
                        negativeText: 'Yes',
                        onNegativeCallBack: () {
                          loginBloc.pageNavigationSink
                              .add(NAVIGATE_TO_WELCOME_TAB);
                          Navigator.of(context).pop(false);
                        },
                        onPositiveCallback: () {
                          Navigator.of(context).pop(false);
                        },
                      ));
                }) ??
            false;
      case NAVIGATE_TO_ALL_SET_TAB:
        return false;
    }
  }
}
