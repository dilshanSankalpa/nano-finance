import 'package:flutter/material.dart';
import './give_loan.dart';
import './expire_loans.dart';
import './capacity.dart';
import './transactions.dart';
import './get_interest.dart';
import './document_search.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.user})
      : super(key: key);
  final GoogleSignInAccount user;
  final String title;
  final capacity = 1000;
  final loss = 20.9;
  final balance = 300;
  final totalLoans = 100;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  late bool loginState;
  @override
  void initState() {
    super.initState();
    loginState = true;
  }

  @override
  Widget build(BuildContext context) {
    if (loginState != null) {
      if (!loginState) {
        return MediaQuery(
            data: MediaQueryData(),
            child: MaterialApp(
              home: GoogleLoginApp(),
              debugShowCheckedModeBanner: false,
            ));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(255, 31, 184, 204),
                          spreadRadius: 3),
                    ],
                  ),
                  height: 100,
                  padding: const EdgeInsets.all(18.0),
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(
                    'Total Capacity : Rs.${widget.capacity.toString()}',
                    style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(color: Colors.blueGrey, spreadRadius: 3),
                      ],
                    ),
                    height: 100,
                    padding: const EdgeInsets.all(18.0),
                    width: MediaQuery.of(context).size.width / 2,
                    child: Text(
                      'Balance : Rs.${widget.balance.toString()}',
                      style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(255, 31, 184, 204),
                            spreadRadius: 3),
                      ],
                    ),
                    height: 100,
                    width: MediaQuery.of(context).size.width / 2,
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'Total Loans : Rs.${widget.totalLoans.toString()}',
                      style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(255, 31, 184, 204),
                            spreadRadius: 3),
                      ],
                    ),
                    height: 100,
                    padding: const EdgeInsets.all(18.0),
                    width: MediaQuery.of(context).size.width / 2,
                    child: Text(
                      'Total loss :  Rs.${widget.loss.toString()}',
                      style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              accountName: Text(
                "${widget.user?.displayName}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                "${widget.user?.email}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(widget.user?.photoUrl ?? ''),
              ),
            ),
            ListTile(
              tileColor: Colors.blue[100],
              leading: const Icon(
                Icons.home,
              ),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.local_atm,
              ),
              title: const Text('Give Loan'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => GiveLoan(
                      title: 'Nano-Loan',
                      user: widget.user,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.receipt,
              ),
              title: const Text('Get Interest'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        GetInterest(title: 'Nano-Interest', user: widget.user),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.report,
              ),
              title: const Text('Expire Loans'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ExpireLoans(
                      title: 'Nano-Expires',
                      user: widget.user,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.pending_actions,
              ),
              title: const Text('Capacity'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        Capacity(title: 'Nano-Capacity', user: widget.user),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.point_of_sale,
              ),
              title: const Text('Transactions'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        Transactions(title: 'Nano-Loan', user: widget.user),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.person_search,
              ),
              title: const Text('Document search'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DocumentSearch(
                        title: 'Nano-Document', user: widget.user),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
              ),
              title: const Text('Logout'),
              onTap: () async {
                await _googleSignIn.signOut();
                setState(() {
                  loginState = false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
