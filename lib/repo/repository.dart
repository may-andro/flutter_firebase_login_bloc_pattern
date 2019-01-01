import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class Repository {

  //This method is used to get the current FirebaseUser instance
  Future<FirebaseUser> getCurrentFirebaseUser() async {
    return await FirebaseAuth.instance.currentUser();
  }

  Future logOutUser()  async{
    await FirebaseAuth.instance.signOut();
  }
}
