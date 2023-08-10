import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_segment/flutter_advanced_segment.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_app/screens/account_screen.dart';
import 'package:my_app/screens/home_screen.dart';
import 'package:my_app/screens/my_profile_screen.dart';

enum Segment {
  all,
  starred,
}

extension SegmentsExtension on Segment {
  String get label {
    switch (this) {
      case Segment.all:
        return 'All Files';
      case Segment.starred:
        return 'Starred Files';
      default:
        return 'Unrecognized';
    }
  }

  bool get isAll => this == Segment.all;

  bool get isStarred => this == Segment.starred;
}

double translateX = 0.0;
double translateY = 0.0;
double myWidth = 0;

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final selectedSegment_00 = ValueNotifier('all');
    return Drawer(
      child: ColoredBox(
        color: Colors.white,
        child: ListView(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MyProfileScreen(),
                  ),
                );
              },
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: SingleChildScrollView(
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
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {},
                              iconSize: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  AdvancedSegment(
                    borderRadius: BorderRadius.circular(20),
                    segments: const {
                      'all': 'Light',
                      'starred': 'Dark',
                    },
                    controller: selectedSegment_00,
                    activeStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    inactiveStyle: const TextStyle(
                      color: Colors.white54,
                    ),
                    backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                    sliderDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
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
                GoogleSignIn().signOut();
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const MainPageScreen(
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
