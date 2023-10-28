import 'package:Liner/consts/globalcolors.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'Indexes/dashboard.dart';
// import 'Indexes/index1.dart';
import 'Indexes/index2.dart';
import 'screens/bookService.dart';

import 'Indexes/MakeDepositIndex3.dart';

class BottomNav extends StatefulWidget {
  String fname, lname, phone, uid;
  BottomNav(this.fname, this.lname, this.uid, this.phone);

  @override
  State<BottomNav> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<BottomNav> {
  int _selectedIndex = 0;

  static String fname = fname, lname = lname, phone = phone, uid = uid;

  final List<Widget> _widgetOptions = <Widget>[
    DashBoard(fname, lname, uid, phone),
    QrGenerator(uid),
    MakeDepositIndex3(),
    MakeDepositIndex3(),
    QrGenerator(uid),

    // MyApp(),
  ];

  // static String fname = "fname";
  // static String lname = "lname";
  // static String phone = "phone";
  // static String uid = "uid";

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Book Your Journey...' + widget.fname),
      //   foregroundColor: Colors.white,
      //   backgroundColor: Color.fromARGB(255, 2, 87, 5),
      // ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,

        backgroundColor: Colors.green,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 2, 87, 5),
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: "My QR",
            backgroundColor: Color.fromARGB(255, 2, 87, 5),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online),
            label: 'Others',
            backgroundColor: Color.fromARGB(255, 2, 87, 5),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_bitcoin),
            label: 'Make Deposit',
            backgroundColor: Color.fromARGB(255, 2, 87, 5),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My Account',
            backgroundColor: Color.fromARGB(255, 2, 87, 5),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        // unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
