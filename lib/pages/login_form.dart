import 'package:appwrite_example/models/note_model.dart';
import 'package:appwrite_example/pages/home.dart';
import 'package:appwrite_example/states/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void initState() {
    usernameTextController.text = 'test01@test.com';
    passwordTextController.text = '123456';
    Provider.of<NoteDataState>(context, listen: false).init();
    super.initState();
  }

  @override
  void dispose() {
    usernameTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  _submitLogin() {
    if ((usernameTextController.text == '') ||
        (passwordTextController.text == '')) {
      return null;
    }
    var appState = Provider.of<NoteDataState>(context, listen: false);
    appState.login(
        username: usernameTextController.text,
        password: passwordTextController.text);
    if (appState.getUserInfo() != '') {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => Home()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login to Appnote',
              style: TextStyle(fontSize: 20, color: Colors.pink),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                autofocus: true,
                controller: usernameTextController,
                decoration: InputDecoration(hintText: 'E-mail'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                autofocus: true,
                obscureText: true,
                controller: passwordTextController,
                decoration: InputDecoration(hintText: 'Password'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MaterialButton(
                onPressed: _submitLogin,
                color: Colors.pink,
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
