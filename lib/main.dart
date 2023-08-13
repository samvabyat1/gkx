// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'home.dart';

late Box box;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  box = await Hive.openBox('box');


  runApp(MaterialApp(
    theme: ThemeData(useMaterial3: true,
      primaryColor: Color(0xffeeedf5),
      textTheme: TextTheme(
          bodyMedium: TextStyle(
        color: Colors.grey,
      )),
      scaffoldBackgroundColor: Color(0xffffffff),
      iconTheme: IconThemeData(
        color: Colors.black87,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xffeeedf5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          )),
    ),
    darkTheme: ThemeData(useMaterial3: true,
      primaryColor: Color(0xff323232),
      textTheme: TextTheme(
          bodyMedium: TextStyle(
        color: Colors.white70,
      )),
      scaffoldBackgroundColor: Color(0xff121212),
      iconTheme: IconThemeData(
        color: Colors.white70,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xff323232),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          )),
    ),
    themeMode: ThemeMode.system,
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}
