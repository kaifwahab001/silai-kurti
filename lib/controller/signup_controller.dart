import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:practise/user_register_model.dart';
import 'package:practise/widgets/snackbar_widget.dart';

class SignupController extends GetxController {
  // password visibility
  final  isvisible = false.obs;

  // isverificationsend
  final  isverification = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //Sign up method
  Future<UserCredential?> signupMethod(
    String username,
    String email,
    String password,
    String country,
    String phone,
  ) async {
    try {
      EasyLoading.show(status: 'Loading...');
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      // verification link
      user?.sendEmailVerification();
      // for data store in firestore
      UserModel usermodel = UserModel(
        uId: user!.uid,
        usrname: username,
        email: email,
        password: password,
        phone_number: phone,
        userImg: user.photoURL.toString(),
        deviceToken: '',
        isAdmin: false,
        isActive: true,
        country: country,
        createdon: DateTime.now(),
      );

      await firestore
          .collection('users')
          .doc(user!.uid)
          .set(usermodel.toJson());

      EasyLoading.dismiss();
      isverification.value= true;
      return userCredential;
    } on FirebaseAuthException catch (e) {
      isverification.value = false;
      EasyLoading.dismiss();
      MySnackbar.snackbar('Error', '${e.code}');
    }
  }

  void istoggle(){
    isvisible.value=!isvisible.value;
  }
}
