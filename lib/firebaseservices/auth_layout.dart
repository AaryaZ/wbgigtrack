import 'package:flutter/material.dart';
import 'package:gigtrack/firebaseservices/auth_services.dart';
import 'package:gigtrack/authscreens/register.dart';
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
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingPage();
            }

            // User is cached locally
            if (snapshot.hasData && snapshot.data != null) {
              final user = snapshot.data;

              // Now we verify if the user still exists on the backend
              return FutureBuilder(
                future: user!.reload().then((_) => authService.currentUser),
                builder: (context, futureSnapshot) {
                  if (futureSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return LoadingPage(); // Optional: show loading while verifying
                  }

                  final refreshedUser = futureSnapshot.data;
                  if (refreshedUser == null) {
                    // User no longer exists or has been deleted
                    return pageIfNotConnected ?? const Register();
                  }

                  print("Verified user: ${refreshedUser.email}");
                  return Navbar();
                },
              );
            }

            // User is not logged in
            return pageIfNotConnected ?? const Register();
          },
        );
      },
    );
  }
}

// okay so what has happened is while building i impemented the regster user thing but not logout and i created 2 users while testing . later on i deleted one user from firebase console, then i imllpemented the logout and did that. but now the hasdaata shows the deleted account details
//ans:
// you're asking to verify if the logged-in user still exists on Firebase, even after snapshot.hasData is true. That’s the right approach because hasData just checks for a cached session, not whether the user still exists on the backend.
