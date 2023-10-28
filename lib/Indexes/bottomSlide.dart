import 'package:flutter/material.dart';

class bottomSlide extends StatelessWidget {
  const bottomSlide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.9,
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(5),
        gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 250, 250, 250),
              Color(0xFF82C3DF),
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Row(
        children: [
          Flexible(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Image.network(
                width: double.infinity,
                // height: double.infinity,
                "https://www.ethiopianairlines.com/images/default-source/default-album/icons/et-logo.png?package=Ethiopian",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
