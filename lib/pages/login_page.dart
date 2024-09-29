import 'package:bake/components/my_buttons.dart';
import 'package:bake/components/my_textfield.dart';
import 'package:bake/pages/forgot_password.dart';
import 'package:bake/pages/home_page.dart'; // Import HomePage
import 'package:bake/pages/register_page.dart';
import 'package:bake/services/auth/auth_service.dart';
import 'package:flutter/material.dart'; // Import the ForgotPassword page

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // login method
  void login() async {
    // get instance of auth service
    final _authService = AuthService();

    // Check if both fields are empty
    if (emailController.text.isEmpty && passwordController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Error"),
          content: Text("Email and Password cannot be empty."),
        ),
      );
      return;
    }

    // Check if email field is empty
    if (emailController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Error"),
          content: Text("Email cannot be empty."),
        ),
      );
      return;
    }

    // Check if password field is empty
    if (passwordController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Error"),
          content: Text("Input your password."),
        ),
      );
      return;
    }

    // Try sign in
    try {
      await _authService.signInWithEmailPassword(
        emailController.text,
        passwordController.text,
      );

      // If sign in is successful, navigate to the home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(), // Navigate to HomePage
        ),
      );
    }

    // Handle errors during sign-in
    catch (e) {
      String errorMessage = e.toString();

      // Customize the error message based on typical Firebase Auth errors
      if (errorMessage.contains('user-not-found')) {
        errorMessage = "Email not found. Please check your email.";
      } else if (errorMessage.contains('wrong-password')) {
        errorMessage = "Incorrect password. Please try again.";
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Login Error"),
          content: Text(errorMessage),
        ),
      );
    }
  }

  // navigate to ForgotPassword page
  void navigateToForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ForgotPasswordPage(),
      ),
    );
  }

  void signup() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegisterPage(onTap: null),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 244, 244),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              Image.asset(
                'assets/images/login.gif',
                width: 200,
                height: 200,
              ),
              const SizedBox(
                height: 30,
              ),

              // message/slogan
              const Text(
                "Aldriane A.A Bakeshop App",
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
              const SizedBox(
                height: 30,
              ),

              // email textfield
              MyTextfield(
                controller: emailController,
                hintText: "Email",
                obscureText: false,
              ),
              const SizedBox(
                height: 20,
              ),

              // password textfield
              MyTextfield(
                controller: passwordController,
                hintText: "Password",
                obscureText: true,
              ),
              const SizedBox(
                height: 40,
              ),

              // sign in button
              MyButtons(
                text: "Sign In",
                onTap: login,
              ),
              const SizedBox(
                height: 10,
              ),

              // register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Doesn't have an account? "),
                  GestureDetector(
                    onTap: signup,
                    child: const Text(
                      "Register Now!",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),

              // forgot password
              GestureDetector(
                onTap: navigateToForgotPassword,
                child: const Text(
                  "Forgot your password?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
