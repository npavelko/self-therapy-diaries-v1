import 'package:flutter/material.dart';

class MyFloatingActionButton extends StatelessWidget {
  Icon _icon;
  Function() _function;

  MyFloatingActionButton(this._icon, this._function);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: _icon,
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: _function,
    );
  }
}
