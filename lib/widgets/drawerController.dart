import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/main.dart';
import 'package:my_app/screens/account_screen.dart';
import 'package:my_app/widgets/menu_items.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            margin: const EdgeInsets.symmetric(vertical: 15),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            accountEmail: Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: const Text(
                "dienminhtri982702@gmail.com",
                style: TextStyle(
                  color: Color.fromARGB(255, 113, 113, 113),
                ),
              ),
            ),
            accountName: const Padding(
              padding: EdgeInsets.only(top: 25),
              child: Text(
                "Điền Minh Trí",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            currentAccountPicture: Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                border: Border.all(
                    width: 2.5,
                    // ignore: prefer_const_constructors
                    color: Color.fromARGB(255, 255, 216, 86)),
                image: const DecorationImage(
                  image: AssetImage('assets/images/avatar.jpg'),
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              color: Color.fromARGB(255, 63, 49, 49),
            ),
            title: const Text(
              'Home',
              style: TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AccountScreen(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.settings,
              color: Color.fromARGB(255, 63, 49, 49),
            ),
            title: const Text(
              'Settings and account',
              style: TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Color.fromARGB(255, 63, 49, 49),
            ),
            title: const Text(
              'Log out',
              style: TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const MainPage(
                    isLogin: true,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
