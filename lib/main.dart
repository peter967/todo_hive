import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'pages/home_page.dart';

void main() async {
  //int hive
  await Hive.initFlutter();
  //open hive box
  var box = await Hive.openBox('mybox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
