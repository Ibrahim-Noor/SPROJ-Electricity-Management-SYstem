// import 'dart:js';
import 'package:web_socket/homeScreen.dart';
// import 'package:web_socket/roomUsageData.dart';
import 'package:flutter/material.dart';
import 'package:web_socket/login.dart';
import 'login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // print(G.socketUtil.socket);
  runApp(
    MaterialApp(initialRoute: '/', routes: {
      '/': (context) => LoginScreen(),
      '/homescreen': (context) => HomeScreen(),
      // '/trendsscreen': (context) => (),
      // '/usagelimitscreen': (context) => ChangeLimitScreen(),
    }),
  );
}
