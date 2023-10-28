import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
// import '../qrgenerator.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'bottomSlide.dart';

class QrGenerator extends StatefulWidget {
  String uid;
  QrGenerator(this.uid, {Key? key}) : super(key: key);

  @override
  State<QrGenerator> createState() => _QrGeneratorState();
}

class _QrGeneratorState extends State<QrGenerator> {
  String data = "";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("QR code to Verify:" + widget.uid),
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
          children: [
            SizedBox(
              height: 2,
            ),
            // Text(
            //   '\n\n\n This is your QR Id',
            //   style: TextStyle(
            //       fontSize: 25,
            //       color: Color.fromARGB(255, 2, 87, 5),
            //       fontWeight: FontWeight.bold),
            // ),
            Container(
              width: 250.0,
              child: TextField(
                //we will generate a new qr code when the input value change
                onChanged: (value) {
                  setState(() {
                    data = value;
                  });
                },
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 12, 87, 5),
                ),
                decoration: InputDecoration(
                  hintText: "Phone/No of que/....",
                  filled: true,
                  fillColor: Color.fromARGB(255, 242, 245, 241),
                  border: InputBorder.none,
                ),
              ),
            ),
            Expanded(
              child: Container(
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(400),
                    )),
                child: Center(
                  child: QrImage(
                    data: data,
                    backgroundColor: Colors.white,
                    foregroundColor: Color.fromARGB(255, 8, 133, 3),
                    version: QrVersions.auto,
                    size: 250.0,
                  ),
                ),
              ),
            ),
            //Bottom Slider
            SizedBox(
              height: size.height * 0.1,
              child: Swiper(
                itemCount: 3,
                itemBuilder: (ctx, index) {
                  return const bottomSlide();
                },
                autoplay: true,
                // pagination: const SwiperPagination(
                //     alignment: Alignment.bottomCenter,
                //     builder: DotSwiperPaginationBuilder(
                //         color: Colors.white, activeColor: Colors.red)
                //         ),
                // control: const SwiperControl(),
              ),
            ),
          ],
        ),
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
                leading: Icon(Icons.web, color: Color.fromARGB(255, 5, 206, 5)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
