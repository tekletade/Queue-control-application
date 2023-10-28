import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import 'package:http/http.dart' as http;
import '../defaultPage.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController phone = TextEditingController();
  TextEditingController fname = TextEditingController();

  TextEditingController lname = TextEditingController();

  Future register() async {
    // var url = Uri.http("www.emeraldllp.com", '/register.php', {'q': '{http}'});
    var url = Uri.parse("http://192.168.1.84:8050/liner/manage_user.php");
    var response = await http.post(url, body: {
      "phone": phone.text.toString(),
      "fname": fname.text.toString(),
      "lname": lname.text.toString(),
    });
    print("$response");
    var data = json.decode(response.body);

    if (data == "Error") {
      // Fluttertoast.showToast(
      //   backgroundColor: Color.fromARGB(255, 3, 102, 8),
      //   textColor: Colors.white,
      //   msg: 'User already exit!',
      //   toastLength: Toast.LENGTH_SHORT,
      // );
      FlutterToastr.show(
        "User already exit!",
        context,
        duration: FlutterToastr.lengthShort,
        position: FlutterToastr.bottom,
      );
    } else {
      FlutterToastr.show("Registered Successfully", context,
          duration: FlutterToastr.lengthShort, position: FlutterToastr.bottom);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
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
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 233, 232, 235),
            Color.fromARGB(255, 255, 254, 254),
            Color.fromARGB(255, 255, 254, 254),
            Color.fromARGB(255, 2, 109, 10)
          ])),
          child: SingleChildScrollView(
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
                            bottomLeft: Radius.circular(100))),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 35, left: 65),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Let\'s',
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
                            ' Register',
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
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30)
                      .copyWith(bottom: 10),
                  child: TextFormField(
                    validator: Validators.compose([
                      Validators.required('Phone required'),
                      Validators.minLength(9, 'Phone number digits are 9'),
                    ]),
                    controller: phone,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 12, 87, 5),
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        prefixIconConstraints:
                            const BoxConstraints(minWidth: 45),
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: Color.fromARGB(255, 12, 87, 5),
                          size: 25,
                        ),
                        border: InputBorder.none,
                        hintText: 'Enter Phone No',
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 12, 87, 5),
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
                                color: Color.fromARGB(255, 23, 200, 7)))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30)
                      .copyWith(bottom: 10),
                  child: TextFormField(
                    validator: Validators.compose([
                      Validators.required('Firest name required'),
                      // Validators.minLength(9, 'Phone number required digits are 9'),
                    ]),
                    controller: fname,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 12, 87, 5),
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        prefixIconConstraints:
                            const BoxConstraints(minWidth: 45),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Color.fromARGB(255, 12, 87, 5),
                          size: 25,
                        ),
                        border: InputBorder.none,
                        hintText: 'Enter First Name',
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 12, 87, 5),
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
                                color: Color.fromARGB(255, 23, 200, 7)))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30)
                      .copyWith(bottom: 10),
                  child: TextFormField(
                    validator: Validators.compose([
                      Validators.required('Last Name'),
                      // Validators.minLength(9, 'e 9'),
                    ]),
                    controller: lname,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 12, 87, 5),
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        prefixIconConstraints:
                            const BoxConstraints(minWidth: 45),
                        prefixIcon: const Icon(
                          Icons.person_add,
                          color: Color.fromARGB(255, 12, 87, 5),
                          size: 25,
                        ),
                        border: InputBorder.none,
                        hintText: 'Enter Phone No',
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 12, 87, 5),
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
                                color: Color.fromARGB(255, 23, 200, 7)))),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    register();
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
                              color: Colors.black12.withOpacity(.2),
                              offset: const Offset(2, 2))
                        ],
                        borderRadius: BorderRadius.circular(100)
                            .copyWith(bottomRight: const Radius.circular(0)),
                        gradient: LinearGradient(colors: [
                          Color.fromARGB(255, 12, 87, 5),
                          Color.fromARGB(255, 12, 87, 5)
                        ])),
                    child: Text('Signup',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: <Widget>[
                    const Text('Already have an account?',
                        style: TextStyle(
                          color: Color.fromARGB(255, 12, 87, 5),
                          fontWeight: FontWeight.bold,
                        )),
                    TextButton(
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Color.fromARGB(255, 1, 98, 177),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      onPressed: () {
                        //signup screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => const MyHomePage()),
                //     );
                //   },
                //   child: Container(
                //     height: 53,
                //     width: double.infinity,
                //     margin: const EdgeInsets.symmetric(horizontal: 30),
                //     alignment: Alignment.center,
                //     decoration: BoxDecoration(
                //       border: Border.all(color: Colors.white60),
                //       borderRadius: BorderRadius.circular(100)
                //           .copyWith(bottomRight: const Radius.circular(0)),
                //     ),
                //     child: Text('Login',
                //         style: TextStyle(
                //             color: Colors.white.withOpacity(.8),
                //             fontSize: 15,
                //             fontWeight: FontWeight.bold)),
                //   ),
                // ),
                // const SizedBox(
                //   height: 20,
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
