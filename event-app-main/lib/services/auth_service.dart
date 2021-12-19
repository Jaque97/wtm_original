import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/app/static_info.dart';
import 'package:event_app/models/user_model.dart';
import 'package:event_app/view/ui/login/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

class AuthStatus {
  static const String ERROR_WEAK_PASSWORD = 'weak-password';
  static const String ERROR_INVALID_EMAIL = 'invalid-email';
  static const String ERROR_EMAIL_ALREADY_IN_USE = 'email-already-in-use';
  static const String ERROR_WRONG_PASSWORD = 'ERROR_WRONG_PASSWORD';
  static const String ERROR_USER_NOT_FOUND = 'user-not-found';
}

@lazySingleton
class AuthService {
  final _usersKey = 'users';

  Future<String> signUp(UserModel user, String password) async {
    try {
      var authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: user.email, password: password);
      user.id = authResult.user.uid;
      var saveResult = await saveUser(user);
      if (saveResult != "success") return saveResult;
      StaticInfo.userModel = user;
      return "success";
    } catch (error) {
      print("error in SigningUp the user : ${error.code}");
      return "${error.code}";
    }
  }

  Future<String> login(String email, String password) async {
    try {
      var responseToBeReturned;
      var authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      var response = await getUser(authResult.user.uid);
      if (response != null) {
        responseToBeReturned = "success";
      } else {
        responseToBeReturned = "fail";
      }
      return responseToBeReturned;
    } catch (error) {
      print("Erro in logging the user : ${error?.message}//////");
      return "${error?.code}";
    }
  }

  Future<dynamic> getCurrentUser() async {
    var result = FirebaseAuth.instance.currentUser;
    var responseToBerReturned;
    if (result == null) {
      responseToBerReturned = false;
    } else {
      var response = await getUser(result.uid);
      print(response);
      if (response != null) {
        responseToBerReturned = true;
      } else {
        print("returning fill details");
        responseToBerReturned = "fill details";
      }
    }
    print(responseToBerReturned);
    return responseToBerReturned;
  }

  Future<String> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      return "success";
    } catch (err) {
      return err.code;
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    StaticInfo.userModel = null;
    Get.offAll(() => LoginView());
  }

  Future<String> saveUser(UserModel user) async {
    try {
      await FirebaseFirestore.instance
          .collection(_usersKey)
          .doc(user.id)
          .set(user.toMap(), SetOptions(merge: true));
      return "success";
    } catch (e) {
      print("error in Saving user");

      return e;
    }
  }

  Future<dynamic> getUser(String uid) async {
    try {
      StaticInfo.userModel = UserModel.fromMap((await FirebaseFirestore.instance
              .collection(_usersKey)
              .doc(uid)
              .get())
          .data());
      return StaticInfo.userModel;
    } catch (e) {
      print("Error in assigning static info :$e");
      return e;
    }
  }
}
