import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'consts/globalcolors.dart';
//import 'dashboard.dart';
import 'home.dart';
import 'curve.dart';
import 'loginandsignup/login.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class DefaultPage extends StatefulWidget {
  const DefaultPage({Key? key}) : super(key: key);

  @override
  State<DefaultPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DefaultPage> {
  bool isFinished = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: const Text("Get InLine Now!"),
      // ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // const Image(
          //   image: AssetImage('images/22.JPG'),
          //   // height: 200,
          //   fit: BoxFit.cover,
          //   height: double.infinity,
          //   width: double.infinity,
          // ),
          CurvePage(),
          // Image.asset(
          //   "images/22.JPG",
          //   fit: BoxFit.cover,
          //   height: double.infinity,
          //   width: double.infinity,
          // ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
              child: SwipeableButtonView(
                  buttonText: "Swipe to Start",
                  buttonWidget: Container(
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: brandColor,
                    ),
                  ),
                  activeColor: Color.fromARGB(255, 1, 94, 73),
                  isFinished: isFinished,
                  onWaitingProcess: () {
                    Future.delayed(Duration(seconds: 0), () {
                      setState(() {
                        isFinished = true;
                      });
                    });
                  },
                  onFinish: () async {
                    await Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: Login()));

                    setState(() {
                      isFinished = false;
                    });
                  }))
        ],
      ),
    );
  }
}
