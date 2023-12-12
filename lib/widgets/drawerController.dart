// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_advanced_segment/flutter_advanced_segment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/bloc/app_bloc.dart';
import 'package:my_app/bloc/user_bloc.dart';
import 'package:my_app/models/userRef.dart';
import 'package:my_app/screens/edit_profile_screen.dart';
import 'package:my_app/screens/statistic_todo_chart.dart';

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
            Column(
              children: [
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    UserRef? userRef;

                    if (state is GetDoneUserState) {
                      userRef = state.userRef;
                    }

                    if (userRef == null) return SizedBox();

                    return SingleChildScrollView(
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
                                  image: DecorationImage(
                                    image: userRef.avatar.isNotEmpty
                                        ? NetworkImage(userRef.avatar)
                                            as ImageProvider<Object>
                                        : AssetImage(
                                            'assets/images/avatar.jpg',
                                          ),
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userRef.fullname.isEmpty
                                        ? "User"
                                        : userRef.fullname,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    userRef.email,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
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
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.black.withOpacity(0.8),
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.black.withOpacity(0.8),
              ),
              title: Text(
                'Account',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
              onTap: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditProfileScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.stacked_bar_chart,
                color: Colors.black.withOpacity(0.8),
              ),
              title: Text(
                'Statistic',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StatisticTodoScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.black.withOpacity(0.8),
              ),
              title: Text(
                'Settings',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black.withOpacity(0.8),
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
                color: Colors.black.withOpacity(0.8),
              ),
              title: Text(
                'Log out',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
              onTap: () {
                AppBloc.userBloc.add(LogoutEvent(context));
              },
            ),
          ],
        ),
      ),
    );
  }
}
