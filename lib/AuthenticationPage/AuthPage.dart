import 'package:flutter/material.dart';

import 'phone.dart';
// import 'InputWrapper.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Color.fromARGB(255, 12, 152, 2),
            Color.fromARGB(255, 12, 152, 2),
            Color.fromARGB(255, 12, 152, 2)
          ]),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            // Header(),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(400),
                    // topRight: Radius.circular(60),
                  )),
              child: MyPhone(),
            ))
          ],
        ),
      ),
    );
  }
}
