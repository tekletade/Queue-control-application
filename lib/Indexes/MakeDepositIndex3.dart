import 'package:Liner/consts/globalcolors.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MakeDepositIndex3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Deposit to your Wallet...'),
          foregroundColor: textColor,
          backgroundColor: brandColor,
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              DataPopUp(data[index]),
          itemCount: data.length,
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              //header of the drawer
              UserAccountsDrawerHeader(
                accountName: Text('Tekle Tade'),
                accountEmail: Text('tekle@gmail.com'),
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
                decoration: BoxDecoration(color: Color.fromARGB(255, 2, 87, 5)),
              ),
              //body here
              SizedBox(
                // width: 20,
                // height: 40,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 12, 87, 5),
                        side: BorderSide.none,
                        shape: StadiumBorder()),
                    child: const Text(
                      "Edit Profile",
                    )),
              ),
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
                  leading:
                      Icon(Icons.web, color: Color.fromARGB(255, 5, 206, 5)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DataPopUp extends StatelessWidget {
  const DataPopUp(this.popup);

  final DataList popup;

  Widget _buildTiles(DataList root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return ExpansionTile(
      key: PageStorageKey<DataList>(root),
      title: Text(
        root.title,
      ),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(popup);
  }
}

class DataList {
  DataList(this.title, [this.children = const <DataList>[]]);

  final String title;
  final List<DataList> children;
}

final List<DataList> data = <DataList>[
  DataList(
    'CBE',
    <DataList>[
      DataList('Info'),
      DataList('Others'),
    ],
  ),
  DataList(
    'Agent',
    <DataList>[
      DataList('Agent info'),
      // DataList('HP'),
    ],
  ),
  DataList(
    'Tele Birr',
    <DataList>[
      DataList('nfo' '\nefefef'),
      DataList('Other'),
      DataList('Others'),
    ],
  ),
];

//Book Now
//Get Service Providers/Orgs from the database
//  -Kebele
//    -To take new Id
//    -To Renew ID
//    -To take Marage certficate
//    -To take Birth date Certificate
//    -To withdraw Exit
//  -Migration
//     -For new Passport
//     -To Renew Passport
//  -Bank
//  -Others

// Select * from providers
// Select * from serviceType where service_provider == provider(clicked)