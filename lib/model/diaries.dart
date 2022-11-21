import 'package:flutter/material.dart';

class Diary {
  final String id;
  final String title;
  final LinearGradient linearGradient;
  final IconData icon;

  const Diary({
    required this.id,
    required this.title,
    required this.linearGradient,
    required this.icon,
  });
}

final diaries = [
  Diary(
    id: 'd1',
    title: 'Emotion Diary',
    linearGradient: LinearGradient(
      colors: [
        const Color(0xa3673ab7).withOpacity(0.45),
        const Color(0xff00d1eb).withOpacity(0.45),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    icon: Icons.brightness_6,
  ),
  Diary(
    id: 'd2',
    title: 'Successes Diary',
    linearGradient: LinearGradient(
      colors: [
        const Color(0xff47a44b).withOpacity(0.45),
        const Color(0xffffeb3b).withOpacity(0.45),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    icon: Icons.emoji_emotions,
  ),
  Diary(
    id: 'd3',
    title: 'Dream Diary',
    linearGradient: LinearGradient(
      colors: [
        const Color(0xff62edff).withOpacity(0.45),
        const Color(0xff47a44b).withOpacity(0.45),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    icon: Icons.bedtime,
  ),
  Diary(
    id: 'd4',
    title: 'Thanks Diary',
    linearGradient: LinearGradient(
      colors: [
        const Color(0xffffeb3b).withOpacity(0.45),
        const Color(0xff551560).withOpacity(0.45)
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    icon: Icons.spa,
  ),
];
