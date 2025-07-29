import 'package:flutter/material.dart';
import 'intro_page.dart';

void main() {
  runApp(ToxicWastePredictorApp());
}

class ToxicWastePredictorApp extends StatelessWidget {
  const ToxicWastePredictorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toxic Waste Predictor',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: IntroPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
 