import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:self_therapy_diaries/screens/field_settings_screen.dart';
import 'package:self_therapy_diaries/screens/view_page_diaries_screen.dart';
import 'package:self_therapy_diaries/screens/start_screen.dart';
import 'package:self_therapy_diaries/screens/user_settings_screen.dart';

import 'screens/diaries_screen.dart';
import './screens/add_new_entry_screen.dart';
import 'package:self_therapy_diaries/screens/auth_screen.dart';
import 'package:self_therapy_diaries/screens/entries_list_screen.dart';
import 'package:self_therapy_diaries/screens/splash_screen.dart';
import 'package:self_therapy_diaries/screens/edit_entry_screen.dart';
import 'package:self_therapy_diaries/service/firebase_service.dart';

GetIt locator = GetIt.instance;

void setupSingleton() {
  locator.registerLazySingleton<FirebaseService>(() => FirebaseService());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //read about this
  await Firebase.initializeApp(); // initialization App in Firestore
  setupSingleton();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const Color colorMain = Color.fromARGB(228, 28, 60, 16);
  static const Color scaffoldColor = Color.fromARGB(255, 242, 246, 221);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // future:  _initialization,
        builder: (context, appShapshot) {
      return MaterialApp(
          title: 'Therapy Diaries',
          theme: ThemeData(
            scaffoldBackgroundColor: scaffoldColor,
            appBarTheme: const AppBarTheme(color: colorMain),
            primaryColor: colorMain,
            accentColorBrightness: Brightness.dark,
            fontFamily: 'Lato',
            textTheme: ThemeData.light().textTheme.copyWith(
                  titleMedium: const TextStyle(
                    fontFamily: 'RobotoCondensed',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: colorMain,
                  ),
                ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                primary: colorMain,
                onPrimary: Colors.white,
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                primary: colorMain,
              ),
            ),
          ),
          home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(), // !!!!!
              builder: (ctx, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return SplashScreen();
                }
                if (userSnapshot.hasData) {
                  //return DiariesScreen();
                  return ViewPageDiariesScreen();
                }
                return AuthScreen();
              }),
          routes: {
            EntriesListScreen.routeName: (ctx) => EntriesListScreen(),
            AddNewEntrySceeen.routeName: (ctx) => AddNewEntrySceeen(),
            EditEntryScreen.routeName: (ctx) => EditEntryScreen(),
            DiariesScreen.routeName: (ctx) => DiariesScreen(),
            UserSettingsScreen.routeName: (ctx) => UserSettingsScreen(),
            FieldSettingsScreen.routeName: (ctx) => FieldSettingsScreen(
                  data: '',
                ),
            ViewPageDiariesScreen.routeName: (ctx) => ViewPageDiariesScreen(),
            StartPage.routeName: (ctx) => StartPage(),
          });
    });
  }
}
