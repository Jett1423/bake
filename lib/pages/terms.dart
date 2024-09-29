import 'package:bake/components/my_buttons.dart';
import 'package:flutter/material.dart';

class TermsConditions extends StatefulWidget {
  const TermsConditions({super.key});

  @override
  State<TermsConditions> createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Terms and Conditions',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                const Text('Terms and Conditions for Deliciux by CHENG'),
                const SizedBox(height: 30),
                const Text('lorem ipsum'),
                const SizedBox(height: 30), // Add spacing before the buttons

                // Correct placement of Row inside the Column
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButtons(
                      text: 'Accept',
                      onTap: () {
                        // Handle accept logic here
                      },
                    ),
                    const SizedBox(width: 20), // Add spacing between buttons
                    MyButtons(
                      text: 'Decline',
                      onTap: () {
                        // Handle decline logic here
                      },
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
