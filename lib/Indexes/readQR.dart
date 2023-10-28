import 'dart:convert';

//import 'package:Liner/Indexes/ReservedQueueeeeee.dart';
import 'package:Liner/consts/globalcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import '../main.dart';
import 'dashboard.dart';
import 'package:http/http.dart' as http;
import 'index1.dart';
import 'index2.dart';

class ReadQR extends StatefulWidget {
  String uid;
  ReadQR(this.uid, {super.key});

  @override
  State<ReadQR> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<ReadQR> {
  int _selectedIndex = 0;
  int a = 10;
  List record = [];
  @override
  void initState() {
    super.initState();
    getListofIssuedServices();
    // Or call your function here
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future getListofIssuedServices() async {
    try {
      // print("*******" + widget.uid);
      String uri = "http://192.168.1.84:8050/liner/manage_user.php";
      var response = await http.post(Uri.parse(uri), body: {
        "uid": widget.uid,
        "coordinator_entities": widget.uid,
      });
      print(response.body);
      setState(() {
        record = jsonDecode(response.body);
        // print(record);
      });
    } catch (e) {
      print(e);
    }
  }

  Future startQsession(String sid) async {
    try {
      // print("*******" + widget.uid);
      String uri = "http://192.168.1.84:8050/liner/manage_service.php";
      var response = await http.post(Uri.parse(uri), body: {
        "sid": sid,
        "startqsession": widget.uid,
      });
      print(response.body);
    } catch (e) {
      print(e);
    }
  }

  Future callForNext(String sid) async {
    try {
      // print("*******" + widget.uid);
      String uri = "http://192.168.1.84:8050/liner/manage_queue.php";
      var response = await http.post(Uri.parse(uri), body: {
        "range_fornext": '2',
        "sid": sid,
      });
      print(response.body);
    } catch (e) {
      print(e);
    }
  }

  Future readQNext(String sid, uid, coordinator) async {
    try {
      // print("*******" + widget.uid);
      String uri = "http://192.168.1.84:8050/liner/manage_queue.php";
      var response = await http.post(Uri.parse(uri), body: {
        "callqueue": '2',
        "sid": sid,
        "uid": sid,
        "coordinator": sid,
      });
      print(response.body);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(data.toString());
    int a = 10;
    return Scaffold(
      appBar: AppBar(
        title: Text("Reserved Service in Your Company " + widget.uid),
        // foregroundColor: Colors.white,
        backgroundColor: brandColor,
      ),
      body: ListView.separated(
        itemBuilder: (context, position) {
          return Card(
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: !record[position][5].toString().contains("Not started")
                    ? ListTile(
                        leading: Icon(
                          Icons.roofing,
                          color: Color.fromARGB(255, 12, 87, 5),
                        ),
                        title: Text(
                          record[position][2] + "\n" + record[position][3],
                          textDirection: TextDirection.ltr,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                            "Total: " +
                                record[position][4].toString() +
                                "\nStatus: " +
                                record[position][5].toString(),
                            textDirection: TextDirection.ltr),
                        trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 12, 87, 5),
                              foregroundColor: Colors.white),
                          onPressed: () {
                            callForNext(record[position][0]);
                          },
                          child: Text(
                            'Call Next',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        // onTap: () {
                        //   String uid = record[position][2].toString();
                        //   String sid = record[position][0].toString();
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => ReservedQueue(sid, uid),
                        //     ),
                        //   );
                        // },
                        // tileColor: Colors.amber,
                        hoverColor: Colors.blueGrey,
                      )
                    : ListTile(
                        leading: Icon(
                          Icons.roofing,
                          color: Color.fromARGB(255, 12, 87, 5),
                        ),
                        title: Text(
                          record[position][2] + "\n" + record[position][3],
                          textDirection: TextDirection.ltr,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                            "Total: " + record[position][4].toString(),
                            textDirection: TextDirection.ltr),
                        hoverColor: Colors.blueGrey,
                        trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 12, 87, 5),
                              foregroundColor: Colors.white),
                          onPressed: () {
                            startQsession(record[position][0]);
                          },
                          child: Text(
                            'Open The QUEUE',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      )),
          );
        },
        separatorBuilder: (context, position) {
          return Card(
            color: Color.fromARGB(255, 35, 212, 115),
            child: Padding(
              padding: const EdgeInsets.all(5),

              // child: Text(
              //   "Separator",
              //   style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              // ),
            ),
          );
        },
        itemCount: record.length,
      ),
    );
  }
}
