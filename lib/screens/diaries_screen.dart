import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:self_therapy_diaries/diaries_drawer.dart';
import 'package:self_therapy_diaries/service/firebase_service.dart';

import 'package:self_therapy_diaries/widgets/diary_item.dart';
import '../diaries.dart';

class DiariesScreen extends StatelessWidget {
  static const routeName = '/diaries-route';
  final FirebaseService _firebaseService =
      GetIt.instance.get<FirebaseService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DiariesDrawer(),
      appBar: AppBar(
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Row(
                  children: [
                    Icon(
                      Icons.exit_to_app,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Logout',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
                value: 'logout',
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                _firebaseService.singOut();
                //FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
        title: const Text(
          'Therapy Diaries',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: GridView(
          padding: const EdgeInsets.all(15),
          children: DIARIES // FIRST WHAT NEED TO CHANGE
              .map((diary) => DiaryItem(
                    diary.id,
                    diary.title,
                    diary.image,
                  ))
              .toList(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 450,
            mainAxisExtent: 200,
            childAspectRatio: 4 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          )),
    );
  }
}
