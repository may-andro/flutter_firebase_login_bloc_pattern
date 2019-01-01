import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_screen/ui/onboarding/bloc/login_bloc_provider.dart';
import 'package:flutter_login_screen/ui/onboarding/component/onboarding_header_text.dart';
import 'package:flutter_login_screen/utils/text_constant.dart';

class AllSetTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: _buildScrollPage(context));
  }

  Widget _buildScrollPage(BuildContext context) {
    final name = LoginBlocProvider.of(context).getName();
    return NestedScrollView(
      body: _buildBody(context),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
              expandedHeight: 150.0,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              forceElevated: innerBoxIsScrolled,
              flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background:  OnBoardingHeaderText(text: '$ALL_SET_LABEL1 $name $ALL_SET_LABEL2')
              )
          ),
        ];
      },
    );
  }

  Widget _buildBody(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 24.0,),
          _buildLabel1(context, ALL_SET_LABEL3),
          SizedBox(height: 24.0,),
          _buildLabel2(context, ALL_SET_LABEL4),
          SizedBox(height: 48.0,),
          CircularProgressIndicator()
        ],
      ),
    );
  }

  Widget _buildLabel1(BuildContext context, String text) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
      child: AutoSizeText(
        text,
        style: Theme.of(context).textTheme.title.copyWith(
            color: Colors.black54,
            letterSpacing: 1.0,
            fontWeight: FontWeight.w300),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildLabel2(BuildContext context, String text) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
      child: AutoSizeText(
        text,
        style: Theme.of(context).textTheme.title.copyWith(
            color: Colors.black.withAlpha(135),
            letterSpacing: 1.2,
            fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      ),
    );
  }
}
