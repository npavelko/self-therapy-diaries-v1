import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:self_therapy_diaries/diaries_drawer.dart';
import 'package:self_therapy_diaries/main.dart';
import 'package:self_therapy_diaries/model/user_of_diaries.dart';
import 'package:self_therapy_diaries/screens/add_new_entry_screen.dart';
import 'package:self_therapy_diaries/service/firebase_service.dart';
import 'package:self_therapy_diaries/widgets/entry_item.dart';

class EntriesListScreen extends StatefulWidget {
  static const routeName = '/entries-route';

  @override
  State<EntriesListScreen> createState() => _EntriesListScreenState();
}

class _EntriesListScreenState extends State<EntriesListScreen> {
  var scaffoldKeyEntries = GlobalKey<ScaffoldState>();

  void _addNewEnrty(
    BuildContext ctx,
    String selectedDiaryId,
    String selectedDiaryTitle,
  ) {
    Navigator.pushNamed(ctx, AddNewEntrySceeen.routeName, arguments: {
      'id': selectedDiaryId,
      'diaryTitle': selectedDiaryTitle,
    });
  }

  void _deleteEntry(String idNote, String diaryTitle) {
    GetIt.instance.get<FirebaseService>().deleteEntry(diaryTitle, idNote);
    setState(() {
      Fluttertoast.showToast(
        msg: "Deleted", // message
        toastLength: Toast.LENGTH_SHORT, // length
        gravity: ToastGravity.BOTTOM,
        backgroundColor: MyApp.colorMain, // location
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = (ModalRoute.of(context)?.settings.arguments ??
        <String, String>{}) as Map;

    String selectedDiaryId = args['id'];
    String selectedDiaryTitle = args['diaryTitle'];

    return Scaffold(
      key: scaffoldKeyEntries,
      drawer: DiariesDrawer(
        UserOfDiaries.name + ' ' + UserOfDiaries.lastname,
      ),
      body: SafeArea(
        child: Stack(children: [
          Positioned(
            left: 5,
            top: 0,
            child: IconButton(
              color: MyApp.colorMain,
              iconSize: 30,
              icon: const Icon(Icons.menu),
              onPressed: () {
                scaffoldKeyEntries.currentState!.openDrawer();
              },
            ),
          ),
          StreamBuilder(
              // StreamBuilder needs stream and builder as arguments
              stream: GetIt.instance
                  .get<FirebaseService>()
                  .getAllEnrtiesBySelectedDiaryId(
                      selectedDiaryId, selectedDiaryTitle),
              builder: (ctx, AsyncSnapshot<dynamic> streamSnapshots) {
                if (streamSnapshots.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!streamSnapshots.hasData) {
                  return const Center(
                    child: Text("There is no enties. Create first one!"),
                  );
                }

                final documents = streamSnapshots.data!.docs;

                return Padding(
                  padding: const EdgeInsets.only(
                    top: 55,
                  ),
                  child: ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (ctx, index) => InkWell(
                      child: Container(
                        padding: const EdgeInsets.all(9),
                        child: EntryItem(
                          documents[index].id,
                          documents[index]['title'],
                          documents[index]['date'],
                          documents[index]['text'],
                          index,
                          documents[index]['diaryTitle'],
                          _deleteEntry,
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: MyApp.colorMain,
          child: const Icon(Icons.add, color: MyApp.scaffoldColor,),
          elevation: 5,
          onPressed: () {
            _addNewEnrty(context, selectedDiaryId, selectedDiaryTitle);
          }),
    );
  }
}
