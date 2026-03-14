import 'package:flutter/material.dart';
import 'screens/feed_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '662115019 Individual Project',
      theme: ThemeData.from(
        colorScheme: const ColorScheme.light(primary: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: const FeedScreen(),
    );
  }
}
