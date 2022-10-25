import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

class FirebaseService {
  static String userID = _firebaseAuth.currentUser!.uid;
  final String _collectionUsers = 'users';
  final String _collectionPathNotes = 'diaries/puPc9k88E83sJRPx7lXc/notes';
  final CollectionReference _diariesCollection =
      _firebaseFirestore.collection('diaries');
  //final String _diaries = 'diaries';

  //final String _notesCollection = 'notes';
  //String _collectionPathNotesTest = '';

  Future<String> signIn(String email, String password) async {
    UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    User? user = result.user;
    return user!.uid;
  }

  String getIdColl() {
    String idDiariesColl = _firebaseFirestore.collection('diaries').id;
    //_collectionPathNotesTest = idDiariesColl;
    return idDiariesColl;
  }

  Future<String> createUser(String email, String password) async {
    UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    User? user = result.user;
    return user!.uid;
  }

  Future<void> setCollectionUser(
      String userName, String userLastname, String email, String userId) async {
    _firebaseFirestore.collection(_collectionUsers).doc(userId).set({
      'username': userName,
      'userLastname': userLastname,
      'email': email,
    });
  }

  Future<void> singOut() async {
    _firebaseAuth.signOut();
  }

  Future<void> saveEntry(String diaryId, String diaryTitle, String noteTitle,
      DateTime date, String input, String formattedDate) async {
    DocumentReference documentReferencer =
        _diariesCollection.doc(diaryTitle).collection('notes').doc();

    Map<String, dynamic> data = <String, dynamic>{
      'diaryId': diaryId,
      'diaryTitle': diaryTitle,
      'title': noteTitle,
      'date': formattedDate,
      'text': input,
    };
    /* _firebaseFirestore
        .collection(_diaries)
        .firestore
        .collection('notes')
        .add(data); */

    documentReferencer.set(data);
    /* _firebaseFirestore.collection(_collectionPathNotes).add({
      'diaryId': diaryId,
      'diaryTitle': diaryTitle,
      'title': noteTitle,
      'date': formattedDate,
      'text': input,
    }); */
  }

  Future<void> updateEnrty(String idNote, String noteTitle, String newInput,
      String formatedDate, String diaryTitle) async {
    DocumentReference documentReferencer =
        _diariesCollection.doc(diaryTitle).collection('notes').doc(idNote);
    Map<String, dynamic> data = <String, dynamic>{
      'title': noteTitle,
      'date': formatedDate,
      'text': newInput,
    };

    documentReferencer.update(data);
    /* FirebaseFirestore.instance
        .collection(_collectionPathNotes)
        .doc(idNote)
        .update({
      'title': noteTitle,
      'date': formatedDate,
      'text': newInput,
    }); */
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getNoteById(
      dynamic idNote, String diaryTitle) {
    DocumentReference<Map<String, dynamic>> notesItemCollection =
        _diariesCollection.doc(diaryTitle).collection('notes').doc(idNote);

    return notesItemCollection.snapshots();
  }

  /*  Future<QuerySnapshot<Map<String, dynamic>>> getChild() async {
    // хз шо пока
    Future<QuerySnapshot<Map<String, dynamic>>> snapshots =
        _firebaseFirestore.collection(_collectionPathNotes).get();
    return snapshots;
  } */

  /* Future createDieriesColl(){
    _firebaseFirestore.
  } */

  Stream<QuerySnapshot<Object?>> getAllEnrtiesBySelectedDiaryId(
      String selectedDiaryId, String selectedDiaryTitle) {
    CollectionReference<Map<String, dynamic>> notesItemCollection =
        _diariesCollection.doc(selectedDiaryTitle).collection('notes');

    return notesItemCollection
        .where('diaryId', isEqualTo: selectedDiaryId)
        .snapshots();
  }

  Future<void> deleteEntry(String idNote) async {
    FirebaseFirestore.instance
        .collection(_collectionPathNotes)
        .doc(idNote)
        .delete();
  }
}
