import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:self_therapy_diaries/diaries_drawer.dart';
import 'package:self_therapy_diaries/model/user_of_diaries.dart';
import 'package:self_therapy_diaries/service/firebase_service.dart';

import 'package:self_therapy_diaries/widgets/diary_item.dart';
import '../model/diaries.dart';

class DiariesScreen extends StatefulWidget {
  static const routeName = '/diaries-route';

  @override
  State<DiariesScreen> createState() => _DiariesScreenState();
}

class _DiariesScreenState extends State<DiariesScreen> {
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    await GetIt.instance.get<FirebaseService>().getUserNameAndLastname();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DiariesDrawer(
        UserOfDiaries.name + ' ' + UserOfDiaries.lastname,
      ),
      appBar: AppBar(
        /*  actions: [
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
                GetIt.instance.get<FirebaseService>().singOut();
              }
            },
          ),
        ], */
        title: const Text(
          'Therapy Diaries',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: const Center(
              child: Text(
                'Love your any state',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView(
              padding: const EdgeInsets.all(15),
              children: diaries
                  .map((diary) => DiaryItem(
                        diary.id,
                        diary.title,
                        diary.linearGradient,
                      ))
                  .toList(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 450,
                mainAxisExtent: 120,
                childAspectRatio: 4 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
