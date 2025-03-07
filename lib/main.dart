import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shoping/bottomNavigation/home_page.dart';
import 'package:shoping/bottomNavigation/bottom_page.dart';

import 'firebase_options.dart';
var scrWidth;
Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    scrWidth =MediaQuery.of(context).size.width;
    return MaterialApp(
      home:BottomPage() ,
      debugShowCheckedModeBanner: false,
    );
  }
}

