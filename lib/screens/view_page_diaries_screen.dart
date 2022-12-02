import 'package:flutter/material.dart';
import 'package:self_therapy_diaries/screens/diaries_screen.dart';
import 'package:self_therapy_diaries/screens/start_screen.dart';

class ViewPageDiariesScreen extends StatelessWidget {
  static const String routeName = '/view-page-route';
  ViewPageDiariesScreen({Key? key}) : super(key: key);

  final pageContoller = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: pageContoller,
      children: [
        const StartPage(),
        DiariesScreen(),
      ],
    );
  }
}
