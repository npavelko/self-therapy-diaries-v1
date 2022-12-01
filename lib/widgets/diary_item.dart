import 'package:flutter/material.dart';
import 'package:self_therapy_diaries/main.dart';
import 'package:self_therapy_diaries/screens/entries_list_screen.dart';

class DiaryItem extends StatelessWidget {
  final String diaryId;
  final String diaryTitle;
  final IconData iconData;

  DiaryItem(
      this.diaryId, this.diaryTitle, this.iconData);

  void selectedDiary(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(EntriesListScreen.routeName,
        arguments: {'id': diaryId, 'diaryTitle': diaryTitle});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectedDiary(context),
      child: Card(
        color: MyApp.scaffoldColor,
        shadowColor: MyApp.colorMain, //?
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            verticalDirection: VerticalDirection.up,
            children: [
              IconTheme(
                data: const IconThemeData(
                  color: MyApp.colorMain,
                  size: 70,
                ),
                child: Icon(iconData),
              ),
              Text(
                diaryTitle,
                style: const TextStyle(color: MyApp.colorMain, fontSize: 20),
              ),
            ],
          ),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
