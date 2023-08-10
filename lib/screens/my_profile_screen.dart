import 'package:emojis/emojis.dart';
import 'package:flutter/material.dart';
import 'package:my_app/models/statusProfile.dart';
import 'package:my_app/screens/edit_profile_screen.dart';
import 'package:my_app/widgets/item_status_profile.dart';

class MyProfileScreen extends StatefulWidget {
  final StatusProfile? statusProfile;

  const MyProfileScreen({
    super.key,
    this.statusProfile,
  });

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  StatusProfile? statusProfile;
  final List<String> statusList = [
    '${Emojis.sleepingFace} Away',
    '${Emojis.desktopComputer} At Work',
    '${Emojis.videoGame} Gaming'
  ];
  int status = 1;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ColoredBox(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 30,
                        ),
                      ),
                      const Text(
                        'My Profile',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_vert_outlined,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: const EdgeInsets.only(top: 20)
                    .add(const EdgeInsets.symmetric(horizontal: 30)),
                child: SingleChildScrollView(
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
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
                      Container(
                        margin: const EdgeInsets.all(30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Điền Minh Trí",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "Mobile Developer",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.border_color_outlined),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const EditProfileScreen(),
                            ),
                          );
                        },
                        iconSize: 20,
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 30),
              child: Text(
                'My Status',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.3),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  statusList.length,
                  (index) => ItemStatusProfile(
                    onPress: () {},
                    title: statusList[index],
                    color: status == index
                        ? index == 2
                            ? Colors.orangeAccent
                            : index == 0
                                ? Colors.black
                                : Colors.green
                        : Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 30),
              child: Text(
                'Dashboard',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.3),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: Colors.green,
                          ),
                          child: Icon(
                            Icons.payment_outlined,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(
                          'Payments',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 70,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(vertical: 5).add(
                              const EdgeInsets.only(left: 10),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: const Row(
                              children: [
                                Text(
                                  '2 News',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Icon(Icons.chevron_right, color: Colors.white),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: Colors.orangeAccent,
                          ),
                          child: Icon(
                            Icons.lock_clock_outlined,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(
                          'Achievements',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 90,
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.chevron_right,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          child: Icon(
                            Icons.privacy_tip_outlined,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(
                          'Privacy',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(vertical: 5).add(
                              const EdgeInsets.only(left: 10),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: const Row(
                              children: [
                                Text(
                                  'Actions Needed',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Icon(Icons.chevron_right, color: Colors.white),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 30),
              child: Text(
                'My Account',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.3),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10, left: 30),
              child: Text(
                'Switch to Other Account',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10, left: 30),
              child: Text(
                'Log Out',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
