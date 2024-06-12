import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/pages/home_page.dart';
import 'package:my_app/pages/login_page.dart';
import 'package:my_app/providers/user_provider.dart';
import 'package:my_app/style/theme.dart';
import 'package:my_app/ui/container.dart';
import 'package:my_app/ui/header.dart';
import 'package:my_app/ui/side_bar.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required});
  static const routeName = '/profile';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    bool isLogedIn = userProvider.user != null;
    return Scaffold(
      key: _key,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          Header(
            globalKey: _key,
          )
        ],
      ),
      drawer: SideBar(barKey: _key),
      body: ShopContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "Account",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            if (isLogedIn)
              Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(top: 13, bottom: 13, left: 20),
                    width: 292,
                    decoration: BoxDecoration(
                        color: shopSecondary,
                        borderRadius: BorderRadius.circular(10)
                        // border: Border(
                        //   bottom: BorderSide(color: shopAction, width: 1),
                        // ),
                        ),
                    child: Text(
                      userProvider.user!.email,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                ],
              ),
            GestureDetector(
              onTap: () => goToLogIn(isLogedIn),
              child: Container(
                width: 170,
                height: 55,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: shopAction,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isLogedIn ? "Logout" : "Sign in",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color: Colors.white,
                              ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        if (isLogedIn)
                          const Icon(
                            Icons.logout,
                            color: Colors.white,
                          )
                      ],
                    ),
                    if (!isLogedIn)
                      Positioned(
                          right: 27,
                          top: 3,
                          child: SvgPicture.asset(
                            'assets/images/user-white.svg',
                          ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  goToLogIn(bool isLogedIn) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    if (isLogedIn) {
      userProvider.setUser(null);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => const MyHomePage()),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => const LoginPage()),
        ),
      );
    }
  }
}
