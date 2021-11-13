import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/widget/pickers/user_image_picker.dart';
import 'dart:io';

class AuthForm extends StatefulWidget {
  final bool isLoading;
  final void Function(
      String email, String password, String username,File? image, bool isLogin) onSubmit;

  const AuthForm({Key? key, required this.onSubmit, required this.isLoading})
      : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  late String _userEmail = '';
  late String _userName = '';
  late String _userPassword = '';
  File? _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();

    if (_userImageFile == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please pick an image')));
      return;
    }

    if (isValid) {
      _formKey.currentState!.save();
      widget.onSubmit(
          _userEmail.trim(), _userPassword.trim(), _userName.trim(),_userImageFile,_isLogin);
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
                    if (!_isLogin)
                      UserImagePicker(
                        imagePickFn: _pickedImage,
                      ),
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
                    if (!_isLogin)
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
                        decoration:
                            const InputDecoration(labelText: 'Username'),
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
                    if (widget.isLoading) const CircularProgressIndicator(),
                    if (!widget.isLoading)
                      ElevatedButton(
                        style: buttonColor(context),
                        child: Text(_isLogin ? 'Login' : 'Signup'),
                        onPressed: () {
                          _trySubmit();
                        },
                      ),
                    if (!widget.isLoading)
                      ElevatedButton(
                        style: buttonColor(context),
                        child: Text(_isLogin
                            ? 'Create new account'
                            : 'I already have an account'),
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
