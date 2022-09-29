import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../main.dart';

class DivestCapacity extends StatefulWidget {
  final GoogleSignInAccount user;
  const DivestCapacity({Key? key, required this.title, required this.user})
      : super(key: key);

  final String title;

  @override
  State<DivestCapacity> createState() => _DivestCapacityState();
}

class _DivestCapacityState extends State<DivestCapacity> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  bool? loginState;
  @override
  void initState() {
    super.initState();
    loginState = true;
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    if (loginState != null) {
      if (!loginState!) {
        return MediaQuery(
            data: MediaQueryData(),
            child: MaterialApp(
              home: GoogleLoginApp(),
              debugShowCheckedModeBanner: false,
            ));
      }
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              cursorColor: Colors.black,
              keyboardType: TextInputType.text,
              style: const TextStyle(color: Colors.black, fontSize: 40),
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.black, fontSize: 40),
                border: OutlineInputBorder(),
                //contentPadding:
                //EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                hintText: "Enter amount Rs.",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text('Get money'),
            ),
          ],
        ),
      ),
    );
  }
}
