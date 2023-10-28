import 'package:Liner/Indexes/ProvidersGrid.dart';
import 'package:flutter/material.dart';
// import 'plusminus.dart';

// import '../Indexes/dropdown.dart';

class Index1BookNow extends StatelessWidget {
  String uid;
  Index1BookNow(this.uid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Your Service...'),
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 2, 87, 5),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Color.fromARGB(255, 2, 87, 5),
            Color.fromARGB(255, 2, 87, 5),
            Color.fromARGB(255, 2, 87, 5)
          ]),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 2,
            ),
            Expanded(
              child: Container(
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(400),
                    )),
                // child: const Text(
                //   '\nIndex1!',
                //   style: TextStyle(
                //       fontSize: 34,
                //       color: Color.fromARGB(255, 2, 87, 5),
                //       fontWeight: FontWeight.bold),
                // ),
                child: ProvidersGrid(uid),
                // child: PlusMinus(),
              ),
            ),
          ],
        ),
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            //header of the drawer
            new UserAccountsDrawerHeader(
              accountName: Text('Tekle Tade'),
              accountEmail: Text('tekle@gmail.com'),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
              decoration:
                  new BoxDecoration(color: Color.fromARGB(255, 2, 87, 5)),
            ),
            //body here
            InkWell(
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => new MyApp()));
              },
              child: ListTile(
                title: Text('Home'),
                leading:
                    Icon(Icons.home, color: Color.fromARGB(255, 6, 177, 12)),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('My Account'),
                leading: Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 6, 177, 12),
                ),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Wallet'),
                leading: Icon(
                  Icons.wallet,
                  color: Color.fromARGB(255, 6, 177, 12),
                ),
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Support Contact'),
                leading: Icon(
                  Icons.contact_phone,
                  color: Color.fromARGB(255, 6, 177, 12),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                // Hover.toggleDrawer(context);
              },
              child: ListTile(
                title: Text('About Us'),
                leading: Icon(
                  Icons.help,
                  color: Color.fromARGB(255, 6, 177, 12),
                ),
              ),
            ),

            Divider(),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Settings'),
                leading: Icon(
                  Icons.settings,
                  color: Colors.blue,
                ),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Website'),
                leading: Icon(Icons.web, color: Color.fromARGB(255, 5, 206, 5)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
