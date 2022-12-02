import 'package:flutter/material.dart';
import 'package:self_therapy_diaries/main.dart';
import 'package:self_therapy_diaries/screens/edit_entry_screen.dart';

class EntryItem extends StatelessWidget {
  final Function functionDelete;
  final String _idNote;
  final String _noteTitle;
  final String _date;
  final String _note;
  final int _index;
  final String _diaryTitle;

  EntryItem(
    this._idNote,
    this._noteTitle,
    this._date,
    this._note,
    this._index,
    this._diaryTitle,
    this.functionDelete,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //key: ValueKey(_idNote),
      onTap: () =>
          Navigator.pushNamed(context, EditEntryScreen.routeName, arguments: {
        'index': _index.toString(), //?
        'titleNote': _noteTitle, //rename entryTitle
        'idNote': _idNote,
        'diaryTitle': _diaryTitle,
      }),
      onLongPress: (() => showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Are you sure?'),
                content: const Text(
                    'Do you want to remove the entry from the diary?'),
                actions: [
                  TextButton(
                    child: const Text('No'),
                    onPressed: () {
                      Navigator.of(ctx).pop(false);
                    },
                  ),
                  TextButton(
                    child: const Text('Yes'),
                    onPressed: () {
                      functionDelete(_idNote, _diaryTitle);
                      Navigator.of(ctx).pop(true);
                    },
                  ),
                ],
              ))),
      child: ClipRRect(
        //винести в оремий класс?
        borderRadius: BorderRadius.circular(15),
        child: Card(
          shadowColor: MyApp.colorMain,
          color: MyApp.scaffoldColor,
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _noteTitle,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const Divider(),
                Text(_date),
                const Divider(),
                Text(
                  _note,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
