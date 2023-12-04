import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:my_app/theme/theme_provider.dart';
import 'package:my_app/widgets/icons_widget.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  static const keyDarkMode = 'key-dark-mode';

  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.all(24),
        children: [
          SettingsGroup(
            title: 'GENERAL',
            children: <Widget>[
              buildDarkMode(context),
              buildLogout(),
            ],
          ),
        ],
      ),
    );
  }
}

Widget buildDarkMode(context) => IconButton(
      icon: Icon(Icons.dark_mode),
      onPressed: () =>
        Provider.of<ThemeProvider>(context,listen: false).toggleTheme(),
    );

Widget buildLogout() => SimpleSettingsTile(
      title: 'Logout',
      subtitle: 'Click here for log out',
      leading: IconWidget(
        color: Colors.blueAccent,
        icon: Icons.logout_sharp,
      ),
      onTap: () {},
    );
