import 'package:complete_commerce_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  Auth._();
  static final Auth auth = Auth._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences prefs;
  Future<SharedPreferences> instializeSp() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
      return prefs;
    } else {
      return prefs;
    }
  }

  createNewUserUsingEmailAndPassword(String email, String password) async {
    try {
      prefs = await instializeSp();
      AuthResult authResult = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = authResult.user;
      if (user != null) {
        prefs.setString(spUserName, user.displayName ?? '');
        prefs.setString(userId, user.uid);
        prefs.setBool(isLogged, true);
      }
    } catch (error) {
      print(error);
    }
  }

  signInUsingEmailAndPassword(String email, String password) async {
    try {
      prefs = await instializeSp();
      AuthResult authResult = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = authResult.user;
      if (user != null) {
        prefs.setString(spUserName, user.displayName ?? '');
        prefs.setString(userId, user.uid);
        prefs.setBool(isLogged, true);
      }
    } catch (error) {
      print(error);
    }
  }

  signOut() async {
    try {
      prefs = await instializeSp();
      await firebaseAuth.signOut();
      prefs.setString(spUserName, '');
      prefs.setString(userId, '');
      prefs.setBool(isLogged, false);
    } catch (error) {
      print(error);
    }
  }

  Future<bool> checkUser() async {
    try {
      prefs = await instializeSp();
      bool isLoggedUser = prefs.getBool(isLogged);
      return isLoggedUser;
    } catch (error) {
      print(error);
    }
  }
}
