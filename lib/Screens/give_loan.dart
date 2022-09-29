import 'package:flutter/material.dart';
import './homepage.dart';
import './expire_loans.dart';
import './capacity.dart';
import './transactions.dart';
import './get_interest.dart';
import './document_search.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../main.dart';

class GiveLoan extends StatefulWidget {
  final GoogleSignInAccount user;
  const GiveLoan({Key? key, required this.title, required this.user})
      : super(key: key);

  final String title;

  @override
  State<GiveLoan> createState() => _GiveLoanState();
}

class _GiveLoanState extends State<GiveLoan> {
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
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: Center(
        child: ListView(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Inflaction',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Loan amount',
              ),
            ),
            DropdownButton<String>(
              items: <String>[
                '1 Month',
                '3 Month',
                '6 Month',
                '1 Year',
                '2 Year',
                '3 Year',
                '5 Year'
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (_) {
                //when changing set the state as value
              },
              hint: Text('Select the duration of the loan'),
            ),
            Text('Future value of the loan'),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Interest',
              ),
            ),
            Text('Your revenue'),
            Text('Your profit'),
            Text('Enter customer Details'),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Customer Name',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Contact No',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Address',
              ),
            ),
            
            Text('Enter Document Details'),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Book No',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Page No',
              ),
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
              leading: const Icon(
                Icons.home,
              ),
              title: const Text('Home'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) =>
                          MyHomePage(title: 'Nano-Finance', user: widget.user)),
                );
              },
            ),
            ListTile(
              tileColor: Colors.blue[100],
              leading: const Icon(
                Icons.local_atm,
              ),
              title: const Text('Give Loan'),
              onTap: () {
                Navigator.pop(context);
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
                    builder: (context) =>
                        ExpireLoans(title: 'Nano-Expires', user: widget.user),
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
                        Capacity(title: 'Nano-Loan', user: widget.user),
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
                    builder: (context) => Transactions(
                        title: 'Nano-Transactions', user: widget.user),
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
