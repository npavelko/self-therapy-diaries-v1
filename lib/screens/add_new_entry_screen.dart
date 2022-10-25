import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get_it/get_it.dart';
import 'package:self_therapy_diaries/service/firebase_service.dart';

class AddNewEntrySceeen extends StatefulWidget {
  static const String routeName = '/new-entry-route';

  const AddNewEntrySceeen({Key? key}) : super(key: key);

  @override
  _AddNewEntrySceeenState createState() => _AddNewEntrySceeenState();
}

class _AddNewEntrySceeenState extends State<AddNewEntrySceeen> {
  final FirebaseService _firebaseService =
      GetIt.instance.get<FirebaseService>();
  final _date = DateTime.now();
  var _title = '';
  var _enteredNote = '';

  String _formatter(DateTime dateTime) {
    DateFormat dateFormat = DateFormat.yMEd();
    String formatted = dateFormat.format(dateTime);
    return formatted;
  }

  void _saveNote(String diaryId, String diaryTitle, String noteTitle,
      DateTime date, String input) {
    final String formattedDate = _formatter(date);
    _firebaseService.saveEntry(
        diaryId, diaryTitle, noteTitle, date, input, formattedDate);
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final args = (ModalRoute.of(context)?.settings.arguments ??
        <String, String>{}) as Map;

    String selectedDiaryId = args['id'];
    String selectedDiaryTitle = args['diaryTitle'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('New entry'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  autofocus: true,
                  decoration: const InputDecoration(hintText: 'Title'),
                  onChanged: (title) {
                    _title = title;
                  },
                ),
                const Padding(padding: EdgeInsets.only(bottom: 8)),
                Text(
                  _formatter(_date), // отфоратировать дату
                  style: const TextStyle(color: Colors.grey),
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: 'Write your feelings here...'),
                  maxLines: 20,
                  onChanged: (value) {
                    setState(() {
                      _enteredNote = value;
                    });
                  },
                  // controller: ,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.done),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: _enteredNote.trim().isEmpty
            ? null
            : () {
                _saveNote(selectedDiaryId, selectedDiaryTitle, _title, _date,
                    _enteredNote);
                Navigator.of(context).pop();
              },
      ),
    );
  }
}
