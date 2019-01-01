import 'package:flutter/material.dart';
import 'package:flutter_login_screen/ui/onboarding/bloc/login_bloc_provider.dart';
import 'package:flutter_login_screen/ui/onboarding/component/onboarding_header_text.dart';
import 'package:flutter_login_screen/ui/onboarding/component/rounded_button.dart';
import 'package:flutter_login_screen/utils/text_constant.dart';

class NickNameTab extends StatelessWidget {
  // Controllers
  final TextEditingController nameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: _buildScrollPage(context));
  }

  Widget _buildScrollPage(BuildContext context) {
    return NestedScrollView(
      body: _buildForm(context),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
              expandedHeight: 150.0,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              forceElevated: innerBoxIsScrolled,
              flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: OnBoardingHeaderText(text: NICK_NAME_LABEL))),
        ];
      },
    );
  }

  Widget _buildForm(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 24.0,),
              _buildTextForm(context),
              _buildButton(context)],
          ),
        ),
      ),
    );
  }

  Widget _buildTextForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: TextFormField(
        style: Theme.of(context)
            .textTheme
            .headline
            .copyWith(color: Colors.blueGrey, letterSpacing: 1.2),
        decoration: new InputDecoration(
          border: InputBorder.none,
          hintText: NICK_NAME_HINT,
          helperText: NICK_NAME_HELPER,
          helperStyle: Theme.of(context)
              .textTheme
              .caption
              .copyWith(color: Colors.blueGrey, letterSpacing: 1.2),
        ),
        keyboardType: TextInputType.text,
        maxLength: 10,
        controller: nameController,
        validator: (val) => val.length == 0
            ? NICK_NAME_VALIDATION_EMPTY
            : val.length < 2 ? NICK_NAME_VALIDATION_INVALID : null,
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
      child: RoundedButton(
        onPressed: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            LoginBlocProvider.of(context)
                .createUserDataInRealTimeDatabase(nameController.text);
          }
        },
        text: NICK_NAME_BUTTON_LABEL,
      ),
    );
  }
}
