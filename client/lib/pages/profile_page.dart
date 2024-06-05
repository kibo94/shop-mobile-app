import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    bool isLogedIn = userProvider.user != null;
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
            if (isLogedIn)
              Column(
                children: [
                  Text(
                    userProvider.user!.email,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                ],
              ),
            GestureDetector(
              onTap: () => goToLogIn(isLogedIn),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isLogedIn ? "Logout" : "Sign in",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  isLogedIn
                      ? const Icon(Icons.logout)
                      : SvgPicture.asset('assets/images/user.svg')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  goToLogIn(bool isLogedIn) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => const LoginPage()),
      ),
    );
    if (isLogedIn) {
      userProvider.setUser(null);
    }
  }
}
