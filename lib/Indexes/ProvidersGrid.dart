import 'dart:convert';

import 'package:Liner/Indexes/serviceTypes.dart';
import 'package:flutter/material.dart';
import 'index1.dart';
import 'index2.dart';
// import '../consts/globalcolors.dart';
// import 'package:swip/home.dart';
import '../defaultPage.dart';
import 'QrDashboard.dart';
import 'index1.dart';
import 'HomeDashboard.dart';
import 'BookNowDashboard.dart';
//import '../qrgenerator.dart';
// import 'package:carousel_pro/carousel_pro.dart';
import 'package:http/http.dart' as http;

class ProvidersGrid extends StatefulWidget {
  String uid;
  ProvidersGrid(this.uid);
  @override
  _ProvidersGridState createState() => _ProvidersGridState();
}

class _ProvidersGridState extends State<ProvidersGrid> {
// class ProvidersGrid extends StatelessWidget {
  List record = [];

  // String cid = "";
  Future<void> imagefromdb() async {
    try {
      String uri = "http://192.168.1.84:8050/liner/manage_company.php";
      var response = await http.get(Uri.parse(uri));
      setState(() {
        record = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    imagefromdb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Providers...' + widget.uid),
        // foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 2, 87, 5),
      ),

// body starts here
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
            // image_slider,
            SizedBox(
              height: 2,
            ),
            Expanded(
              child: Container(
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(400),
                    )),
                // padding: EdgeInsets.all(5),
                child: GridView.builder(
                    itemCount: record.length,
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: MyMenu(
                              title: record[index]['name'],
                              cid: record[index]['cid'],
                              name: record[index]['name'],
                              l_uid: widget.uid,
                              // name: record[index]['name'],
                              onTap: () {
                                String cid = record[index]['cid'];
                                String cname = record[index]['name'];
                                String uid = widget.uid;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ServiceTypes(cid, cname, uid)));
                              }

                              // product_old_price: product_list[index]['old_price'],
                              // product_price: product_list[index]['price'],
                              ));
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyMenu extends StatelessWidget {
  final title;
  String l_uid;
  String cid, name;

  final VoidCallback onTap;
  // final MaterialColor mcolor;

  MyMenu({
    this.title,
    required this.l_uid,
    required this.cid,
    required this.name,
    // this.name,
    // required this.icon,
    required this.onTap,
    // required this.mcolor
  });

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
            // Icon(
            //   icon,
            //   size: 70.0,
            //   color: Color.fromARGB(255, 12, 87, 5),
            // ),
            Text(
              title,
              style: new TextStyle(
                fontSize: 17.0,
                color: Color.fromARGB(255, 12, 87, 5),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
