import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:practise/controller/get_userdata_controller.dart';
import 'package:practise/controller/login_controller.dart';
import 'package:practise/screens/admin_screen/admin_main_screen.dart';
import 'package:practise/screens/auth/register_screen.dart';
import 'package:practise/screens/user_screen/user_main_screen.dart';
import 'package:practise/utils/appconstants.dart';
import 'package:practise/widgets/snackbar_widget.dart';
import 'package:practise/widgets/textfieldWidget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailcontroller = TextEditingController();
    TextEditingController passwordcontroller = TextEditingController();

    final LoginController controller = Get.put(LoginController());
    final GetUserDatController getusercontroller = Get.put(GetUserDatController());


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolor.appprimaryColor,
        title: Text('Login account'),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 30),
              alignment: AlignmentDirectional.centerEnd,
              child: Image.asset('assets/images/login-logo.png'),
            ),

            MyTextFieldform(
              ontap: () {
                // nothing here to control
              },
              controller: emailcontroller,
              icon: Icon(Icons.email_outlined),
              text: 'Email',
              keyboardtype: TextInputType.emailAddress,
            ),
            SizedBox(height: 30),
            Obx(()=>MyTextFieldform(
              ontap: () {
                // for eye
                controller.istoggle();
              },
              controller: passwordcontroller,
              icon: controller.isvisible.value?Icon(CupertinoIcons.eye):Icon(CupertinoIcons.eye_slash),
              isvissible: controller.isvisible.value,
              text: 'Password',
              keyboardtype: TextInputType.visiblePassword,
            )),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Appcolor.appprimaryColor),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(child: Container()),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(300, 50),
                foregroundColor: Colors.white,
                backgroundColor: Appcolor.appprimaryColor,
              ),
              onPressed: () async{
                // for login
                final String email = emailcontroller.text.trim();
                final  String passoword =passwordcontroller.text;
                if(email.isEmpty||passoword.isEmpty){
                  MySnackbar.snackbar(
                    'Null Values',
                    'Please fill all the above details',
                  );
                }else{
                  UserCredential? usercred = await controller.loginMethod(email, passoword);
                  var userData = await getusercontroller.getData(usercred!.user!.uid);
                  print(userData);
                  if(usercred!=null){
                    if(usercred.user!.emailVerified){
                      if(userData.isNotEmpty&&userData[0]['isAdmin']==true){
                        MySnackbar.snackbar(
                          'Successful',
                          'Login success as Admin',
                        );
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminMain_Screen(),));
                      }else{
                        MySnackbar.snackbar(
                          'Successful',
                          'Login successful',
                        );
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserMain_Screen(),));
                      }



                    }else{
                      MySnackbar.snackbar(
                        'Email not verified',
                        'Please verified email before login',
                      );
                    }
                  }else{
                    MySnackbar.snackbar(
                      'Login error',
                      'Please check email and password',
                    );
                  }
                }
              },
              child: Text("Login",style: TextStyle(fontSize: 20),),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account ? "),
                TextButton(
                  onPressed: () {
                    //for register screen
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisteScreen(),));
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(color: Appcolor.appprimaryColor,fontSize: 14),
                  ),
                ),
              ],
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
