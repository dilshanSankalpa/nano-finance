import 'package:flutter/material.dart';
import 'package:nano_finance_/Screens/get_transaction.dart';
import 'package:nano_finance_/Screens/put_transactions.dart';
import './give_loan.dart';
import './expire_loans.dart';
import './capacity.dart';
import './get_interest.dart';
import './document_search.dart';
import './homepage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../main.dart';

class Transactions extends StatefulWidget {
  final GoogleSignInAccount user;
  const Transactions({Key? key, required this.title, required this.user})
      : super(key: key);

  final String title;

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  late bool loginState;
  List transactions = [];
  @override
  void initState() {
    super.initState();
    loginState = true;
  }

  @override
  Widget build(BuildContext context) {
    if (loginState != null) {
      if (!loginState) {
        return const MediaQuery(
            data: MediaQueryData(), child: MaterialApp(home: GoogleLoginApp()));
      }
    }
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(
                  child: Text('Put transactions'),
                ),
                Tab(
                  child: Text('Get transactions'),
                ),
              ],
            ),
            title: const Text('Nano Transactions'),
          ),
          body: TabBarView(
            children: [
              PutTransaction(title: 'Nano-Put-Transaction', user: widget.user),
              GetTransaction(title: 'Nano-Get-Transaction', user: widget.user),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.blue),
                  accountName: Text(
                    "${widget.user.displayName}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  accountEmail: Text(
                    "${widget.user.email}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(widget.user.photoUrl ?? ''),
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
                        builder: (context) => MyHomePage(
                            title: 'Nano-Finance', user: widget.user),
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
                  leading: const Icon(
                    Icons.receipt,
                  ),
                  title: const Text('Get Interest'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => GetInterest(
                            title: 'Nano-Interest', user: widget.user),
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
                            title: 'Nano-Expires', user: widget.user),
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
                  tileColor: Colors.blue[100],
                  leading: const Icon(
                    Icons.point_of_sale,
                  ),
                  title: const Text('Transactions'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Transactions(
                          title: 'Nano-Transactions',
                          user: widget.user,
                        ),
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
                          title: 'Nano-Document',
                          user: widget.user,
                        ),
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
        ),
      ),
    );
  }
}
