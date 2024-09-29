import 'package:bake/pages/login_page.dart';
import 'package:bake/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import '../components/my_buttons.dart';
import '../components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactnumber = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();

  // Register user method
  void register() async {
    //getting auth service
    final _authService = AuthService();

    // Check for empty fields
    if (firstname.text.isEmpty ||
        lastname.text.isEmpty ||
        emailController.text.isEmpty ||
        contactnumber.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmpasswordController.text.isEmpty) {
      // Show a dialog for missing fields
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Missing Fields"),
          content: Text("Please fill in all the fields."),
        ),
      );
      return; // Stop further execution if fields are missing
    }

    // Check if passwords match
    if (passwordController.text != confirmpasswordController.text) {
      // Passwords do not match
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Passwords don't match!"),
        ),
      );
      // Clear both password fields
      passwordController.clear();
      confirmpasswordController.clear();
      return;
    }

    // If all validations pass, try creating the user
    try {
      await _authService.signUpWithEmailPassword(
        emailController.text,
        passwordController.text,
      );
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Account Created!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(
                      onTap: null,
                    ),
                  ),
                );
              },
              child: const Text("OK"),
            )
          ],
        ),
      );
    } catch (e) {
      // Display error if registration fails
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Registration Error"),
          content:
              Text(e.toString()), // You can customize the error message here.
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 244, 244),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                const Text(
                  "Sign up",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.blue),
                ),

                const SizedBox(
                  height: 30,
                ),

                // First name
                MyTextfield(
                  controller: firstname,
                  hintText: "Enter First name",
                  obscureText: false,
                ),
                const SizedBox(
                  height: 20,
                ),

                // Last name
                MyTextfield(
                  controller: lastname,
                  hintText: "Enter Last name",
                  obscureText: false,
                ),
                const SizedBox(
                  height: 20,
                ),

                // Contact number
                MyTextfield(
                  controller: contactnumber,
                  hintText: "Enter Number",
                  obscureText: false,
                ),
                const SizedBox(
                  height: 20,
                ),

                // Email
                MyTextfield(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),
                const SizedBox(
                  height: 20,
                ),

                // Password
                MyTextfield(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),
                const SizedBox(
                  height: 20,
                ),

                // Confirm Password
                MyTextfield(
                  controller: confirmpasswordController,
                  hintText: "Confirm Password",
                  obscureText: true,
                ),
                const SizedBox(
                  height: 20,
                ),

                // Sign up button
                MyButtons(
                  text: "Sign Up",
                  onTap: register,
                ),
                const SizedBox(
                  height: 10,
                ),

                // Already have an account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(
                              onTap: null,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        "Login here!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
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
