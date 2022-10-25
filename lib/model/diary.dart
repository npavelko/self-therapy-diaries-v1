import 'package:flutter/material.dart';

class Diary {
  final String id;
  final String title;
  //final Color color;
  final AssetImage image;

  const Diary({
    required this.id,
    required this.title,
    required this.image,
  });
}
