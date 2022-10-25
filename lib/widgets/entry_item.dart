import 'package:flutter/material.dart';
import 'package:self_therapy_diaries/screens/show_edit_entry_screen.dart';

class EntryItem extends StatelessWidget {
  final Function functionDelete;
  //final Function functionUpdate;

  final String _idNote;
  final String _noteTitle;
  final String _date;
  final String _note;
  final int _index;
  final String diaryTitle; // for test

  EntryItem(
    this._idNote,
    this._noteTitle,
    this._date,
    this._note,
    this._index,
    this.diaryTitle,
    this.functionDelete,
    // this.functionUpdate,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //key: ValueKey(_idNote),
      onTap: () => Navigator.pushNamed(context, ShowEditEntryScreen.routeName,
          arguments: {
            'index': _index.toString(),
            'titleNote': _noteTitle,
            'idNote': _idNote,
            'diaryTitle': diaryTitle,
            //'function': functionUpdate,
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
                      functionDelete(_idNote);
                      Navigator.of(ctx).pop(true);
                    },
                  ),
                ],
              ))),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Card(
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
