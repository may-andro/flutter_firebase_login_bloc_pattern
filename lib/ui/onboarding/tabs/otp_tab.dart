import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_screen/ui/onboarding/bloc/login_bloc_provider.dart';
import 'package:flutter_login_screen/ui/onboarding/component/count_down_timer.dart';
import 'package:flutter_login_screen/ui/onboarding/component/rounded_button.dart';
import 'package:flutter_login_screen/utils/text_constant.dart';

class OtpVerificationTab extends StatefulWidget {
  @override
  OtpVerificationTabState createState() {
    return new OtpVerificationTabState();
  }
}

class OtpVerificationTabState extends State<OtpVerificationTab>
    with TickerProviderStateMixin {
  final TextEditingController otpController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  AnimationController _controller;

  bool _otpTimedOut = false;

  @override
  void initState() {
    super.initState();

    _controller = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 30),
    )..addStatusListener((AnimationStatus state) {
        if (state == AnimationStatus.completed) {
          _otpTimedOut = true;
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(child: _buildLabel(), height: 75.0,),
              _buildTextForm(),
              _buildButton(),
              _buildResendSmsWidget()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel() {
    return Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
      child: AutoSizeText(
        OTP_AUTH_LABEL,
        style: Theme.of(context).textTheme.subhead.copyWith(
            color: Colors.black87,
            letterSpacing: 1.0,
            fontWeight: FontWeight.normal),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildTextForm() {
    return Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: StreamBuilder<String>(
        stream: LoginBlocProvider.of(context).errorStream,
        builder:
            (BuildContext context, AsyncSnapshot<String> snapshot) {
          final String message = snapshot.data;
          return TextFormField(
            style: Theme.of(context)
                .textTheme
                .headline
                .copyWith(color: Colors.blueGrey, letterSpacing: 1.2),
            decoration: new InputDecoration(
              border: InputBorder.none,
              hintText: OTP_AUTH_HINT,
              errorText: message,
              helperText: OTP_AUTH_HELPER,
              errorMaxLines: 10,
              helperStyle: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(
                  color: Colors.blueGrey, letterSpacing: 1.2),
            ),
            keyboardType: TextInputType.number,
            maxLength: 6,
            controller: otpController,
            validator: (val) => val.length == 0
                ? OTP_AUTH_VALIDATION_EMPTY
                : val.length < 6 ? OTP_AUTH_VALIDATION_INVALID : null,
          );
        },
      ),
    );
  }

  Widget _buildButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
      child: RoundedButton(
        onPressed: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            LoginBlocProvider.of(context).loginSink.add(otpController.text);
          }
        },
        text: OTP_AUTH_BUTTON_LABEL,
      ),
    );
  }

  Widget _buildResendSmsWidget() {
    _controller.forward(from: 0.0);

    return InkWell(
      onTap: () async {
        if (_otpTimedOut) {
          LoginBlocProvider.of(context).resendOtpAndVerify();
        } else {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text(OTP_RESEND_MESSAGE)));
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Countdown(
          animation: new StepTween(
            begin: 30,
            end: 0,
          ).animate(_controller),
        ),
      ),
    );
  }
}

