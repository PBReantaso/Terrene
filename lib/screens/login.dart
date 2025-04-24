import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:terrene/screens/Register.dart';

/* 
Authored by: Philippe Bernard G. Reantaso/Francis Dave A. Asico
Company: CSPCA
Project: Terrene
Feature: [TCM-002] Login & Register Screen
Description: login screen.
*/

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Leaderboards", style: TextStyle(color: Colors.white)),
      //   backgroundColor: Color(0xFF23442F),
      // ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFF23442F),
          //borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            const SizedBox(height: 60),
            SizedBox(
              width: 352,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 25.0),
                child: Image.asset('lib/assets/logo.png'),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  //vertical: 8,
                ),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: ListView(
                  primary: false,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 15.0),
                      child: Image.asset(
                        'lib/assets/mdi_hand-wave.png',
                        height: 57,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        'Welcome Back',
                        style: GoogleFonts.ubuntu(
                          fontWeight: FontWeight.w700,
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(bottom: 15.0),
                      child: Text(
                        'Sign in to your account',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0,
                          color: Color(0x80000000)
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 15.0),
                      child: TextField(
                        decoration: InputDecoration(
                          filled: false,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                          ),
                          hintText: 'Username',
                          hintStyle: GoogleFonts.poppins(
                            color: Color(0x6A000000),
                            fontSize: 15,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: TextField(
                        decoration: InputDecoration(
                          filled: false,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                          ),
                          hintText: 'Password',
                          hintStyle: GoogleFonts.poppins(
                            color: Color(0x6A000000),
                            fontSize: 15,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        obscureText: true,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          // Forgot password logic
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            //decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // sign in logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1B4D3E),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0)))
                      ),
                      child: Text(
                        'Sign In',
                        style: GoogleFonts.poppins(
                            color: Color(0xFFFFFFFF),
                            fontSize: 18,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => Register()),
                              );
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.fromLTRB(0, 10.0, 0, 12.0),
                          width: 100,
                          child: Divider(
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.fromLTRB(0, 10.0, 0, 12.0),
                          width: 130,
                          child: Text('or continue with'),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.fromLTRB(0, 10.0, 0, 12.0),
                          width: 100,
                          child: Divider(
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Google sign in logic here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF921111),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0)))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'lib/assets/google logo.png',
                            ),
                            SizedBox(width: 8,),
                            Text(
                              'Continue with Google',
                              style: GoogleFonts.poppins(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Facebook sign in logic here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF3B46F1),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0)))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'lib/assets/facebook 1.png',
                            ),
                            SizedBox(width: 8,),
                            Text(
                              'Continue with Facebook',
                              style: GoogleFonts.poppins(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
