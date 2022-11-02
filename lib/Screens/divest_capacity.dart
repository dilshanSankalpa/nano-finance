import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';

class DivestCapacity extends StatefulWidget {
  final GoogleSignInAccount user;
  const DivestCapacity({Key? key, required this.title, required this.user})
      : super(key: key);

  final String title;

  @override
  State<DivestCapacity> createState() => _DivestCapacityState();
}

class _DivestCapacityState extends State<DivestCapacity> {
  bool? loginState;
  @override
  void initState() {
    super.initState();
    loginState = true;
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController amount = TextEditingController();
  TextEditingController description = TextEditingController();

  CollectionReference investmentRef =
  FirebaseFirestore.instance.collection('divest');

  Future<void> addDivest() {
    // Call the user's CollectionReference to add a new user
    return investmentRef
        .add({
      'amount': amount.text,
      'description': description.text,
      'userId': widget.user.id,
      'date': DateTime.now()
    })
        .then((value) => {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Divest is added')),),
      amount.clear(),
      description.clear()

    })
        .catchError((error) => {
      print("Failed to add Investment: $error"),
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Something is gone wrong')),)
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loginState != null) {
      if (!loginState!) {
        return const MediaQuery(
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
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: amount,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number';
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
                      hintText: "Amount Rs.",
                    ),
                  ),
                  TextFormField(
                    controller: description,
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
                      hintText: "Description",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print(widget.user.id);
                      // Validate returns true if the form is valid, or false otherwise.

                      if (_formKey.currentState!.validate()) {
                        addDivest();
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('processing Data')));
                      } else {
                        print("Invalid");
                      }
                    },
                    child: const Text('Get money'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
