import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:practise/controller/get_userdata_controller.dart';
import 'package:practise/screens/admin_screen/admin_main_screen.dart';
import 'package:practise/screens/auth/login_screen.dart';
import 'package:practise/screens/user_screen/user_main_screen.dart';
import 'package:practise/utils/appconstants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  final GetUserDatController controller = Get.put(GetUserDatController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), () {
      currentpage();
    });
  }

  Future<void> currentpage() async {
    try {
      var userdata = await controller.getData(user!.uid);

      if (userdata[0]['isAdmin'] == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminMain_Screen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UserMain_Screen()),
        );
      }
    } catch (e) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Appcolor.appprimaryColor),
      backgroundColor: Appcolor.appprimaryColor,
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,

        child: Center(child: Image.asset('assets/images/logo.png')),
      ),
    );
  }
}
