import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class O3 extends StatelessWidget {
  const O3({super.key});

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
              top: GlobalHeight * 0.15,
              left: 2,
              right: 2,
            ),
            child: Lottie.asset('assets/anims/Animation - 1714570009774.json'),
          ),
        ],
      ),
    );
  }
}
