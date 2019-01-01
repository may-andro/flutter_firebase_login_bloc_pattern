import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_screen/repo/repository.dart';
import 'package:flutter_login_screen/utils/constants.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {

  //String to store navigationId
  String _verificationId;
  String _phone;
  String _nickname;
  var repository = Repository();
  int currentPage = NAVIGATE_TO_WELCOME_TAB;
  int currentAuthPage = NAVIGATE_TO_AUTH_PHONE_TAB;

  String getName() {
    return _nickname;
  }

  //Stream to control pageController for Navigation
  final _pageNavigationBehaviorSubject = BehaviorSubject<int>();

  // retrieve data from stream
  Stream<int> get pageNavigationStream => _pageNavigationBehaviorSubject.stream;

  // add data to phone stream
  Sink<int> get pageNavigationSink => _pageNavigationBehaviorSubject.sink;

  //Stream to control the
  final _phoneBehaviorSubject = BehaviorSubject<String>();

  // retrieve data from phone stream
  Stream<String> get phoneStream => _phoneBehaviorSubject.stream;

  // add data to phone stream
  Sink<String> get phoneSink => _phoneBehaviorSubject.sink;

  final _optBehaviorSubject = BehaviorSubject<bool>();

  // retrieve data from stream
  Stream<bool> get otpStream => _optBehaviorSubject.stream;

  // add data to phone stream
  Sink<bool> get otpSink => _optBehaviorSubject.sink;

  final _loginBehaviorSubject = BehaviorSubject<String>();

  // retrieve data from stream
  Stream<String> get loginStream => _loginBehaviorSubject.stream;

  // add data to phone stream
  Sink<String> get loginSink => _loginBehaviorSubject.sink;

  final _otpResendStreamController = StreamController<bool>();

  // retrieve data from stream
  Stream<bool> get otpResendStream => _otpResendStreamController.stream;

  // add data to phone stream
  Sink<bool> get otpResendSink => _otpResendStreamController.sink;

  final _errorStreamController = PublishSubject<String>();

  // retrieve data from stream
  Stream<String> get errorStream =>
      _errorStreamController.stream.asBroadcastStream();

  // add data to phone stream
  Sink<String> get errorSink => _errorStreamController.sink;

  LoginBloc() {
    _phoneBehaviorSubject.stream.listen(_verifyPhoneNumber);
    _loginBehaviorSubject.stream.listen(doLogin);
    _otpResendStreamController.stream.listen(resendOtp);
  }

  Future _verifyPhoneNumber(String phoneNumber) async {
    _phone = phoneNumber;
    errorSink.add(null);


    Future.delayed(Duration(seconds: 1), () => otpSink.add(true));

    //Uncomment to enable fire base phone authentication.

    /*final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this._verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this._verificationId = verId;
      print(
          'LoginBloc._verifyPhoneNumber $phoneNumber ${this._verificationId}');
      otpSink.add(true);
    };

    final PhoneVerificationCompleted verifiedSuccess = (FirebaseUser user) {
      print('verified');
      pageNavigationSink.add(NAVIGATE_TO_NICKNAME_TAB);
    };

    final PhoneVerificationFailed veriFailed = (AuthException exception) {
      print('${exception.message}');
      errorSink.add(exception.message);
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 30),
        verificationCompleted: verifiedSuccess,
        verificationFailed: veriFailed);*/
  }

  dispose() {
    _pageNavigationBehaviorSubject.close();
    _phoneBehaviorSubject.close();
    _loginBehaviorSubject.close();
    _optBehaviorSubject.close();
    _otpResendStreamController.close();
    _errorStreamController.close();
  }

  void resendOtp(bool flag) {
    otpSink.add(false);
  }

  void doLogin(String otp) async {
    currentPage = NAVIGATE_TO_NICKNAME_TAB;
    Future.delayed(Duration(seconds: 1), () => pageNavigationSink.add(NAVIGATE_TO_NICKNAME_TAB));

    //Uncomment to enable fire base phone authentication.

    /*FirebaseAuth.instance.currentUser().then((user) {
      if (user != null) {
        pageNavigationSink.add(NAVIGATE_TO_NICKNAME_TAB);
      } else {
        signIn(otp);
      }
    });*/
  }

  void resendOtpAndVerify() {
    _verifyPhoneNumber(_phone);
  }

  signIn(String otp) {
    FirebaseAuth.instance
        .signInWithPhoneNumber(verificationId: _verificationId, smsCode: otp)
        .then((user) {
      pageNavigationSink.add(NAVIGATE_TO_NICKNAME_TAB);
    }).catchError((e) {
      print(e);
      errorSink.add(
          'The sms verification code used to create the phone auth credential is invalid');
    });
  }

  Future createUserDataInRealTimeDatabase(String name) async {
    currentPage = NAVIGATE_TO_ALL_SET_TAB;
    pageNavigationSink.add(NAVIGATE_TO_ALL_SET_TAB);
    _nickname = name;

    //Save data to server or fire store or realtime databse. Add the required code here
    Future.delayed(Duration(seconds: 1), () => pageNavigationSink.add(NAVIGATE_TO_HOME));
  }
}