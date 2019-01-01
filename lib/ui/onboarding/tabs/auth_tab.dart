import 'package:flutter/material.dart';
import 'package:flutter_login_screen/ui/onboarding/bloc/login_bloc.dart';
import 'package:flutter_login_screen/ui/onboarding/bloc/login_bloc_provider.dart';
import 'package:flutter_login_screen/ui/onboarding/component/onboarding_header_text.dart';
import 'package:flutter_login_screen/ui/onboarding/tabs/otp_tab.dart';
import 'package:flutter_login_screen/ui/onboarding/tabs/phone_tab.dart';
import 'package:flutter_login_screen/utils/constants.dart';
import 'package:flutter_login_screen/utils/text_constant.dart';

class AuthTab extends StatefulWidget {
  @override
  AuthTabState createState() {
    return new AuthTabState();
  }
}

class AuthTabState extends State<AuthTab> with TickerProviderStateMixin {
  final PageController _pageController = PageController();

  @override
  void didChangeDependencies() {
    LoginBloc loginBloc = LoginBlocProvider.of(context);
    loginBloc.otpStream.listen(_goToOtpPage);
    super.didChangeDependencies();
  }


  Future _goToOtpPage(bool isPhoneVerified) async {
    if (isPhoneVerified) {
      _pageController.animateToPage(NAVIGATE_TO_AUTH_OTP_TAB,
          duration: Duration(milliseconds: 1000), curve: Curves.fastOutSlowIn);
    } else {
      _pageController.animateToPage(0,
          duration: Duration(milliseconds: 1000), curve: Curves.fastOutSlowIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: _buildPager(context));
  }

  Widget _buildPager(BuildContext context) {
    return NestedScrollView(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          PhoneVerificationTab(),
          OtpVerificationTab(),
        ],
      ),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
              expandedHeight: 150.0,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              forceElevated: innerBoxIsScrolled,
              flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background:  OnBoardingHeaderText(text: AUTH_LABEL)
              )
          ),
        ];
      },
    );
  }
}
