import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:self_therapy_diaries/service/firebase_service.dart';

class ShowEditEntryScreen extends StatelessWidget {
  static const routeName = '/show-edit-entry-route';
  late final Function function;

  FirebaseService firebaseService = GetIt.instance.get<FirebaseService>();

  final String _collectionPath = 'diaries/puPc9k88E83sJRPx7lXc/notes';
  String _newTextEntry = '';
  String _newTitleEntry = '';

  String _nonChangedEntryTitle = '';
  String _nonChangedEntry = '';

  //ShowEditEntryScreen(this.function);

  String _formatter(DateTime dateTime) {
    DateFormat dateFormat = DateFormat.yMEd();
    return dateFormat.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final args = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    var _idNote = args['idNote'];
    String _diaryTitle = args['diaryTitle'];

    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
          stream: firebaseService.getNoteById(_idNote, _diaryTitle),
          /* FirebaseFirestore.instance // get Id
              .collection(_collectionPath)
              .doc(_idNote)
              .snapshots() ,*/
          builder: (ctx, snapshot) {
            if (!snapshot.hasData) {
              return const Text("no data");
            }

            var dataUser = snapshot.data as DocumentSnapshot;
            String existEntry = dataUser.get('text');
            String existEntryTitle = dataUser.get('title');
            _nonChangedEntryTitle = existEntryTitle;
            _nonChangedEntry = existEntry;

            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        initialValue: existEntryTitle,
                        onChanged: (title) {
                          _newTitleEntry = title;
                        },
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 8)),
                      Text(
                        _formatter(DateTime.now()), // отфоратировать дату
                        style: const TextStyle(color: Colors.grey),
                      ),
                      Divider(
                        color: Theme.of(context).primaryColor,
                      ),
                      TextFormField(
                        initialValue: existEntry,
                        autofocus: true,
                        decoration: const InputDecoration(
                            hintText: 'Write  your feelings here...'),
                        maxLines: 10,
                        onChanged: (value) {
                          _newTextEntry = value;
                        },
                        // controller: ,
                      ),
                    ],
                  ),
                ),
              ),
            );

            //return Text('Loading...');
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.done),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          if (_newTitleEntry.isEmpty) {
            _newTitleEntry = _nonChangedEntryTitle;
          }
          if (_newTextEntry.isEmpty) {
            _newTextEntry = _nonChangedEntry;
          }

          firebaseService.updateEnrty(
            _idNote,
            _newTitleEntry,
            _newTextEntry,
            _formatter(DateTime.now()),
            _diaryTitle,
          );
          Navigator.of(context).pop(true);
        },
      ),
    );
  }
}
