import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../main.dart';

class FullDurationExpireLoans extends StatefulWidget {
  final GoogleSignInAccount user;
  const FullDurationExpireLoans(
      {Key? key, required this.title, required this.user})
      : super(key: key);

  final String title;

  @override
  State<FullDurationExpireLoans> createState() =>
      _FullDurationExpireLoansState();
}

class _FullDurationExpireLoansState extends State<FullDurationExpireLoans> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  bool? loginState;
  @override
  void initState() {
    super.initState();
    loginState = true;
  }

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
      body: ListView(
        children: [
          Card(
            child: ListTile(
              // leading: FlutterLogo(size: 72.0),
              title: Text('Somapala ranathunga'),
              subtitle: Text(
                  'No 203, Galle road, Matara, Sri Lanka, 81000, 0771234567'),
              trailing: Icon(Icons.arrow_forward_ios),
              isThreeLine: true,
            ),
          ),
          Card(
            child: ListTile(
              // leading: FlutterLogo(size: 72.0),
              title: Text('Somapala ranathunga'),
              subtitle: Text(
                  'No 203, Galle road, Matara, Sri Lanka, 81000, 0771234567'),
              trailing: Icon(Icons.arrow_forward_ios),
              isThreeLine: true,
            ),
          ),
        ],
      ),
    );
  }
}
