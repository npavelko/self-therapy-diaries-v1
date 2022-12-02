import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:self_therapy_diaries/main.dart';
import 'package:self_therapy_diaries/service/firebase_service.dart';

class EditEntryScreen extends StatelessWidget {
  static const routeName = '/show-edit-entry-route';
  late final Function function;

  String _newTextEntry = '';
  String _newTitleEntry = '';

  String _nonChangedEntryTitle = '';
  String _nonChangedEntry = '';

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
          stream: GetIt.instance
              .get<FirebaseService>()
              .getEntryById(_idNote, _diaryTitle),
          builder: (ctx, snapshot) {
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
                        _formatter(DateTime.now()),
                        style: const TextStyle(color: Colors.grey),
                      ),
                      Divider(
                        color: Theme.of(context).primaryColor,
                      ),
                      TextFormField(
                      
                        initialValue: existEntry,
                        autofocus: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                            hintText: 'Write  your feelings here...'),
                        maxLines: 100,
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
        child: const Icon(
          Icons.done,
          color: MyApp.scaffoldColor,
        ),
        backgroundColor: MyApp.colorMain,
        onPressed: () {
          if (_newTitleEntry.isEmpty) {
            _newTitleEntry = _nonChangedEntryTitle;
          }
          if (_newTextEntry.isEmpty) {
            _newTextEntry = _nonChangedEntry;
          }
          GetIt.instance.get<FirebaseService>().updateEnrty(
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
