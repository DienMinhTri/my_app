// ignore_for_file: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/main.dart';
import 'package:my_app/screens/account_screen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ColoredBox(
        color: Colors.white,
        child: ListView(
          children: [
            InkWell(
              onTap: () {},
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10)
                        .add(const EdgeInsets.only(left: 10)),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2.5,
                              // ignore: prefer_const_constructors
                              color: Color.fromARGB(255, 255, 216, 86),
                            ),
                            image: const DecorationImage(
                              image: AssetImage('assets/images/avatar.jpg'),
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Điền Minh Trí",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "dienminhtri982702@gmail.com",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: 300,
                    height: 40,
                    child: TextFormField(
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: const TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 171, 171, 171),
                        ),
                        prefix: Container(
                          padding: const EdgeInsets.only(right: 5),
                          transform: Matrix4.translationValues(0.0, 2, 0.0),
                          child: const Icon(
                            Icons.search,
                            size: 13,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.black.withOpacity(0.5),
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AccountScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.black.withOpacity(0.5),
              ),
              title: Text(
                'Account',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.black.withOpacity(0.5),
              ),
              title: Text(
                'Settings',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: Icon(
                Icons.south_west,
                color: Colors.black.withOpacity(0.5),
              ),
              title: Text(
                'Log out',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black.withOpacity(0.5),
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
      ),
    );
  }
}
