import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import './Screens/homepage.dart';

void main() {
  runApp(GoogleLoginApp());
}

class GoogleLoginApp extends StatefulWidget {
  const GoogleLoginApp({Key? key}) : super(key: key);

  @override
  _GoogleLoginAppState createState() => _GoogleLoginAppState();
}

class _GoogleLoginAppState extends State<GoogleLoginApp> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? user = _googleSignIn.currentUser;
    if (user != null) {
      return MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(
              home: MyHomePage(
            title: 'Welcome Nano-finance',
            user: user,
          )));
    } else {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text(('Nano-finance')),
          ),
          body: Center(
            child: Column(
              children: [
                // Image.network(
                //     'https://appinventiv.com/wp-content/uploads/sites/1/2022/07/How-Much-Does-it-Cost-to-Build-a-Loan-Lending-App-scaled.webp'),
                Image.asset('assets/images/homepage_logo.webp'),
                Container(
                  child: Text(
                    'Welcome to Nano-finance',
                    style: TextStyle(
                        fontSize: 25,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color:
                            Color.fromARGB(255, 9, 88, 153).withOpacity(0.8)),
                  ),
                  width: double.infinity,
                  height: 85.0,
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(35.0),
                ),
                SignInButton(
                  Buttons.Google,
                  text: "Continue with Google",
                  onPressed: () async {
                    await _googleSignIn.signIn();
                    setState(() {});
                  },
                ),
                SignInButton(
                  Buttons.Facebook,
                  text: "Continue up with Facebook",
                  onPressed: () {},
                ),
                SignInButton(
                  Buttons.GitHub,
                  text: "Continue up with GitHub",
                  onPressed: () {},
                )
              ],
            ), // Column
          ),
        ),
        debugShowCheckedModeBanner: false,
      );
    }
  }
}
