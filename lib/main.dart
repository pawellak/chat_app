import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_chat_app/screens/auth_screen.dart';
import 'package:my_chat_app/screens/loading_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
        future: _initialization,
        builder: (context, appSnapshot) {
          return MaterialApp(
              title: 'FlutterChat',
              theme: ThemeData(
                backgroundColor: Colors.lightGreen,
                buttonTheme: ButtonTheme.of(context).copyWith(
                  buttonColor: Colors.pink,
                  textTheme: ButtonTextTheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                colorScheme: ColorScheme.fromSwatch()
                    .copyWith(secondary: Colors.indigo)
              ),
              home: appSnapshot.connectionState == ConnectionState.done
                  ? const AuthScreen()
                  : const LoadingScreen());
        });
  }
}
