import 'package:flutter/material.dart';

// import 'Header.dart';
// import 'InputWrapper.dart';

class CurvePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Color.fromARGB(255, 2, 87, 5),
            Color.fromARGB(255, 2, 87, 5),
            Color.fromARGB(255, 2, 87, 5)
          ]),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            // Header(),

            Expanded(
              child: Container(
                constraints: BoxConstraints.expand(),
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/12.png"), fit: BoxFit.cover),
                    // color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(400),
                      topRight: Radius.circular(0),
                      // bottomLeft: Radius.circular(400),
                      bottomRight: Radius.circular(400),
                    )),
                // child: InputWrapper(),

                // child: const Text(
                //   '\n        Get InLine Now!',
                //   style: TextStyle(
                //       fontSize: 34,
                //       color: Colors.white,
                //       fontWeight: FontWeight.bold),

                // ),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: '\n\n      Get',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: ' In',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: ' Line Now',
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                        text:
                            '\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n Easy and Quick to Travel\n  anywhere at anytime',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            // textAlign: TextAlign.center,
                            fontWeight: FontWeight.bold)),
                  ]),
                ),
                // child: Column(children: <Widget>[
                //   // child: Center(
                //   RichText(
                //     text: TextSpan(children: [
                //       TextSpan(
                //           text: 'Get',
                //           style: TextStyle(
                //               color: Color.fromARGB(255, 255, 255, 255),
                //               fontSize: 34,
                //               fontWeight: FontWeight.bold)),
                //       TextSpan(
                //           text: ' In',
                //           style: TextStyle(
                //               color: Colors.black,
                //               fontSize: 34,
                //               fontWeight: FontWeight.bold)),
                //       TextSpan(
                //           text: ' Line Now',
                //           style: TextStyle(
                //               color: Colors.black,
                //               fontSize: 34,
                //               fontWeight: FontWeight.bold)),
                //     ]),
                //   ),
                // ]),

                //   const Text(
                //     '\nGet InLine Now!',
                //     style: TextStyle(
                //         fontSize: 34,
                //         color: Colors.white,
                //         fontWeight: FontWeight.bold),
                //   ),
                //   SizedBox(
                //     height: 300,
                //   ),
                //   const Text(
                //     '\n        Easy and Quick toTravel anywhere at anytime',
                //     style: TextStyle(
                //         fontSize: 20,
                //         color: Color.fromARGB(255, 255, 255, 255),
                //         fontWeight: FontWeight.bold),
                //   ),
                // ]),

                //   Row(
                //     children: <Widget>[
                // SizedBox(
                //   height: 100,
                // ),
                // const Text(
                //   'Get InLine Now',
                //   style:
                //       TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                // ),
                // const Image(
                //   image: AssetImage('images/22.JPG'),
                //   // height: 500,
                //   fit: BoxFit.cover,
                //   height: double.infinity,
                //   width: double.infinity,
                // ),
                // Container(
                //   constraints: BoxConstraints.expand(),
                //   decoration: const BoxDecoration(
                //     image: DecorationImage(
                //         image: AssetImage("images/22.JPG"),
                //         fit: BoxFit.cover),
                //   ),
                //   child: const Text(
                //     'Image in fullscreen',
                //     style: TextStyle(fontSize: 34, color: Colors.red),
                //   ),
                // ),

                // Image.asset(
                //   "images/22.JPG",
                //   height: 200,
                //   fit: BoxFit.cover,
                //   height: double.infinity,
                //   width: double.infinity,
                // ),
                //   ],
                //   // mainAxisAlignment: MainAxisAlignment.center,
                // ),
                // Image.asset(
                //   'images/22.JPG',
                //   fit: BoxFit.cover,
                //   height: double.infinity,
                //   width: double.infinity,
                // ),
                // Padding(padding: EdgeInsets.all(0)),
                // const Image(
                //   image: AssetImage('images/22.JPG'),
                //   height: 200,
                // ),
                // SizedBox(
                //   height: 30,
                // ),
                // const Text(
                //   'Easy and Quick to Travel \nanywhere and anytime',
                //   style: TextStyle(
                //       fontSize: 20,
                //       color: Color.fromARGB(255, 2, 63, 4),
                //       fontWeight: FontWeight.bold),
                // ),
                // ]),
              ),
            ),
            // SizedBox(
            //   height: 50,
            // ),

            // const Text(
            //   'SWIPE to start!',
            //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            // ),
            // const Image(
            //   image: NetworkImage(
            //       'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
            // ),
            // const Image(image: AssetImage('images/22.JPG'))
          ],
        ),
      ),
    );
  }
}
