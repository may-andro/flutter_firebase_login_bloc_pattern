import 'package:flutter/material.dart';
import 'package:flutter_login_screen/ui/onboarding/tabs/terms_and_condition.dart';
import 'package:flutter_login_screen/ui/onboarding/tabs/welcome_tab.dart';

class OnBoardingTab extends StatelessWidget {
  final AnimationController animationController;

  OnBoardingTab({this.animationController});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return _buildPager(context);
  }

  Widget _buildPager(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        WelcomeTab(
          controller: animationController,
          navigateToTermsAndCondition: () => _goToPage(1),
        ),
        TermsAndConditionTab(
            onBackPressed : () => _goToPage(0)
        ),
      ],
    );
  }

  void _goToPage(int page) => _pageController.animateToPage(page,
      duration: Duration(milliseconds: 1000),
      curve: Curves.fastOutSlowIn);
}
