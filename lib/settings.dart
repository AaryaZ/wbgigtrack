import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gigtrack/authscreens/changepassword.dart';
import 'package:gigtrack/authscreens/deleteaccount.dart';
import 'package:gigtrack/authscreens/updateusername.dart';
import 'package:gigtrack/utils/customdialog.dart';
import 'package:google_fonts/google_fonts.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String? displayName = FirebaseAuth.instance.currentUser?.displayName;

  @override
  void initState() {
    super.initState();
  }

  void updateUserDisplayName(String newName) {
    setState(() {
      displayName = newName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Center(
                  child: Text(
                    "My Profile",
                    style: GoogleFonts.nunitoSans(
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Divider(thickness: 1, color: Colors.grey[500]),
                // ClipOval(
                //   child: Image.asset(
                //     'assets/imgs/user.jpg',
                //     width: 60,
                //     height: 60,
                //     fit: BoxFit.cover,
                //   ),
                // ),
                SizedBox(height: 20),
                Container(
                  height: 170,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      //bottom right darker
                      BoxShadow(
                        color: Colors.grey.shade600,
                        offset: Offset(2, 2),
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                      //top shadow light
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-2, -2),
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Spacer(flex: 1), // Pushes avatar to 1/3 height (approx)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: AssetImage('assets/imgs/user.jpg'),
                            backgroundColor: Colors.grey[400],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: Text(
                          displayName ?? "User Name",
                          style: GoogleFonts.openSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            // color: Colors.grey[800],
                            color: Colors.indigo[900],
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          FirebaseAuth.instance.currentUser?.email ??
                              "******@gmail.com",
                          style: GoogleFonts.openSans(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      Spacer(flex: 1),
                    ],
                  ),
                ),

                SizedBox(height: 20),
                Text(
                  "Settings",
                  style: GoogleFonts.nunitoSans(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        // Navigate to the ChangePasswordPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Updateusername(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Update Username",
                            style: GoogleFonts.lato(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.grey[700],
                            size: 20,
                          ),
                        ],
                      ),
                    ), //update username
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        // Navigate to the ChangePasswordPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Changepw()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Change Password",
                            style: GoogleFonts.lato(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.grey[700],
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        // Navigate to the ChangePasswordPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeleteAccount(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Delete my Account",
                            style: GoogleFonts.lato(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.grey[700],
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "About this app",
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder:
                              (context) => CustomDialogLogout(
                                imgurl: 'assets/anims/logout.json',
                                title: 'Are you sure?',
                                desc: 'Do you really want to logout?',
                              ),
                        );
                      },
                      child: Text(
                        "Logout",
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.red[700],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


//Costom dialog box for logout

