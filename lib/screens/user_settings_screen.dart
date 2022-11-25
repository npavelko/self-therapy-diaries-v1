import 'package:flutter/material.dart';
import 'package:self_therapy_diaries/main.dart';
import 'package:self_therapy_diaries/screens/field_settings_screen.dart';
import 'package:settings_ui/settings_ui.dart';

class UserSettingsScreen extends StatelessWidget {
  static const String routeName = '/user-settings-route';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SettingsList(
          sections: [
            SettingsSection(
                title: const Text(
                  'Common',
                  style: TextStyle(color: MyApp.colorMain),
                ),
                tiles: <SettingsTile>[
                  SettingsTile.navigation(
                    title: const Text('Language'),
                    leading: const Icon(Icons.language),
                    value: const Text('English'),
                    onPressed: (context) {},
                  ),
                ]),
            SettingsSection(
                title: const Text(
                  'Account',
                  style: TextStyle(color: MyApp.colorMain),
                ),
                tiles: <SettingsTile>[
                  SettingsTile.navigation(
                    title: const Text('Name'),
                    leading: const Icon(Icons.person),
                    onPressed: (context) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => FieldSettingsScreen(
                                    data: 'name',
                                  ))));
                    },
                  ),
                  SettingsTile.navigation(
                    title: const Text('Lastname'),
                    leading: const Icon(Icons.person),
                    onPressed: (context) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => FieldSettingsScreen(
                                    data: 'lastname',
                                  ))));
                    },
                  ),
                  SettingsTile.navigation(
                    title: const Text('Email'),
                    leading: const Icon(Icons.email),
                    onPressed: (context) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => FieldSettingsScreen(
                                    data: 'email',
                                  ))));
                    },
                  ),
                ])
          ],
        ),
      ),
    );
  }
}
