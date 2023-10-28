import 'package:Liner/Indexes/readQR.dart';
import 'package:Liner/Indexes/reservedQw.dart';
import 'package:Liner/Indexes/slide.dart';
import 'package:flutter/material.dart';
import 'ProvidersGrid.dart';
import 'index1.dart';
import 'index2.dart';
import '../defaultPage.dart';
import 'QrDashboard.dart';
import 'index1.dart';
import 'HomeDashboard.dart';
import 'BookNowDashboard.dart';
//import '../qrgenerator.dart';

import 'package:card_swiper/card_swiper.dart';

class DashBoard extends StatelessWidget {
  String fname, lname, phone, uid; //this.loginphone
  DashBoard(this.fname, this.lname, this.uid, this.phone);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Liner App..." + this.fname),
          // foregroundColor: Colors.white,
          backgroundColor: Color.fromARGB(255, 2, 87, 5),
        ),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              //header of the drawer
              new UserAccountsDrawerHeader(
                accountName: Text(this.fname + " " + this.lname),
                accountEmail: Text(this.phone),
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
              //Drawer body here
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => new DefaultPage()));
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
// body starts here
        body: Container(
          // padding: const EdgeInsets.all(0.0),
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
              Expanded(
                child: SingleChildScrollView(
                    child: Column(children: [
                  SizedBox(
                    height: size.height * 0.25,
                    child: Swiper(
                      itemCount: 3,
                      itemBuilder: (ctx, index) {
                        return const Slide();
                      },
                      autoplay: true,
                      pagination: const SwiperPagination(
                          alignment: Alignment.bottomCenter,
                          builder: DotSwiperPaginationBuilder(
                              color: Colors.white,
                              activeColor: Color.fromARGB(255, 12, 87, 5))),
                      // control: const SwiperControl(),
                    ),
                  ),
                  Container(
                    // constraints: BoxConstraints.expand(),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(200, 230, 201, 1),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(400),
                        )),
                    // padding: EdgeInsets.only(
                    //   left: 10,
                    //   right: 10,
                    // ),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      children: <Widget>[
                        // MyMenu(
                        //   title: 'Home',
                        //   icon: Icons.home,
                        //   onTap: () {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) => HomeDashboard(),
                        //         ));
                        //   },
                        //   // mcolor: Colors.green,
                        // ),
                        MyMenu(
                          title: 'Book Now',
                          icon: Icons.book_online,
                          onTap: () {
                            String uid = this.uid;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  // builder: (context) => BookNowDashboard(),
                                  builder: (context) => ProvidersGrid(uid),
                                ));
                          },
                          // mcolor: Colors.green,
                        ),
                        MyMenu(
                          title: 'QR ID',
                          icon: Icons.qr_code,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      QrDashboard(uid, fname, lname, phone),
                                ));
                          },
                          // mcolor: Colors.green,
                        ),
                        MyMenu(
                          title: 'Reserved Que',
                          icon: Icons.book_sharp,
                          onTap: () {
                            String uid = this.uid;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => reservedQw(uid),
                                ));
                          },
                          // mcolor: Colors.green,
                        ),

                        MyMenu(
                          title: 'My Account',
                          icon: Icons.person_add,
                          onTap: () {
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) => Index0DashBoard(),
                            //       ));
                          },
                          // mcolor: Colors.green,
                        ),
                        MyMenu(
                          title: 'Agent',
                          icon: Icons.support_agent_outlined,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReadQR(uid),
                                ));
                          },
                          // mcolor: Colors.green,
                        ),
                        MyMenu(
                          title: 'Admin',
                          icon: Icons.admin_panel_settings,
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => ReadQR(uid),
                            //     ));
                          },
                          // mcolor: Colors.green,
                        ),
                        MyMenu(
                          title: 'Wallet',
                          icon: Icons.wallet,
                          onTap: () {
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) => Index0DashBoard(),
                            //       ));
                          },
                          // mcolor: Colors.green,
                        ),
                        MyMenu(
                          title: 'Make Deposit',
                          icon: Icons.currency_bitcoin_outlined,
                          onTap: () {
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) => Index0DashBoard(),
                            //       ));
                          },
                          // mcolor: Colors.green,
                        ),
                      ],
                    ),
                  ),
                ])),
              ),
            ],
          ),
          // ),
        ));
  }
}

class MyMenu extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  // final MaterialColor mcolor;

  const MyMenu({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
    // required this.mcolor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.green,
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              size: 70.0,
              color: Color.fromARGB(255, 12, 87, 5),
            ),
            Text(
              title,
              style: new TextStyle(
                  fontSize: 17.0,
                  color: Color.fromARGB(255, 12, 87, 5),
                  fontWeight: FontWeight.bold),
            ),
          ],
        )),
      ),
    );
  }
}
