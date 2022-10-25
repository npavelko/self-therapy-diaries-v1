import 'package:flutter/material.dart';
import 'package:self_therapy_diaries/dummy_data.dart';
import 'package:self_therapy_diaries/screens/diaries_screen.dart';
import 'package:self_therapy_diaries/screens/entries_list_screen.dart';

class DiariesDrawer extends StatelessWidget {
  // const ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Text('All diaries'),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 230, 81, 36),
            ),
          ),
          ListTile(
            title: Text(DIARIES[0].title),
            onTap: () => Navigator.of(context)
                .pushNamed(EntriesListScreen.routeName, arguments: {
              'id': DIARIES[0].id,
              'diaryTitle': DIARIES[0].title,
            }),
            /* DiaryItem(DUMMY_DIARIES[0].id, DUMMY_DIARIES[0].title,
                DUMMY_DIARIES[0].image), */
          ),
          ListTile(
            title: Text(DIARIES[1].title),
            onTap: () => Navigator.of(context)
                .pushNamed(EntriesListScreen.routeName, arguments: {
              'id': DIARIES[1].id,
              'diaryTitle': DIARIES[1].title,
            }),
          ),
          ListTile(
            title: Text(DIARIES[2].title),
            onTap: () => Navigator.of(context)
                .pushNamed(EntriesListScreen.routeName, arguments: {
              'id': DIARIES[2].id,
              'diaryTitle': DIARIES[2].title,
            }),
          ),
          ListTile(
            title: Text(DIARIES[3].title),
            onTap: () => Navigator.of(context)
                .pushNamed(EntriesListScreen.routeName, arguments: {
              'id': DIARIES[3].id,
              'diaryTitle': DIARIES[3].title,
            }),
          ),
          ListTile(
            title: Text('Main page'),
            onTap: () => Navigator.of(context).pushNamed(
              DiariesScreen.routeName,
            ),
          )
        ],
      ),
    );
  }
}
