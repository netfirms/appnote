import 'package:appwrite_example/pages/login_form.dart';
import 'package:appwrite_example/states/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NoteDataState>(create: (_) => NoteDataState()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SimpleNote Appwrite',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginForm(),
      ),
    );
  }
}
