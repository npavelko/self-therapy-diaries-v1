import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:self_therapy_diaries/model/user_of_diaries.dart';
import 'package:intl/intl.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

class FirebaseService {
  //static String userName = '';
  //static String userLastName = '';
  String? _currentUserID = '';

  final String _collectionNotes = 'notes';
  final CollectionReference _collectionUsers =
      _firebaseFirestore.collection('users');
  final CollectionReference _collectionDiaries =
      _firebaseFirestore.collection('diaries');

  Future<String> createUser(String email, String password, String username,
      String userLastname) async {
    UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    User? user = result.user;
    user!.updateDisplayName(username + ' ' + userLastname);
    _currentUserID = user.uid;

    return user.uid;
  }

  Future<String> signIn(String email, String password) async {
    UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    User? user = result.user;
    _currentUserID = user!.uid;
    return user.uid;
  }

  String? getUserEmail() {
    return _firebaseAuth.currentUser!.email;
  }

  String? getUserDisplayName() {
    return _firebaseAuth.currentUser!.displayName;
  }

  void changeUserEmail(String email) async {
    Map<String, String> data = {'email': email};
    _collectionUsers.doc(_currentUserID).update(data);
    User? user = _firebaseAuth.currentUser;
    user!.updateEmail(email);
  }

  void changeUserName(String name) async {
    Map<String, String> data = {'username': name};
    _collectionUsers.doc(_currentUserID).update(data);
  }

  void changeUserLastname(String lastname) async {
    Map<String, String> data = {'userLastname': lastname};
    _collectionUsers.doc(_currentUserID).update(data);
  }

  Future<void> setCollectionUser(
      String userName, String userLastname, String email, String userId) async {
    await _collectionUsers.doc(userId).set({
      'username': userName,
      'userLastname': userLastname,
      'email': email,
    });
  }

  void getCurrentUserId() {
    _currentUserID = _firebaseAuth.currentUser!.uid;
  }

  void getUserAccountData() async {
    Map<String, dynamic> userMapData = {};
    getCurrentUserId();
    await _collectionUsers.doc(_currentUserID).get().then((value) {
      userMapData = value.data() as Map<String, dynamic>;
      UserOfDiaries.name = userMapData['username'];
      UserOfDiaries.lastname = userMapData['userLastname'];
      UserOfDiaries.email = userMapData['email'];
    });
    //return UserOfDiaries.name + ' ' + UserOfDiaries.lastname;
  }

  Future<void> saveEntry(
    String diaryId,
    String diaryTitle,
    String noteTitle,
    String input,
    String formattedDate,
  ) async {
    getCurrentUserId();
    DocumentReference documentReferencer =
        _collectionDiaries.doc(diaryTitle).collection(_collectionNotes).doc();
    var dateForSort = formatter(DateTime.now());
    Map<String, dynamic> data = <String, dynamic>{
      'author': _currentUserID,
      'diaryId': diaryId,
      'diaryTitle': diaryTitle,
      'title': noteTitle,
      'date': formattedDate,
      'text': input,
      'timestamp': dateForSort,
    };
    documentReferencer.set(data);
  }

  String formatter(DateTime dateTime) {
    DateFormat dateFormat = DateFormat('yyyyMMddhhmmss');
    String formatted = dateFormat.format(dateTime);
    return formatted;
  }

  Future<void> updateEnrty(String idNote, String noteTitle, String newInput,
      String formatedDate, String diaryTitle) async {
    DocumentReference documentReferencer = _collectionDiaries
        .doc(diaryTitle)
        .collection(_collectionNotes)
        .doc(idNote);
    getCurrentUserId();
    Map<String, dynamic> data = <String, dynamic>{
      'title': noteTitle,
      'date': formatedDate,
      'text': newInput,
    };
    documentReferencer.update(data);
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getEntryById(
      dynamic idNote, String diaryTitle) {
    DocumentReference<Map<String, dynamic>> notesItemCollection =
        _collectionDiaries
            .doc(diaryTitle)
            .collection(_collectionNotes)
            .doc(idNote);
    return notesItemCollection.snapshots();
  }

  Stream<QuerySnapshot<Object?>> getAllEnrtiesBySelectedDiaryId(
      String selectedDiaryId, String selectedDiaryTitle) {
    getCurrentUserId();
    CollectionReference<Map<String, dynamic>> notesItemCollection =
        _collectionDiaries.doc(selectedDiaryTitle).collection(_collectionNotes);
    return notesItemCollection
        .where('diaryId', isEqualTo: selectedDiaryId)
        .where('author', isEqualTo: _currentUserID)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<void> deleteEntry(String diaryTitle, String idNote) async {
    await _collectionDiaries
        .doc(diaryTitle)
        .collection(_collectionNotes)
        .doc(idNote)
        .delete();
  }

  void singOut() {
    _firebaseAuth.signOut();
  }
}
