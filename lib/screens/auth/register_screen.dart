import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:practise/controller/signup_controller.dart';
import 'package:practise/utils/appconstants.dart';
import 'package:practise/widgets/snackbar_widget.dart';
import 'package:practise/widgets/textfieldWidget.dart';

class RegisteScreen extends StatefulWidget {
  const RegisteScreen({super.key});

  @override
  State<RegisteScreen> createState() => _RegisteScreenState();
}

class _RegisteScreenState extends State<RegisteScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController countrycontroller = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final SignupController conroller = Get.put(SignupController());

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    phonecontroller.dispose();
    usernamecontroller.dispose();
    countrycontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolor.appprimaryColor,
        leading: IconButton(onPressed: () {
            Navigator.pop(context);
          conroller.isverification.value = false;
        }, icon: Icon(CupertinoIcons.left_chevron)),
        title: Text('Sign Up'),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Obx(
              () => Container(
                width: double.infinity,
                child:
                    conroller.isverification.value
                        ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Email Sent', textAlign: TextAlign.center),
                          ],
                        )
                        : Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 30),
                              alignment: AlignmentDirectional.centerEnd,
                              child: Image.asset(
                                'assets/images/login-logo.png',
                              ),
                            ),
                            SizedBox(height: 30),
                            MyTextFieldform(
                              ontap: () {
                                // nothing here to control
                              },
                              controller: usernamecontroller,
                              icon: Icon(CupertinoIcons.person),
                              text: 'User name',
                              keyboardtype: TextInputType.text,
                            ),
                            SizedBox(height: 30),
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
                            MyTextFieldform(
                              ontap: () {
                                // nothing here to control
                              },
                              controller: phonecontroller,
                              icon: Icon(CupertinoIcons.phone),
                              text: 'Phone number',
                              keyboardtype: TextInputType.number,
                            ),
                            SizedBox(height: 30),
                            Obx(()=>MyTextFieldform(
                              ontap: () {
                                // for eye
                                conroller.istoggle();
                              },
                              controller: passwordcontroller,
                              icon: conroller.isvisible.value?Icon(CupertinoIcons.eye):Icon(CupertinoIcons.eye_slash),
                              isvissible: conroller.isvisible.value,
                              text: 'Password',
                              keyboardtype: TextInputType.visiblePassword,
                            )),
                            SizedBox(height: 30),
                            MyTextFieldform(
                              ontap: () {
                                // for eye
                              },
                              controller: countrycontroller,
                              icon: Icon(CupertinoIcons.location),
                              isvissible: false,
                              text: 'Country',
                              keyboardtype: TextInputType.text,
                            ),
                            SizedBox(height: 10),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                            //     Padding(
                            //       padding: const EdgeInsets.only(right: 40),
                            //       child: TextButton(
                            //         onPressed: () {},
                            //         child: Text(
                            //           'Forgot Password?',
                            //           style: TextStyle(color: Appcolor.appprimaryColor),
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            SizedBox(height: 50),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(300, 50),
                                foregroundColor: Colors.white,
                                backgroundColor: Appcolor.appprimaryColor,
                              ),
                              onPressed: () async {
                                // for signup
                                final String username = usernamecontroller.text;
                                final String email = emailcontroller.text.trim();
                                final String phone = phonecontroller.text;
                                final String password = passwordcontroller.text;
                                final String country = countrycontroller.text;
                                if (username.isEmpty ||
                                    email.isEmpty ||
                                    phone.isEmpty ||
                                    password.isEmpty ||
                                    country.isEmpty) {
                                  MySnackbar.snackbar(
                                    'Null Values',
                                    'Please fill all the above details',
                                  );
                                } else {
                                  UserCredential? userdata = await conroller
                                      .signupMethod(
                                        username,
                                        email,
                                        password,
                                        country,
                                        phone,
                                      );

                                  if (userdata != null) {
                                    MySnackbar.snackbar(
                                      'Successful',
                                      'verification email sent',
                                    );
                                  }
                                }
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Have an account ?"),
                                TextButton(
                                  onPressed: () {
                                    //
                                  },
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Appcolor.appprimaryColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
              ),
            ),
          );
        },
      ),
    );
  }
}
