import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Terrene App',
      home: const Register(),
    );
  }
}

class Register extends StatelessWidget {
  const Register({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF1B4D3E),
        child: Column(
          children: [
            const SizedBox(height: 60),
            SizedBox(
              width: 250,
              child: Image.asset('/assets/Logo.png'),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: ListView(
                  children: [
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        'Create your Account',
                        style: GoogleFonts.ubuntu(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    buildInputField('Name'),
                    buildInputField('Email'),
                    buildInputField('Phone Number'),
                    buildPasswordField('Password'),
                    buildPasswordField('Re-type Password'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1B4D3E),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        'Register',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to Login screen
                          Navigator.pop(context);
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "Already have an account? ",
                            style: GoogleFonts.poppins(
                              color: Colors.black87,
                              fontSize: 13,
                            ),
                            children: [
                              TextSpan(
                                text: "Sign In",
                                style: GoogleFonts.poppins(
                                  color: Color(0xFF1B4D3E),
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInputField(String hint) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.poppins(
            color: Colors.black54,
            fontSize: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        ),
      ),
    );
  }

  Widget buildPasswordField(String hint) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          hintText: hint,
          suffixIcon: Icon(Icons.visibility),
          hintStyle: GoogleFonts.poppins(
            color: Colors.black54,
            fontSize: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        ),
      ),
    );
  }
}
