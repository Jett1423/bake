import 'package:bake/components/my_drawer_tile.dart';
import 'package:bake/pages/login_page.dart';
import 'package:bake/pages/order_history.dart';
import 'package:bake/pages/order_status.dart';
import 'package:bake/pages/terms.dart';
import 'package:bake/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    final authService = AuthService();

    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.lightBlue,
      child: Column(
        children: [
          //app logo
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Image.asset(
              'assets/images/login.gif',
              width: 100,
              height: 100,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(25.0),
            child: Divider(
              color: Colors.white,
            ),
          ),

          //home list title
          MyDrawerTile(
            text: "H O M E",
            icon: Icons.home,
            onTap: () => Navigator.pop(context),
          ),

          //status
          MyDrawerTile(
            text: "O R D E R  S T A T U S",
            icon: Icons.cake_rounded,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const OrderStatusPage()),
              );
            },
          ),

          MyDrawerTile(
            text: "O R D E R  H I S T O R Y",
            icon: Icons.history,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const OrderHistoryPage()),
              );
            },
          ),

          const Spacer(),

          MyDrawerTile(
            text: "Terms And Conditions",
            icon: Icons.warning,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TermsConditions()));
            },
          ),

          //log out
          MyDrawerTile(
            text: "L O G  O U T",
            icon: Icons.logout,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LoginPage(onTap: null)));
            },
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
