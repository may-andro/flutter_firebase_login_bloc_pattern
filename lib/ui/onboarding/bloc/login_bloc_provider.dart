import 'package:flutter/material.dart';
import 'package:flutter_login_screen/ui/onboarding/bloc/login_bloc.dart';

class LoginBlocProvider extends InheritedWidget {
  final LoginBloc loginBloc;

  const LoginBlocProvider({
    Key key,
    @required this.loginBloc,
    Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static LoginBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(LoginBlocProvider) as LoginBlocProvider).loginBloc;
  }
}
