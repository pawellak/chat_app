import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/widget/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
      String email, String password, String username, bool isLogin) async {
    UserCredential authResult;

    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user!.uid)
          .set({'username': username, 'email': email});

      setState(() {
        _isLoading = false;
      });
    } on FirebaseAuthException catch (error) {
      setState(() {
        _isLoading = false;
      });
      var errorMessage = 'An error occurred. Please check your credentials.';
      if (error.message != null) {
        errorMessage = error.message!;
      }
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(errorMessage),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: AuthForm(
        onSubmit: _submitAuthForm,
        isLoading: _isLoading,
      ),
    );
  }
}
