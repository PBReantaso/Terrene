import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('lib/assets/logo.png', height: 100),
            SizedBox(height: 200),
            TextField(
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // sign in logic here
              },
              child: Text('Sign In'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[900],
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Don't have an account?",
            ),
            TextButton(
              onPressed: () {
                // registration logic here
              },
              
              child: Text('Register'),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Google sign in logic here
                  },
                  child: Text('Continue with Google'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, 
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Facebook sign in logic here
                  },
                  child: Text('Continue with Facebook'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, 
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}