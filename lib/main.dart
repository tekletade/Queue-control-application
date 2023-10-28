import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
// import 'package:swip/dashboard.dart';
import 'AuthenticationPage/AuthPage.dart';
import 'AuthenticationPage/phone.dart';
import 'AuthenticationPage/verify.dart';
import 'defaultPage.dart';
// import 'loginandsignup/login.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

void main() {
  runApp(new MaterialApp(
    // initialRoute: 'phone',
    debugShowCheckedModeBanner: false,
    //I session is True Home:DefaultPage else if no session AuthPage
    home: DefaultPage(),
    // home: DashBoard(),

    // routes: {
    //   'phone': (context) => MyPhone(),
    //   'verify': (context) => MyVerify()
    // },
  ));
}
