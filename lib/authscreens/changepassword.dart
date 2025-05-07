import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gigtrack/firebaseservices/auth_services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Changepw extends StatefulWidget {
  const Changepw({super.key});

  @override
  State<Changepw> createState() => _ChangepwState();
}

class _ChangepwState extends State<Changepw> with TickerProviderStateMixin {
  double turns = 0;
  bool isClicked = false;
  late AnimationController _animcontroller;
  Color myblack = const Color.fromARGB(255, 53, 53, 53);
  Color mywhite = Colors.grey[300]!;

  @override
  void initState() {
    _animcontroller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    // Add listeners to FocusNodes
    _emailFocusNode.addListener(() {
      if (_emailFocusNode.hasFocus) {
        triggerAnimation();
      }
    });
    _curpasswordFocusNode.addListener(() {
      if (_curpasswordFocusNode.hasFocus) {
        triggerAnimation();
      }
    });
    _newpasswordFocusNode.addListener(() {
      if (_newpasswordFocusNode.hasFocus) {
        triggerAnimation();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _curpasswordController.dispose();
    _newpasswordController.dispose();
    _animcontroller.dispose();

    // Dispose FocusNodes
    _emailFocusNode.dispose();
    _curpasswordFocusNode.dispose();
    _newpasswordFocusNode.dispose();
    super.dispose();
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _curpasswordController = TextEditingController();
  final TextEditingController _newpasswordController = TextEditingController();

  // FocusNodes for TextFields
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _curpasswordFocusNode = FocusNode();
  final FocusNode _newpasswordFocusNode = FocusNode();

  String? emailError;
  String? passwordError;
  String? errorMessage = '';

  void changepw() async {
    setState(() {
      errorMessage = null;
    });

    String email = _emailController.text.trim();
    String curpassword = _curpasswordController.text.trim();
    String newPassword = _newpasswordController.text.trim();

    if (email.isEmpty || curpassword.isEmpty || newPassword.isEmpty) {
      setState(() {
        errorMessage = "All fields are required";
      });
      return;
    }

    if (curpassword == newPassword) {
      setState(() {
        errorMessage = "New password cannot be same as current password.";
      });
      return;
    }

    try {
      await authService.value.resetPasswordFromCurrentPassword(
        email: email,
        currentPassword: curpassword,
        newPassword: newPassword,
      );
      customshowsnackbarsuccess();
      popPage();
    } on FirebaseAuthException catch (e) {
      customshowsnackbarfailure();
      setState(() {
        errorMessage = e.message ?? 'An error occurred';
      });
    }
  }

  void popPage() {
    Navigator.pop(context);
  }

  void customshowsnackbarfailure() {
    ScaffoldMessenger.of(context).clearMaterialBanners();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red[100],
        content: Text(
          'Password change failed. Please try again.',
          style: TextStyle(color: Colors.red[900]),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void customshowsnackbarsuccess() {
    ScaffoldMessenger.of(context).clearMaterialBanners();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green[300],
        content: Text(
          'Password updated successfully.',
          style: TextStyle(color: const Color.fromRGBO(19, 77, 25, 1)),
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void triggerAnimation() {
    if (isClicked) {
      setState(() => turns -= 0.5);
      _animcontroller.reverse();
    } else {
      setState(() => turns += 0.5);
      _animcontroller.forward();
    }
    isClicked = !isClicked;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mywhite,
      body: Center(
        child: Column(
          children: [
            Spacer(flex: 1),

            AnimatedRotation(
              turns: turns,
              curve: Curves.easeInCubic,
              duration: Duration(seconds: 1),
              child: AnimatedContainer(
                duration: Duration(seconds: 1),
                curve: Curves.easeInCubic,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade600,
                      offset:
                          isClicked
                              ? const Offset(-20, -20)
                              : const Offset(20, 20),

                      blurRadius: 30,
                      // spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: Colors.grey.shade50,
                      offset:
                          isClicked
                              ? const Offset(20, 20)
                              : const Offset(-20, -20),
                      blurRadius: 30,
                      // spreadRadius: 1,
                    ),
                  ],
                ),
                child: SizedBox(
                  height: 120,
                  width: 120,
                  child: Center(
                    child: Lottie.asset(
                      'assets/anims/abstract.json',
                      controller: _animcontroller,
                      repeat: true,
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            Text(
              "Change your Password",
              style: GoogleFonts.nunitoSans(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            Spacer(flex: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                          errorText: emailError,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextField(
                        controller: _curpasswordController,
                        focusNode: _curpasswordFocusNode,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Current Password",
                          errorText: passwordError,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextField(
                        controller: _newpasswordController,
                        focusNode: _newpasswordFocusNode,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "New Password",
                          errorText: passwordError,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                errorMessage ?? "",
                style: const TextStyle(color: Colors.redAccent),
                softWrap: true,
              ),
            ),
            Spacer(flex: 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: GestureDetector(
                onTap: changepw,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      "Change Password",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
