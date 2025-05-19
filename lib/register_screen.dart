import 'package:flutter/material.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _retypePasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isRetypePasswordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _retypePasswordController.dispose();
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
                      'lib/assets/Orange -Terrene logo 4.png',
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
                              Icon(Icons.person_add_alt_1, size: isSmall ? 28 : 36, color: darkGreen),
                              SizedBox(height: isSmall ? 2 : 6),
                              // Create your account
                              Text(
                                'Create your account',
                                style: TextStyle(
                                  fontSize: isSmall ? 16 : 20,
                                  fontWeight: FontWeight.bold,
                                  color: darkGreen,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: isSmall ? 2 : 4),
                              const Text(
                                'Sign up to get started',
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
                              // Email
                              TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  hintText: 'Email',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: isSmall ? 8 : 12),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!value.contains('@')) {
                                    return 'Please enter a valid email';
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
                              SizedBox(height: isSmall ? 8 : 12),
                              // Retype Password
                              TextFormField(
                                controller: _retypePasswordController,
                                obscureText: !_isRetypePasswordVisible,
                                decoration: InputDecoration(
                                  labelText: 'Retype Password',
                                  hintText: 'Retype Password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: isSmall ? 8 : 12),
                                  suffixIcon: IconButton(
                                    icon: Icon(_isRetypePasswordVisible ? Icons.visibility_off : Icons.visibility),
                                    onPressed: () {
                                      setState(() {
                                        _isRetypePasswordVisible = !_isRetypePasswordVisible;
                                      });
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please retype your password';
                                  }
                                  if (value != _passwordController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: isSmall ? 10 : 16),
                              // Sign Up Button
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
                                      // TODO: Implement registration logic
                                    }
                                  },
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(fontSize: isSmall ? 14 : 16, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(height: isSmall ? 2 : 6),
                              // Already have an account? Login
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Already have an account? "),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => const LoginScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Login',
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
                                    child: Text('or sign up with', style: TextStyle(color: Colors.grey[600], fontSize: isSmall ? 11 : 13)),
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
                                  label: Text('Sign up with Google', style: TextStyle(fontSize: isSmall ? 13 : 15)),
                                  onPressed: () {},
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
                                  label: Text('Sign up with Facebook', style: TextStyle(fontSize: isSmall ? 13 : 15)),
                                  onPressed: () {},
                                ),
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