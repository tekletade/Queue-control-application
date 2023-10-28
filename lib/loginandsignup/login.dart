import 'dart:convert';
//import 'package:Liner/dashboard.dart';
import 'package:flutter/material.dart';
import '../consts/globalcolors.dart';

import 'register.dart';
import 'package:http/http.dart' as http;
import '../home.dart';
import '../Indexes/dashboard.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
import '../consts/globalcolors.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController loginphone = TextEditingController();
  TextEditingController loginpin = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future login() async {
    // var url = Uri.http("emeraldllp.com", '/login.php', {'q': '{https}'});
    var url = Uri.parse('http://192.168.1.84:8050/liner/manage_user.php');
    var response = await http.post(url, body: {
      "loginphone": loginphone.text,
      "loginpin": loginpin.text,
    });
    var data = json.decode(response.body);
    print(data.toString());

    if (data.toString() != "0") {
      String fname = data['fname'];
      String lname = data['lname'];
      String uid = data['uid'];
      String phone = data['phone'];

      print(data[0]);
      FlutterToastr.show("Login Successfully", context,
          duration: FlutterToastr.lengthShort,
          position: FlutterToastr.center,
          backgroundColor: Colors.green);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DashBoard(fname, lname, uid, phone),
        ),
      );
    } else {
      FlutterToastr.show(
        "Phone No. or password invalid",
        context,
        duration: FlutterToastr.lengthShort,
        position: FlutterToastr.center,
        backgroundColor: Colors.green,
      );
    }
  }

  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          // decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //         colors: [Colors.teal.shade200, Colors.purple.shade900])
          //         ),
          child: SingleChildScrollView(
            key: _formKey,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: 100,
                    width: 300,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Color.fromARGB(255, 12, 87, 5),
                          Color.fromARGB(255, 12, 87, 5)
                        ]),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 4,
                              spreadRadius: 3,
                              color: Colors.black12)
                        ],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(100),
                            bottomLeft: Radius.circular(100),
                            bottomRight: Radius.circular(0))),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 35, left: 65),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Welcome',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                      color: Colors.black45,
                                      offset: Offset(1, 1),
                                      blurRadius: 5)
                                ]),
                          ),
                          Text(
                            ' Back!',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: const [
                                  Shadow(
                                      color: Colors.black45,
                                      offset: Offset(1, 1),
                                      blurRadius: 5)
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                Padding(
                  // key: _formKey,
                  padding: const EdgeInsets.symmetric(horizontal: 30)
                      .copyWith(bottom: 10),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "error";
                      }
                    },
                    autofocus: true,
                    controller: loginphone,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 12, 87, 2),
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        prefixIconConstraints:
                            const BoxConstraints(minWidth: 45),
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: Color.fromARGB(255, 12, 87, 5),
                          size: 22,
                        ),
                        border: InputBorder.none,
                        hintText: 'Enter Phone No',
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 12, 87, 5),
                            fontWeight: FontWeight.bold,
                            fontSize: 14.5),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10).copyWith(
                                bottomRight: const Radius.circular(0)),
                            borderSide: const BorderSide(
                                width: 2,
                                color: Color.fromARGB(255, 12, 87, 5))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10).copyWith(
                                bottomRight: const Radius.circular(0)),
                            borderSide: const BorderSide(
                                width: 2,
                                color: Color.fromARGB(255, 19, 170, 5)))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30)
                      .copyWith(bottom: 10),
                  child: TextField(
                    controller: loginpin,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 12, 87, 5),
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold),
                    obscureText: isPasswordVisible ? false : true,
                    decoration: InputDecoration(
                        prefixIconConstraints:
                            const BoxConstraints(minWidth: 45),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Color.fromARGB(255, 12, 87, 5),
                          size: 22,
                        ),
                        suffixIconConstraints:
                            const BoxConstraints(minWidth: 45, maxWidth: 46),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          child: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Color.fromARGB(255, 12, 87, 5),
                            size: 22,
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: 'Enter Pin',
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 12, 87, 5),
                            fontWeight: FontWeight.bold,
                            fontSize: 14.5),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10).copyWith(
                                bottomRight: const Radius.circular(0)),
                            borderSide: const BorderSide(
                                width: 2,
                                color: Color.fromARGB(255, 12, 87, 5))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10).copyWith(
                                bottomRight: const Radius.circular(0)),
                            borderSide: const BorderSide(
                                width: 2,
                                color: Color.fromARGB(255, 19, 170, 5)))),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    // String fname = "fname";
                    // String lname = "lname";
                    // String uid = "uid";
                    // String phone = "phone";
                    login();
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) =>
                    //         BottomNav(fname, lname, uid, phone),
                    //   ),
                    // );
                  },
                  child: Container(
                    height: 53,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 4,
                              color: Colors.black.withOpacity(.2),
                              offset: const Offset(2, 2))
                        ],
                        borderRadius: BorderRadius.circular(100)
                            .copyWith(bottomRight: const Radius.circular(0)),
                        gradient: LinearGradient(colors: [
                          Color.fromARGB(255, 12, 87, 5),
                          Color.fromARGB(255, 12, 87, 5)
                        ])),
                    child: Text('Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: <Widget>[
                    Text('Does not have account?',
                        style: TextStyle(
                          color: brandColor,
                          fontWeight: FontWeight.bold,
                        )),
                    TextButton(
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          color: linkColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      onPressed: () {
                        //signup screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Register()),
                        );
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
