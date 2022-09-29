import 'package:flutter/material.dart';
import './invest_capacity.dart';
import 'divest_capacity.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './give_loan.dart';
import './expire_loans.dart';
import './transactions.dart';
import './get_interest.dart';
import './document_search.dart';
import './homepage.dart';

class Capacity extends StatefulWidget {
  final GoogleSignInAccount user;
  Capacity({Key? key, required this.title, required this.user});
  final String title;

  @override
  State<Capacity> createState() => _CapacityState();
}

class _CapacityState extends State<Capacity> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  bool? loginState;
  @override
  void initState() {
    super.initState();
    loginState = true;
  }

  @override
  Widget build(BuildContext context) {
    GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(
                  child: Text('Invest investment'),
                ),
                Tab(
                  child: Text('Divest investment'),
                ),
              ],
            ),
            title: const Text('Nano Capacity'),
          ),
          body: TabBarView(
            children: [
              InvestCapacity(title: 'Nano-Capacity', user: widget.user),
              DivestCapacity(title: 'Nano-Capacity', user: widget.user),
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
                  tileColor: Colors.blue[100],
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
