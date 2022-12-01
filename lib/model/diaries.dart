import 'package:flutter/material.dart';

class Diary {
  final String id;
  final String title;
  final IconData icon;

  const Diary({
    required this.id,
    required this.title,
    required this.icon,
  });
}

final diaries = [
  const Diary(
    id: 'd1',
    title: 'Emotion Diary',
    icon: Icons.brightness_6,
  ),
  const Diary(
    id: 'd2',
    title: 'Successes Diary',
    icon: Icons.emoji_emotions,
  ),
  const Diary(
    id: 'd3',
    title: 'Dream Diary',
    icon: Icons.bedtime,
  ),
  const Diary(
    id: 'd4',
    title: 'Thanks Diary',
    icon: Icons.spa,
  ),
];
