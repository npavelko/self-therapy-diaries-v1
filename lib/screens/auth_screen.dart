import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:self_therapy_diaries/service/firebase_service.dart';
import 'package:self_therapy_diaries/widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLoading = false;
  String _userId = '';
  final FirebaseService _firebaseService =
      GetIt.instance.get<FirebaseService>();

  void _submitAuthForm(
    String email,
    String password,
    String userName,
    String userLastname,
    bool isLoginMode,
    BuildContext ctx,
  ) async {
    //UserCredential _authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLoginMode) {
        _userId = await _firebaseService.signIn(email, password);
      } else {
        _userId = await _firebaseService.createUser(email, password);
      }
      await _firebaseService.setCollectionUser(
          userName, userLastname, email, _userId);
    } on FirebaseAuthException catch (error) {
      //  catches only PlatformException errors, FirebaseAuth(wrong email, password etc)
      var messege = 'Error occurred, please check your credentials';
      if (error.message != null) {
        messege = error.message!;
      }
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(messege),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        _submitAuthForm,
        _isLoading,
      ),
    );
  }
}
