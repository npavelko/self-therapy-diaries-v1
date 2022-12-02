import 'package:flutter/material.dart';
import 'package:self_therapy_diaries/main.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);
  static const String routeName = '/start-screen-route';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyApp.scaffoldColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.spa,
            color: MyApp.colorMain,
            size: 40,
          ),
          const SizedBox(
            height: 150,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.west),
              Icon(Icons.touch_app_outlined),
            ],
          ),
          const Center(
            child: Text(
              'Swipe left to start',
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
