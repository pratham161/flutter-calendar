import 'package:calender/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:googleapis/calendar/v3.dart' hide Colors;

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  var currentUser;
  List<String> clientEvents = [];
  GoogleSignIn googleSignIn = GoogleSignIn(
    clientId:
        '626854110759-qqlgrm63ecjifjv77coobv0l7nbipl7t.apps.googleusercontent.com',
    scopes: [CalendarApi.calendarReadonlyScope],
  );

  Future<void> getEventsData() async {
    googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        currentUser = account;
      });
      if (currentUser != null) {
        getCalEvents();
      }
    });
  }

  Future<void> getCalEvents() async {
    final authClient = await googleSignIn.authenticatedClient();
    final calendarApi = CalendarApi(authClient!);
    final events = calendarApi.events.list("primary");
    setState(() {
      clientEvents = events as List<String>;
      print(clientEvents);
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'WELCOME',
              style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            FlatButton(
              color: Colors.indigo,
              onPressed: () async {
                await googleSignIn.signIn();
              },
              child: Text(
                'Sign up with google',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
