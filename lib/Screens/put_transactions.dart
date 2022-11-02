import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String timeStampToDate(timestamp) {
  // print(timestamp);
  var tsdate = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return "${tsdate.year}/${tsdate.month}/${tsdate.day}";
}

class PutTransaction extends StatefulWidget {
  final String title;

  final GoogleSignInAccount user;

  const PutTransaction({Key? key, required this.title, required this.user})
      : super(key: key);
  @override
  State<PutTransaction> createState() => _PutTransactionState();
}

class _PutTransactionState extends State<PutTransaction> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('investment')
            .where('userId', isEqualTo: widget.user.id)
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((document) {
              return Card(
                child: ListTile(
                  title: Text('Put : Rs. ${document['amount']}'),
                  subtitle: Text(
                      "${document['description']}, ${timeStampToDate(document['date'].millisecondsSinceEpoch)}"),
                  isThreeLine: true,
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
