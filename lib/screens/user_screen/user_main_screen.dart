import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practise/controller/login_controller.dart';
import 'package:practise/screens/auth/register_screen.dart';
import 'package:practise/utils/appconstants.dart';
import 'package:practise/widgets/textfieldWidget.dart';

class UserMain_Screen extends StatelessWidget {
  const UserMain_Screen({super.key});

  @override
  Widget build(BuildContext context) {
LoginController controller = LoginController();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
            controller.logout(context);
          }, icon: Icon(Icons.exit_to_app))
        ],
        backgroundColor: Appcolor.appprimaryColor,
        title: Text('User'),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('User')
          ],
        ),
      ),
    );
  }
}
