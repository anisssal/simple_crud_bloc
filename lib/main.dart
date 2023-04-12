import 'dart:io';

import 'package:flutter/material.dart';
import 'package:simple_crud_bloc/ui/posts/posts_screen.dart';

import 'locator.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  setupLocator();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  //for simplicity we don't use onGenerateRoute, instead using classic routing
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'PKP Test',
      home: PostScreen(),
    );
  }
}


