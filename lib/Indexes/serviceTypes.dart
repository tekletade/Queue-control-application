import 'dart:convert';

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

class ServiceTypes extends StatefulWidget {
  String cid;

  String cname, uid;
  ServiceTypes(this.cid, this.cname, this.uid);

  @override
  _ServiceTypesState createState() => _ServiceTypesState();
}

class _ServiceTypesState extends State<ServiceTypes> {
// class ProvidersGrid extends StatelessWidget {
  List record = [];
  Future<void> imagefromdb() async {
    try {
      String uri = "http://192.168.1.84:8050/liner/manage_service.php?gcid=" +
          widget.cid;
      var response = await http.get(Uri.parse(uri));
      setState(() {
        record = jsonDecode(response.body);
        print(record);
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
    print(widget.cid + " " + widget.cname + " " + widget.uid);
    return Scaffold(
      appBar: AppBar(
        title: Text("Service Types of:  " + widget.uid),
        // foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 2, 87, 5),
      ),

// body starts here
      body: Container(
        // child:Text("Test"+widget.cid),
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
            // Text("Test" + widget.cid),
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
                              title: record[index]['name'] +
                                  "\n Status: " +
                                  record[index]['status'] +
                                  "\n Total: " +
                                  record[index]['total'].toString() +
                                  "\n Current:" +
                                  record[index]['current'].toString(),
                              onTap: () {
                                print(bookaQueue(
                                    record[index]['sid'], widget.uid));
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => HomeDashboard(),
                                //     ));
                              }));
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<String> bookaQueue(String sid, String uid) async {
  var data = null;
  try {
    var url = Uri.parse('http://192.168.1.84:8050/liner/manage_queue.php');
    var response = await http.post(url, body: {
      "sid": sid,
      "token": uid,
      "channel": "Android",
    });

    print(response.request);
    data = json.decode(response.body);
    print(data);
  } catch (e) {
    print(e);
  }
  return data;
}

class MyMenu extends StatelessWidget {
  final String title;
  final cid;
  final VoidCallback onTap;

  // final MaterialColor mcolor;

  MyMenu({
    required this.title,
    this.cid,
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
