import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:self_therapy_diaries/model/diaries.dart';
import 'package:self_therapy_diaries/model/user_of_diaries.dart';
import 'package:self_therapy_diaries/screens/entries_list_screen.dart';
import 'package:self_therapy_diaries/screens/user_settings_screen.dart';
import 'package:self_therapy_diaries/service/firebase_service.dart';

class DiariesDrawer extends StatelessWidget {
  String? _name;
  String _email = '';

  DiariesDrawer(this._name);

  void logout() {
    GetIt.instance.get<FirebaseService>().singOut();
  }

  Column _createDiariesNavigation(
      BuildContext ctx, String diaryTitle, String diaryId, IconData icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(diaryTitle),
          onTap: () => Navigator.of(ctx)
              .pushReplacementNamed(EntriesListScreen.routeName, arguments: {
            'id': diaryId,
            'diaryTitle': diaryTitle,
          }),
          leading: Icon(icon),
        ),
        const Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.face,
                color: Colors.grey.shade600,
                size: 50,
              ),
            ),
            accountEmail: Text(
              _name.toString(), /* UserOfDiaries.email */
            ),
            accountName: Row(
              children: [
                Text(
                  UserOfDiaries.name + ' ' + UserOfDiaries.lastname,
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                )
              ],
            ),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 230, 81, 36),
            ),
          ),
          SizedBox(
            height: 300,
            child: ListView.builder(
              itemCount: diaries.length,
              itemBuilder: (ctx, index) => _createDiariesNavigation(context,
                  diaries[index].title, diaries[index].id, diaries[index].icon),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Settings'),
            leading: const Icon(Icons.settings),
            onTap: () {
              Navigator.of(context)
                  .popAndPushNamed(UserSettingsScreen.routeName);
              // .pushNamed(UserSettingsScreen.routeName, arguments: {});

              // GetIt.instance.get<FirebaseService>().getUserAccountData();
              //setState(() {});
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.logout),
            onTap: () => logout(),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
