import 'package:flutter/material.dart';
import './give_loan.dart';
import './expire_loans.dart';
import './capacity.dart';
import './transactions.dart';
import './document_search.dart';
import './homepage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../main.dart';

class GetInterest extends StatefulWidget {
  final GoogleSignInAccount user;
  const GetInterest({Key? key, required this.title, required this.user})
      : super(key: key);

  final String title;

  @override
  State<GetInterest> createState() => _GetInterestState();
}

class _GetInterestState extends State<GetInterest> {
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
      body: ListView(
        children: [
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
              labelText: 'Search Customer Name',
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
                        MyHomePage(title: 'Nano-Expires', user: widget.user),
                  ),
                );
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
                    builder: (context) =>
                        GiveLoan(title: 'Nano-Loan', user: widget.user),
                  ),
                );
              },
            ),
            ListTile(
              tileColor: Colors.blue[100],
              leading: const Icon(
                Icons.receipt,
              ),
              title: const Text('Get Interest'),
              onTap: () {
                Navigator.pop(context);
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
