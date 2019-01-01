import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_screen/ui/onboarding/bloc/login_bloc_provider.dart';
import 'package:flutter_login_screen/ui/onboarding/component/rounded_button.dart';
import 'package:flutter_login_screen/utils/constants.dart';
import 'package:flutter_login_screen/utils/text_constant.dart';

class WelcomeTab extends StatelessWidget {
  final WelcomeTabEnterAnimation animation;
  final VoidCallback navigateToTermsAndCondition;

  WelcomeTab(
      {
        @required AnimationController controller,
        @required this.navigateToTermsAndCondition
      }) : animation = new WelcomeTabEnterAnimation(controller);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildLogoWidget(context),
        Center(
          child: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top +
                    MediaQuery.of(context).size.height * (0.25),
                bottom: MediaQuery.of(context).padding.bottom + 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildLabel1(context),
                _buildLabel2(context),
                _buildButton(context),
              ],
            ),
          ),
        ),
        _buildTermsAndCondition(context)
      ],
    );
  }

  Widget _buildLabel1(BuildContext context) {
    return FadeTransition(
      opacity: animation.welcomeLabelOpacity,
      child: Padding(
        padding:
        EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        child: AutoSizeText(
          WELCOME_LABEL1,
          style: Theme.of(context)
              .textTheme
              .display1
              .copyWith(color: Colors.blueGrey, letterSpacing: 1.2),
          softWrap: true,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildLabel2(BuildContext context) {
    return FadeTransition(
      opacity: animation.subheaderOpacity,
      child: Padding(
        padding:
        EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        child: AutoSizeText(
          WELCOME_LABEL2,
          style: Theme.of(context)
              .textTheme
              .title
              .copyWith(color: Colors.blueGrey, letterSpacing: 1.2),
          softWrap: true,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.diagonal3Values(
        animation.buttonScale.value,
        animation.buttonScale.value,
        1.0,
      ),
      child: RoundedButton(
        onPressed: () {
          var loginBloc = LoginBlocProvider.of(context);
          loginBloc.currentPage = NAVIGATE_TO_AUTH_TAB;
          loginBloc.currentAuthPage = NAVIGATE_TO_AUTH_PHONE_TAB;
          loginBloc.otpSink.add(false);
          loginBloc.pageNavigationSink.add(NAVIGATE_TO_AUTH_TAB);
        },
        text: HI_FLUENCIO,
      ),
    );
  }

  Widget _buildTermsAndCondition(BuildContext context) {
    return Positioned(
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: SafeArea(
        child: InkWell(
          onTap: navigateToTermsAndCondition,
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: FadeTransition(
              opacity: animation.termsAndConditions,
              child: AutoSizeText(
                TERMS_AND_CONDITION,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: Colors.black54),
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoWidget(BuildContext context) {
    return Positioned(
      top: 32.0,
      left: 0.0,
      right: 0.0,
      child: Padding(
        padding: EdgeInsets.only(
            top: 24.0,
            bottom: MediaQuery.of(context).padding.bottom + 40.0),
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.diagonal3Values(
            animation.avatarSize.value,
            animation.avatarSize.value,
            1.0,
          ),
          child: Center(
            child: SizedBox(
                height: MediaQuery.of(context).padding.top +
                    MediaQuery.of(context).size.height * (0.2),
                width:  MediaQuery.of(context).padding.top +
                    MediaQuery.of(context).size.height * (0.2),
                child: FlutterLogo(
                  colors: Colors.yellow,
                )),
          ),
        ),
      ),
    );
  }
}

class WelcomeTabEnterAnimation {
  WelcomeTabEnterAnimation(this.controller)
      : avatarSize = new Tween(begin: 0.3, end: 1.0).animate(
          new CurvedAnimation(
            parent: controller,
            curve: new Interval(
              0.0,
              0.25,
              curve: Curves.decelerate,
            ),
          ),
        ),
        welcomeLabelOpacity = new Tween(begin: 0.0, end: 1.0).animate(
          new CurvedAnimation(
            parent: controller,
            curve: new Interval(
              0.25,
              0.5,
              curve: Curves.bounceOut,
            ),
          ),
        ),
        subheaderOpacity = new Tween(begin: 0.0, end: 0.85).animate(
          new CurvedAnimation(
            parent: controller,
            curve: new Interval(
              0.4,
              0.6,
              curve: Curves.easeIn,
            ),
          ),
        ),
        buttonScale = new Tween(begin: 0.0, end: 1.0).animate(
          new CurvedAnimation(
            parent: controller,
            curve: new Interval(
              0.6,
              0.8,
              curve: Curves.bounceOut,
            ),
          ),
        ),
        termsAndConditions = new Tween(begin: 0.0, end: 1.0).animate(
          new CurvedAnimation(
            parent: controller,
            curve: new Interval(
              0.8,
              1.0,
              curve: Curves.linear,
            ),
          ),
        );

  final AnimationController controller;
  final Animation<double> avatarSize;
  final Animation<double> welcomeLabelOpacity;
  final Animation<double> subheaderOpacity;
  final Animation<double> buttonScale;
  final Animation<double> termsAndConditions;
}
