import 'package:bake/components/my_buttons.dart';
import 'package:bake/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to send a password reset email
  Future<void> sendPasswordResetEmail() async {
    try {
      String email = emailController.text.trim();

      if (email.isEmpty) {
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text("Error"),
            content: Text("Please enter your email."),
          ),
        );
        return;
      }

      // Sending password reset email
      await _auth.sendPasswordResetEmail(email: email);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Success"),
          content: const Text(
              "Password reset email has been sent! Please check your inbox."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context); // Go back to the login screen
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: Text(e.toString()), // Display error
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Forgot Password',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Email input field using MyTextfield
            MyTextfield(
              controller: emailController,
              hintText: 'Enter your email',
              obscureText: false,
            ),
            const SizedBox(height: 20),

            // Send Reset Email Button using MyButtons
            MyButtons(
              onTap:
                  sendPasswordResetEmail, // Call sendPasswordResetEmail method
              text: 'Send reset password',
            ),
          ],
        ),
      ),
    );
  }
}
