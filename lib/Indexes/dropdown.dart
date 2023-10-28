import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:quantity_input/quantity_input.dart';
import 'plusminus.dart';

void main() {
  runApp(Dropdown());
}

class Dropdown extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Dropdown> {
//for Book button
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    primary: Colors.white,
    backgroundColor: Color.fromARGB(255, 12, 87, 5),
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
  );

  final List<Map<String, dynamic>> _roles = [
    {
      "providers": "Emmigration",
      // "desc": "Having full access rights",
      "role": 1
    },
    {
      "providers": "Kebele",
      // "desc": "Having full access rights of a Organization",
      "role": 2
    },
    {
      "providers": "Banks",
      // "desc": "Having Magenent access rights of a Organization",
      "role": 3
    },
    {
      "providers": "Basic Needs Queue(eg. bread)",
      // "desc": "Having Technician Support access rights",
      "role": 4
    },
    {
      "providers": "Others",
      // "desc": "Having Customer Support access rights",
      "role": 5
    },
    // {
    //   "location": "Mexico",
    //   // "desc": "Having End User access rights",
    //   "role": 6
    // },
    // //Services
    // {"services": "New Passport", "role": 6},
    // {"services": "Renew Passport", "role": 7},
    // {"services": "New Kebele D", "role": 8},
    // {"services": "Renew Kebele ID", "role": 9},
    // {"services": "Birth Certificate", "role": 10},
    // {"services": "Others", "role": 11},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // QuantityInput(
            //     label: 'Simple int input',
            //     value: simpleIntInput,
            //     onChanged: (value) => setState(() =>
            //         simpleIntInput = int.parse(value.replaceAll(',', '')))),
            // Text('Order your Queue: $simpleIntInput',
            Text('Order your Queue: Mr/Mis...',
                style: TextStyle(
                  color: Color.fromARGB(255, 12, 87, 5),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(height: 10),
            SizedBox(
              height: 20,
            ),
            Text('Select * from Providers\n'),
            DropdownFormField<Map<String, dynamic>>(
              onEmptyActionPressed: () async {},
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 2, color: Color.fromARGB(255, 12, 87, 5))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 2, color: Color.fromARGB(255, 19, 170, 5))),
                  suffixIcon: Icon(Icons.arrow_drop_down),
                  labelText: "Service Providers...",
                  labelStyle: TextStyle(
                      color: Color.fromARGB(255, 12, 87, 5),
                      fontWeight: FontWeight.bold)),
              onSaved: (dynamic str) {},
              onChanged: (dynamic str) {},
              validator: (dynamic str) {},
              displayItemFn: (dynamic item) => Text(
                (item ?? {})['providers'] ?? '',
                style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 12, 87, 5),
                    fontWeight: FontWeight.bold),
              ),
              findFn: (dynamic str) async => _roles,
              selectedFn: (dynamic item1, dynamic item2) {
                if (item1 != null && item2 != null) {
                  return item1['providers'] == item2['providers'];
                }
                return false;
              },
              filterFn: (dynamic item, str) =>
                  item['providers'].toLowerCase().indexOf(str.toLowerCase()) >=
                  0,
              dropdownItemFn: (dynamic item, int position, bool focused,
                      bool selected, Function() onTap) =>
                  ListTile(
                title: Text(item['providers']),
                // subtitle: Text(
                //   item['desc'] ?? '',
                // ),
                tileColor: focused
                    ? Color.fromARGB(255, 42, 136, 58)
                    : Colors.transparent,
                hoverColor: Color.fromARGB(255, 12, 87, 5),
                onTap: onTap,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
                "Select * from serviceType where service_provider == provider(clicked)\n"),
            DropdownFormField<Map<String, dynamic>>(
              onEmptyActionPressed: () async {},
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 2, color: Color.fromARGB(255, 12, 87, 5))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 2, color: Color.fromARGB(255, 19, 170, 5))),
                  suffixIcon: Icon(Icons.arrow_drop_down),
                  labelText: "Service Type...",
                  labelStyle: TextStyle(
                      color: Color.fromARGB(255, 12, 87, 5),
                      fontWeight: FontWeight.bold)),
              onSaved: (dynamic str) {},
              onChanged: (dynamic str) {},
              validator: (dynamic str) {},
              displayItemFn: (dynamic item) => Text(
                (item ?? {})['providers'] ?? '',
                style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 12, 87, 5),
                    fontWeight: FontWeight.bold),
              ),
              findFn: (dynamic str) async => _roles,
              selectedFn: (dynamic item1, dynamic item2) {
                if (item1 != null && item2 != null) {
                  return item1['providers'] == item2['providers'];
                }
                return false;
              },
              filterFn: (dynamic item, str) =>
                  item['providers'].toLowerCase().indexOf(str.toLowerCase()) >=
                  0,
              dropdownItemFn: (dynamic item, int position, bool focused,
                      bool selected, Function() onTap) =>
                  ListTile(
                title: Text(item['providers']),
                // subtitle: Text(
                //   item['desc'] ?? '',
                // ),
                tileColor: focused
                    ? Color.fromARGB(255, 42, 136, 58)
                    : Colors.transparent,
                hoverColor: Color.fromARGB(255, 12, 87, 5),
                onTap: onTap,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Text('Number of Passengers:',
            //     style: TextStyle(
            //         color: Color.fromARGB(255, 12, 87, 5),
            //         fontWeight: FontWeight.bold,
            //         fontSize: 16)),
            // SizedBox(height: 20),
            // QuantityInput(
            //   value: simpleIntInput,
            //   onChanged: (value) => setState(
            //       () => simpleIntInput = int.parse(value.replaceAll(',', ''))),

            //   buttonColor: Color.fromARGB(255, 12, 87, 5),
            //   iconColor: Colors.white,
            //   // inputWidth: 60,
            // ),

            // Text('Value: $simpleIntInput Person',
            //     style: TextStyle(
            //         color: Color.fromARGB(255, 12, 87, 5),
            //         fontWeight: FontWeight.bold,
            //         fontSize: 14)),
            // SizedBox(height: 50),
            // Text(
            //     'Tariff: $simpleIntInput birr      Total: $simpleIntInput * tariff',
            //     style: TextStyle(
            //         color: Color.fromARGB(255, 12, 87, 5),
            //         fontWeight: FontWeight.bold,
            //         fontSize: 14)),

            SizedBox(height: 20),
            ElevatedButton(
              style: flatButtonStyle,
              onPressed: () {},
              child: Text(
                'Book Now',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
