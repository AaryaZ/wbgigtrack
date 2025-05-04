import 'package:flutter/material.dart';
import 'package:gigtrack/auth_services.dart';
import 'package:gigtrack/authscreens/login.dart';
import 'package:gigtrack/authscreens/register.dart';
// import 'package:gigtrack/home.dart';
import 'package:gigtrack/utils/loading.dart';
import 'package:gigtrack/utils/navbar.dart';

class AuthLayout extends StatelessWidget {
  final Widget? pageIfNotConnected;

  const AuthLayout({super.key, this.pageIfNotConnected});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: authService,
      builder: (context, authService, child) {
        return StreamBuilder(
          stream: authService.authStateChanges,
          builder: (context, snapshot) {
            Widget widget;
            if (snapshot.connectionState == ConnectionState.waiting) {
              widget = LoadingPage();
            } else if (snapshot.hasData) {
              widget = Navbar();
            } else {
              widget = pageIfNotConnected ?? const Register();
            }

            return widget;
          },
        );
      },
    );
  }
}
