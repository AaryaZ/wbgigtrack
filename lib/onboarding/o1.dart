import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class O1 extends StatelessWidget {
  const O1({super.key});

  @override
  Widget build(BuildContext context) {
    var GlobalHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.from(
        alpha: 0.992,
        red: 0.922,
        green: 0.925,
        blue: 0.933,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: GlobalHeight * 0.25,
              left: 2,
              right: 2,
            ),
            child: Lottie.asset('assets/anims/Animation - 1746159117754.json'),
          ),
        ],
      ),
    );
  }
}
