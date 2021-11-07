import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  late String _userEmail = '';
  late String _userName = '';
  late String _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      _formKey.currentState!.save();
      print(_userEmail);
      print(_userName);
      print(_userPassword);
    }

    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      key: const ValueKey('email'),
                      validator: (email) {
                        const errorMessage =
                            'Please enter a valid address email';

                        if (email == null) {
                          return errorMessage;
                        }
                        if (email.isEmpty) {
                          return errorMessage;
                        }
                        if (!EmailValidator.validate(email)) {
                          return errorMessage;
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                          const InputDecoration(labelText: 'Email address'),
                      onSaved: (newEmail) {
                        _userEmail = newEmail!;
                      },
                      onTap: () {},
                    ),
                    if(!_isLogin)
                    TextFormField(
                      key: const ValueKey('username'),
                      validator: (username) {
                        if (username == null) {
                          return 'Please write username';
                        }
                        if (username.length < 4) {
                          return 'Username is too short, must be at least 4 characters long';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: 'Username'),
                      onSaved: (newUsername) {
                        _userName = newUsername!;
                      },
                      onTap: () {},
                    ),
                    TextFormField(
                      key: const ValueKey('password'),
                      validator: (password) {
                        if (password == null) {
                          return 'Please write password';
                        }
                        if (password.length < 7) {
                          return 'Password is too short, must be at least 7 characters long';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Password'),
                      onSaved: (newPassword) {
                        _userPassword = newPassword!;
                      },
                      onTap: () {},
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: buttonColor(context),
                      child: Text(_isLogin?'Login':'Signup'),
                      onPressed: () {
                        _trySubmit();
                      },
                    ),
                    ElevatedButton(
                      style: buttonColor(context),
                      child:  Text(_isLogin? 'Create new account':'I already have an account'),
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                    )
                  ],
                ))),
      ),
    );
  }

  ButtonStyle buttonColor(BuildContext context) => ElevatedButton.styleFrom(
      primary: Theme.of(context).colorScheme.secondary);
}
