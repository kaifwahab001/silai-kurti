import 'package:flutter/cupertino.dart';

class AppkeyboardManager{
  static appkeyboadmanager(BuildContext context){
    FocusScopeNode scope = FocusScope.of(context);
    if(!scope.hasPrimaryFocus){
      scope.unfocus();
    }
  }
}