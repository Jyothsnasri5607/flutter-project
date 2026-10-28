import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  bool hidePassword = true;

  String errorMessage = '';

  void login() {
    final username = usernameController.text.trim();
    final password = passwordController.text;

    if (username.isEmpty) {
      setState(() {
        errorMessage = 'Please enter the username';
      });
      return;
    }

    if (password.isEmpty) {
      setState(() {
        errorMessage = 'Please enter the password';
      });
      return;
    }

    if (username == 'owner' && password == 'cellpoint123') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
        ),
      );
    } else {
      setState(() {
        errorMessage = 'Invalid username or password';
      });
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.phone_android,
                      size: 70,
                      color: Colors.blue,
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      'CELL POINT',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      'Mobile Shop Management System',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 30),

                    TextField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Owner Username',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 18),

                    TextField(
                      controller: passwordController,
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          icon: Icon(
                            hidePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    if (errorMessage.isNotEmpty)
                      Text(
                        errorMessage,
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: login,
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'Owner Access Only',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}