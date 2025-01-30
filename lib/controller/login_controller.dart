import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:practise/user_register_model.dart';
import 'package:practise/widgets/snackbar_widget.dart';

import '../screens/auth/login_screen.dart';

class LoginController extends GetxController {
  // password visibility
  final isvisible = true.obs;

  // isverificationsen

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //Sign up method
  Future<UserCredential?> loginMethod(String email, String password) async {
    try {
      EasyLoading.show(status: 'Loading...');
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);

      EasyLoading.dismiss();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
    }
  }


   Future<void> logout(BuildContext context) async {
    try {
      EasyLoading.show(status: 'Loading...');
      await _auth.signOut();

      EasyLoading.dismiss();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      MySnackbar.snackbar('Error', '${e.code}');
    }
  }


  void istoggle(){
    isvisible.value =! isvisible.value;
  }
}
