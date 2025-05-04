import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:gigtrack/auth_layout.dart';
import 'package:gigtrack/onboarding/o1.dart';
import 'package:gigtrack/onboarding/o2.dart';
import 'package:gigtrack/onboarding/o3.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Color dblue = const Color.fromARGB(255, 16, 49, 140);
Color bgblue = const Color.fromARGB(253, 232, 234, 240);

//  colors: [
//             Colors.grey[200]!,
//             Colors.grey[400]!,
//           ],

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  PageController _controller = PageController();

  // if on last page
  bool onLastPage = false;
  String T1 = "Stay on top of your tasks";
  String T2 = "Organize everything in one place and get more done.";
  String T3 = "Next";

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const AuthLayout()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    var GlobalHeight = MediaQuery.of(context).size.height;
    var GlobalWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
                T1 =
                    (index == 2)
                        ? "Plan your day with ease"
                        : (index == 1)
                        ? "Build better habits"
                        : "Stay on top of your tasks";
                T2 =
                    (index == 2)
                        ? "Stay focused, hit deadlines, and feel accomplished."
                        : (index == 1)
                        ? "Set goals, track progress, and improve every day."
                        : "Organize everything in one place and get more done.";
                T3 = (index == 2) ? "Get Started" : "Next";
              });
            },
            children: [O1(), O2(), O3()],
          ),
          //bottom
          Container(
            alignment: Alignment(0, -0.8),
            child: SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: SwapEffect(
                activeDotColor: Colors.black,
                dotColor: Colors.black26,
                dotHeight: 10,
                dotWidth: 30,
              ),
            ),
          ),
          Container(
            height: GlobalHeight * 0.35,
            width: double.maxFinite,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40.0),
                topLeft: Radius.circular(40.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: GlobalHeight * 0.3 * 0.15,
                    left: GlobalWidth * 0.1,
                    right: GlobalWidth * 0.1,
                    bottom: GlobalHeight * 0.3 * 0.01,
                  ),
                  child: FittedBox(
                    child: Text(
                      T1,
                      maxLines: 3,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: GlobalWidth * 0.1,
                    right: GlobalWidth * 0.1,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      T2,
                      style: GoogleFonts.inter(
                        color: Colors.grey[400],
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                // Button
                Padding(
                  padding: EdgeInsets.only(
                    top: GlobalHeight * 0.3 * 0.2,
                    bottom: GlobalHeight * 0.3 * 0.1,
                    left: GlobalWidth * 0.15,
                    right: GlobalWidth * 0.15,
                  ),
                  child: AvatarGlow(
                    glowRadiusFactor: 1,
                    duration: Duration(milliseconds: 2000),
                    glowColor: Colors.blueGrey,
                    child: GestureDetector(
                      onTap: () {
                        if (onLastPage) {
                          _completeOnboarding(); // ✅ Navigate to AuthLayout after saving preference
                        } else {
                          _controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                      child: Container(
                        width:
                            GlobalWidth *
                            0.7, // Adjust the width here (e.g., GlobalWidth * 0.8)
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Text(
                          T3,
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
