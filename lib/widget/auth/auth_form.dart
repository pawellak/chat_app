import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email address'),
                  onTap: () {},
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Username'),
                  onTap: () {},
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: buttonColor(context),
                  child: const Text('Login'),
                  onPressed: () {},
                ),
                ElevatedButton(
                  style: buttonColor(context),
                  child: const Text('Create new account'),
                  onPressed: () {},
                )
              ],
            ))),
      ),
    );
  }

  ButtonStyle buttonColor(BuildContext context) => ElevatedButton.styleFrom(
      primary: Theme.of(context).colorScheme.secondary);
}
