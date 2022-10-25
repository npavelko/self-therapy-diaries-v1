import 'package:flutter/material.dart';

import './model/diary.dart';

final DIARIES = [
  const Diary(
    id: 'd1',
    title: 'Emotion Diary',
    image: AssetImage('assets/images/emotion.jpg'),
  ),
  const Diary(
    id: 'd2',
    title: 'Successes Diary',
    image: AssetImage('assets/images/success.jpg'),
  ),
  const Diary(
    id: 'd3',
    title: 'Dream Diary',
    image: AssetImage('assets/images/dream.jpg'),
  ),
  const Diary(
    id: 'd4',
    title: 'Thanks Diary',
    image: AssetImage('assets/images/thanks_2.jpg'),
  ),
];
