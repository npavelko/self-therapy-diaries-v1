import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:self_therapy_diaries/main.dart';

import 'package:self_therapy_diaries/model/diaries.dart';
import 'package:self_therapy_diaries/model/user_of_diaries.dart';
import 'package:self_therapy_diaries/screens/entries_list_screen.dart';
import 'package:self_therapy_diaries/screens/user_settings_screen.dart';
import 'package:self_therapy_diaries/service/firebase_service.dart';

class DiariesDrawer extends StatelessWidget {
  
  void logout() {
    GetIt.instance.get<FirebaseService>().singOut();
  }

  Column _createDiariesNavigation(
      BuildContext ctx, String diaryTitle, String diaryId, IconData icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(
            diaryTitle,
            style: const TextStyle(color: MyApp.colorMain),
          ),
          onTap: () => Navigator.of(ctx)
              .pushReplacementNamed(EntriesListScreen.routeName, arguments: {
            'id': diaryId,
            'diaryTitle': diaryTitle,
          }),
          leading: Icon(
            icon,
            color: MyApp.colorMain.withOpacity(0.6),
          ),
        ),
        const Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: MyApp.scaffoldColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPictureSize: const Size.square(50),
            currentAccountPicture: const CircleAvatar(
              maxRadius: 20,
              backgroundColor: MyApp.scaffoldColor,
              child: Icon(
                Icons.spa,
                color: MyApp.colorMain,
                size: 45,
              ),
            ),
            accountEmail: Text(
              UserOfDiaries.email,
              style: const TextStyle(color: MyApp.scaffoldColor),
            ),
            accountName: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  UserOfDiaries.name,
                  style: const TextStyle(
                    color: MyApp.scaffoldColor,
                    fontSize: 20,
                  ),
                ),
                Text(
                  UserOfDiaries.lastname,
                  style: const TextStyle(
                    color: MyApp.scaffoldColor,
                    fontSize: 20,
                  ),
                )
              ],
            ),
            decoration: const BoxDecoration(color: MyApp.colorMain),
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
            leading: Icon(
              Icons.settings,
              color: MyApp.colorMain.withOpacity(0.6),
            ),
            onTap: () {
              Navigator.of(context)
                  .popAndPushNamed(UserSettingsScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Logout'),
            leading: Icon(
              Icons.logout,
              color: MyApp.colorMain.withOpacity(0.6),
            ),
            onTap: () => logout(),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
