import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import './Screens/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quickalert/quickalert.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const GoogleLoginApp());
}

class GoogleLoginApp extends StatefulWidget {
  const GoogleLoginApp({Key? key}) : super(key: key);

  @override
  _GoogleLoginAppState createState() => _GoogleLoginAppState();
}

class _GoogleLoginAppState extends State<GoogleLoginApp> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? user = _googleSignIn.currentUser;

    if (user != null) {
      return MediaQuery(
          data: const MediaQueryData(),
          child: MaterialApp(
              home: MyHomePage(
            title: 'Welcome Nano-finance',
            user: user,
          )));
    } else {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text(('Nano-finance')),
          ),
          body: Center(
            child: Column(
              children: [
                // Image.network(
                //     'https://appinventiv.com/wp-content/uploads/sites/1/2022/07/How-Much-Does-it-Cost-to-Build-a-Loan-Lending-App-scaled.webp'),
                Image.asset('assets/images/homepage_logo.webp'),
                Container(
                  padding: const EdgeInsets.all(50.0),
                  child: const Text('Welcome to Nano Finance'),
                ),

                SignInButton(
                  Buttons.Google,
                  text: "Continue with Google",
                  onPressed: () async {
                    try {
                      await _googleSignIn.signIn();
                    } catch (error) {
                      print('netowrk error {$error}');
                    }
                    setState(() {});
                  },
                ),
              ],
            ), // Column
          ),
        ),
        debugShowCheckedModeBanner: false,
      );
    }
  }
}
