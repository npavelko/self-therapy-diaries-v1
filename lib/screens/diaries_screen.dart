import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:self_therapy_diaries/diaries_drawer.dart';
import 'package:self_therapy_diaries/main.dart';
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
  String? name = '';
  @override
  void initState() {
    super.initState();
    getUserData();
    getUserDisplayName();
  }

  void getUserDisplayName() {
    name = GetIt.instance.get<FirebaseService>().getUserDisplayName();
  }

  void getUserData() async {
    GetIt.instance.get<FirebaseService>().getUserAccountData();
    //setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DiariesDrawer(
        name,
        // UserOfDiaries.name + ' ' + UserOfDiaries.lastname,
      ),
      appBar: AppBar(
        title: const Text(
          'Therapy Diaries',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(10),
            child: const Center(
              child: Text(
                'Love your any state',
                style: TextStyle(
                  fontSize: 20,
                  color: MyApp.secondaryColor,
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
                        diary.icon,
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
