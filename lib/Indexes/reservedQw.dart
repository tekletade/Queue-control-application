import 'dart:convert';

import 'package:Liner/Indexes/singleQR.dart';
import 'package:Liner/consts/globalcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import '../main.dart';
import 'dashboard.dart';
import 'package:http/http.dart' as http;
import 'index1.dart';
import 'index2.dart';

class reservedQw extends StatefulWidget {
  String uid;
  reservedQw(this.uid, {super.key});

  @override
  State<reservedQw> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<reservedQw> {
  int _selectedIndex = 0;

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
    // var url = Uri.http("emeraldllp.com", '/login.php', {'q': '{https}'});
    try {
      print("*******" + widget.uid);
      String uri = "http://192.168.1.84:8050/liner/manage_queue.php";
      var response = await http.post(Uri.parse(uri), body: {
        "byuid": widget.uid,
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

  Future shiftQueue(qid, sid) async {
    // var url = Uri.http("emeraldllp.com", '/login.php', {'q': '{https}'});
    try {
      print("*****-------**" + widget.uid);
      String uri = "http://192.168.1.84:8050/liner/manage_queue.php";
      var response = await http.post(Uri.parse(uri), body: {
        "qid": qid,
        "uid": widget.uid,
        "sid": sid,
        "shiftQ": '0',
        "number": '0',
      });
      print("++++++++++++++++" + response.body);
      setState(() {
        record = jsonDecode(response.body);
        // print(record);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(data.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Reserved Queue..." + widget.uid),
        // foregroundColor: Colors.white,
        backgroundColor: brandColor,
      ),
      body: ListView.separated(
        itemBuilder: (context, position) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListTile(
                leading: Icon(
                  Icons.roofing,
                  color: Color.fromARGB(255, 12, 87, 5),
                ),
                title: Text(
                  record[position]['servicename'] +
                      "\n" +
                      record[position]['companyname'] +
                      "\n" +
                      "Remaining: " +
                      record[position]['0']['offset'].toString() +
                      "\n" +
                      "Current: " +
                      record[position]['1']['current'].toString() +
                      "\n" +
                      "You are: " +
                      record[position]['number'].toString(),
                  textDirection: TextDirection.ltr,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Subtitle", textDirection: TextDirection.ltr),
                // onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: ((context) => singleQR())));
                // shiftQueue(
                //     record[position]['qid'], record[position]['sid'], 5);
                // },
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 12, 87, 5),
                      foregroundColor: Colors.white),
                  onPressed: () {
                    shiftQueue(record[position]['qid'].toString(),
                        record[position]['sid'].toString());
                  },
                  child: Text(
                    'Shift Queue',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

                // tileColor: Colors.amber,
                hoverColor: Colors.blueGrey,
              ),
            ),
          );
        },
        separatorBuilder: (context, position) {
          return Card(
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "You are: " + record[position]['number'].toString(),
                style: TextStyle(color: Color.fromARGB(255, 34, 11, 11)),
              ),
            ),
          );
        },
        itemCount: record.length,
      ),
    );
  }
}
