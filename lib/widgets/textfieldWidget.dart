import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class MyTextFieldform extends StatelessWidget {
  MyTextFieldform({
    super.key,
    required this.controller,
    required this.icon,
    required this.text, required this.keyboardtype,
    this.ontap, this.isvissible=false
  });
  final TextEditingController controller;
  final Icon icon;
  final String text;
  final TextInputType keyboardtype;
  VoidCallback? ontap;
  final bool isvissible;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double heightratio = size.height / 800;
    double widhtratio = size.width / 360;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30 * widhtratio),
      child: TextFormField(
        controller: controller,
        onTapOutside: (event) {
          FocusNode scope = FocusScope.of(context);
          scope.unfocus();
        },
        obscureText: isvissible,
        keyboardType: keyboardtype,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(onTap:ontap,child: icon),
          contentPadding: EdgeInsets.only(
            left: 22 * widhtratio,
            top: 13 * heightratio,
            bottom: 13 * heightratio,
            right: 18 * widhtratio,
          ),
          hintText: text,
          fillColor: Color(0x33C4C4C4),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
