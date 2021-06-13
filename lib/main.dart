import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:movies/screens/Homepage.dart';
import 'package:movies/screens/bottom_nav_bar.dart';

import 'blocs/home_bloc/home_page_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.montserratTextTheme(),
          primaryColor: Colors.orangeAccent,
          accentColor: Colors.orangeAccent,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            textTheme: GoogleFonts.montserratTextTheme(),
            titleTextStyle: GoogleFonts.montserrat(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        home: BottomNavView()
        // home: MyHomePage(
        //   title: "hello",
        // ),
        );
  }
}
