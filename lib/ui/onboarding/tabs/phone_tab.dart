import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_screen/ui/onboarding/bloc/login_bloc_provider.dart';
import 'package:flutter_login_screen/ui/onboarding/component/rounded_button.dart';
import 'package:flutter_login_screen/utils/text_constant.dart';

class PhoneVerificationTab extends StatelessWidget {
  final phoneNumberController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return _buildForm(context);
  }

  Widget _buildForm(BuildContext context) => SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  child: _buildLabel(context),
                  height: 75.0,
                ),
                _buildTextForm(context),
                _buildButton(context)
              ],
            ),
          ),
        ),
      );

  _buildButton(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
        child: RoundedButton(
          onPressed: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            if (formKey.currentState.validate()) {
              formKey.currentState.save();
              LoginBlocProvider.of(context)
                  .phoneSink
                  .add(phoneNumberController.text);
            }
          },
          text: PHONE_AUTH_BUTTON_LABEL,
        ),
      );

  _buildTextForm(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: StreamBuilder<String>(
          stream: LoginBlocProvider.of(context).errorStream,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            final String message = snapshot.data;
            return TextFormField(
              style: Theme.of(context)
                  .textTheme
                  .headline
                  .copyWith(color: Colors.blueGrey, letterSpacing: 1.2),
              decoration: new InputDecoration(
                border: InputBorder.none,
                hintText: PHONE_AUTH_HINT,
                helperText: PHONE_AUTH_HELPER,
                errorText: message,
                errorMaxLines: 10,
                helperStyle: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: Colors.blueGrey, letterSpacing: 1.2),
              ),
              keyboardType: TextInputType.phone,
              maxLength: 14,
              controller: phoneNumberController,
              validator: (val) => val.length == 0
                  ? PHONE_AUTH_VALIDATION_EMPTY
                  : val.length < 10 ? PHONE_AUTH_VALIDATION_INVALID : null,
            );
          },
        ),
      );

  _buildLabel(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
        child: AutoSizeText(
          PHONE_AUTH_LABEL,
          style: Theme.of(context).textTheme.subhead.copyWith(
              color: Colors.black87,
              letterSpacing: 1.0,
              fontWeight: FontWeight.normal),
          textAlign: TextAlign.center,
        ),
      );
}
