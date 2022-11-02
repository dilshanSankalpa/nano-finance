import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InvestCapacity extends StatefulWidget {
  final GoogleSignInAccount user;
  const InvestCapacity({Key? key, required this.title, required this.user})
      : super(key: key);

  final String title;

  @override
  State<InvestCapacity> createState() => _InvestCapacityState();
}

class _InvestCapacityState extends State<InvestCapacity> {
  bool? loginState;
  @override
  void initState() {
    super.initState();
    loginState = true;
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController amount = TextEditingController();
  TextEditingController description = TextEditingController();
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

    CollectionReference investmentRef =
        FirebaseFirestore.instance.collection('investment');

    Future<void> addInvenstment() {
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
      const SnackBar(content: Text('Investment is added')),),
        amount.clear(),
        description.clear()

      })
          .catchError((error) => {
        print("Failed to add Investment: $error"),
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something is gone wrong')),)
      });
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
                      if (double.parse(value) < 0) {
                        return 'Please enter a positive number';
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
                        print("valid data");
                        print(amount.text);
                        print(description.text);

                        addInvenstment();

                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.

                      } else {
                        print("Invalid");
                      }
                    },
                    child: const Text('Put money'),
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
