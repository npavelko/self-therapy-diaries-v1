import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:self_therapy_diaries/main.dart';
import 'package:self_therapy_diaries/service/firebase_service.dart';

class FieldSettingsScreen extends StatefulWidget {
  static const String routeName = '/field-settings-route';
  final String data;

  FieldSettingsScreen({Key? key, required this.data}) : super(key: key);
  @override
  State<FieldSettingsScreen> createState() => _FieldSettingsScreenState();
}

class _FieldSettingsScreenState extends State<FieldSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    String _dataToUpdate = widget.data;
    String _enteredText = '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Enter new $_dataToUpdate'),
        actions: [
          IconButton(
            onPressed: () {
              switch (_dataToUpdate) {
                case 'name':
                  GetIt.instance
                      .get<FirebaseService>()
                      .changeUserName(_enteredText);
                  Navigator.pop(context);
                  Fluttertoast.showToast(msg: 'New $_dataToUpdate saved');
                  break;
                case 'lastname':
                  GetIt.instance
                      .get<FirebaseService>()
                      .changeUserLastname(_enteredText);
                  Navigator.pop(context);
                  Fluttertoast.showToast(msg: 'New $_dataToUpdate saved');
                  break;
                case 'email':
                  GetIt.instance
                      .get<FirebaseService>()
                      .changeUserEmail(_enteredText);
                  Navigator.pop(context);
                  Fluttertoast.showToast(msg: 'New $_dataToUpdate saved');
                  break;
              }
            },
            icon: const Icon(Icons.done),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(children: [
          TextFormField(
            autofocus: true,
            onChanged: (value) {
              _enteredText = value;
            },
            decoration: InputDecoration(
            
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: MyApp.colorMain, width: 1.0)),
              labelText: 'type new $_dataToUpdate here',
              
            ),
            maxLines: 1,
          ),
        ]),
      ),
    );
  }
}
