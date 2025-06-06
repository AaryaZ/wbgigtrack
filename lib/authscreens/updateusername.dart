import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gigtrack/firebaseservices/auth_services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Updateusername extends StatefulWidget {
  const Updateusername({super.key});

  @override
  State<Updateusername> createState() => _UpdateusernameState();
}

class _UpdateusernameState extends State<Updateusername> {
  final TextEditingController _usernameController = TextEditingController();

  String? usernameError;
  String? errorMessage = '';

  void updateusername() async {
    String username = _usernameController.text.trim();

    if (username.isEmpty) {
      setState(() {
        errorMessage = "Username field is required";
      });
      return;
    }
    try {
      await authService.value.updateUserName(username: username);
      customshowsnackbar();
      setState(() {
        errorMessage = '';
      });
      popPage();
    } on FirebaseAuthException catch (e) {
      customshowsnackbarfailure();
      setState(() {
        errorMessage = e.message ?? 'An error occurred.This is not working.';
      });
    }
  }

  void customshowsnackbarfailure() {
    ScaffoldMessenger.of(context).clearMaterialBanners();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red[100],
        content: Text(
          'An error occured. Please try again.',
          style: TextStyle(color: Colors.red[900]),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void customshowsnackbar() {
    ScaffoldMessenger.of(context).clearMaterialBanners();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green[300],
        content: Text(
          'Username updated successfully. This may take a while.',
          style: TextStyle(color: const Color.fromRGBO(19, 77, 25, 1)),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void popPage() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 1),
            Text(
              "Update Username",
              style: GoogleFonts.nunitoSans(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 2, right: 2),
              child: Lottie.asset('assets/anims/resetpassword.json'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "New Username",
                      errorText: usernameError,
                    ),
                  ),
                ),
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
                onTap: updateusername,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      "Update",
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
