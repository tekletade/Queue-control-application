import 'package:flutter/material.dart';
import '../main.dart';
import 'dashboard.dart';
// import 'index1.dart';
import 'index2.dart';
import '../screens/bookService.dart';

class BookNowDashboard extends StatefulWidget {
  const BookNowDashboard({super.key});

  @override
  State<BookNowDashboard> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<BookNowDashboard> {
  int _selectedIndex = 1;
  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // List<Widget> _widgetOptions = <Widget>[
  final List<Widget> _widgetOptions = <Widget>[
    // DashBoard(),
    Index1BookNow(uid),
    QrGenerator(uid),
    Index1BookNow(uid),
    QrGenerator(uid),

    // MyApp(),
  ];

  static String uid = 'uid';
  //    Text(

  //   'Index 0: Home',
  //   style: optionStyle,
  // ),
  // Text(
  //   'Index 1: Business',
  //   style: optionStyle,
  // ),
  // Text(
  //   'Index 2: School',
  //   style: optionStyle,
  // ),
  // ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Book Your Journey...'),
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
            icon: Icon(Icons.book_online),
            label: 'Book Now',
            backgroundColor: Color.fromARGB(255, 2, 87, 5),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: "My QR",
            backgroundColor: Color.fromARGB(255, 2, 87, 5),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done_all),
            label: 'Reserved',
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
