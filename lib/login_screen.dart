import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'register_screen.dart';
import 'dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  Future<void> _handleGoogleSignIn() async {
    try {
      setState(() => _isLoading = true);
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_email', googleUser.email);
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing in with Google: $e')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleFacebookSignIn() async {
    try {
      setState(() => _isLoading = true);
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_token', accessToken.token);
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing in with Facebook: $e')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final darkGreen = const Color(0xFF204B3A);
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
    return Scaffold(
      backgroundColor: darkGreen,
      body: SafeArea(
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: double.infinity,
                color: darkGreen,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: isSmall ? 12 : 24),
                    // Logo
                    Image.asset(
                      'assets/Orange -Terrene logo 4.png',
                      height: isSmall ? 48 : 70,
                    ),
                    SizedBox(height: isSmall ? 8 : 16),
                    // White card with rounded corners
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: isSmall ? 12 : 24,
                          vertical: isSmall ? 12 : 20,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                          ),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(height: isSmall ? 2 : 8),
                              // Hand wave icon
                              Icon(Icons.waving_hand, size: isSmall ? 28 : 36, color: darkGreen),
                              SizedBox(height: isSmall ? 2 : 6),
                              // Welcome Back
                              Text(
                                'Welcome Back',
                                style: TextStyle(
                                  fontSize: isSmall ? 16 : 20,
                                  fontWeight: FontWeight.bold,
                                  color: darkGreen,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: isSmall ? 2 : 4),
                              const Text(
                                'Sign in to your account',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: isSmall ? 10 : 16),
                              // Username
                              TextFormField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                  labelText: 'Username',
                                  hintText: 'Username',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: isSmall ? 8 : 12),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your username';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: isSmall ? 8 : 12),
                              // Password
                              TextFormField(
                                controller: _passwordController,
                                obscureText: !_isPasswordVisible,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  hintText: 'Password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: isSmall ? 8 : 12),
                                  suffixIcon: IconButton(
                                    icon: Icon(_isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                                    onPressed: () {
                                      setState(() {
                                        _isPasswordVisible = !_isPasswordVisible;
                                      });
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  if (value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: isSmall ? 2 : 6),
                              // Forgot Password
                              Row(
                                children: [
                                  Checkbox(value: false, onChanged: (_) {}),
                                  const Text('Forgot Password?'),
                                ],
                              ),
                              SizedBox(height: isSmall ? 6 : 10),
                              // Sign In Button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: darkGreen,
                                    padding: EdgeInsets.symmetric(vertical: isSmall ? 10 : 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => const DashboardScreen(),
                                        ),
                                      );
                                    }
                                  },
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(fontSize: isSmall ? 14 : 16, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(height: isSmall ? 2 : 6),
                              // Register
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Don't have an account? "),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => const RegisterScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Register',
                                      style: TextStyle(
                                        color: darkGreen,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: isSmall ? 6 : 12),
                              // Divider with or with
                              Row(
                                children: [
                                  const Expanded(child: Divider()),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text('or with', style: TextStyle(color: Colors.grey[600], fontSize: isSmall ? 11 : 13)),
                                  ),
                                  const Expanded(child: Divider()),
                                ],
                              ),
                              SizedBox(height: isSmall ? 6 : 12),
                              // Google Button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFDB4437),
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(vertical: isSmall ? 8 : 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  icon: const Icon(Icons.g_mobiledata, size: 24),
                                  label: Text('Continue with Google', style: TextStyle(fontSize: isSmall ? 13 : 15)),
                                  onPressed: _isLoading ? null : _handleGoogleSignIn,
                                ),
                              ),
                              SizedBox(height: isSmall ? 4 : 8),
                              // Facebook Button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF1877F3),
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(vertical: isSmall ? 8 : 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  icon: const Icon(Icons.facebook, size: 20),
                                  label: Text('Continue with Facebook', style: TextStyle(fontSize: isSmall ? 13 : 15)),
                                  onPressed: _isLoading ? null : _handleFacebookSignIn,
                                ),
                              ),
                              if (_isLoading)
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: CircularProgressIndicator(color: darkGreen),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
} 