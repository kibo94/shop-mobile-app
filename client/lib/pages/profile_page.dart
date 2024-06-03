import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_app/pages/login_page.dart';
import 'package:my_app/providers/user_provider.dart';
import 'package:my_app/ui/header.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required});
  static const routeName = '/profile';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: const [Header()],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              userProvider.user == null
                  ? "test@test.com"
                  : userProvider.user!.email,
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(
              height: 35,
            ),
            GestureDetector(
              onTap: logout,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Logout",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Icon(Icons.logout)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  logout() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => const LoginPage()),
      ),
    );
  }
}
