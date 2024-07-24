import 'package:clothing_store_app/routes/navigation_services.dart';
import 'package:flutter/material.dart';

import 'add_new_address_screen.dart';

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({super.key});

  @override
  _AddressListScreenState createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  int selectedIndex = -1;

  final List<Map<String, String>> addresses = [
    {
      'name': 'Hong co duiii',
      'phone': '+923205986923',
      'address': '52386 Timmy Coves, South Urbana, Maine 87685, USA',
    },
    {
      'name': 'John Doe',
      'phone': '(+128) 656 7890',
      'address': '123 Main Street, New York, New York 10001, United States',
    },
    {
      'name': 'Alice Smith',
      'phone': '(+367) 354 3270',
      'address': '456 Elm Avenue, Los Angeles, California 90001, United States',
    },
    {
      'name': 'Taimoor Sikander',
      'phone': '+923105986923',
      'address': 'Street 35, Islamabad, Federal 45000, Pakistan',
    },
    {
      'name': 'Maria Garcia',
      'phone': '(+5411) 324 5782',
      'address': '789 Oak Street, Buenos Aires, Buenos Aires 1501, Argentina',
    },
    {
      'name': 'Liam Johnson',
      'phone': '+442073568934',
      'address': '10 Park Lane, London, England 35014, United Kingdom',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Addresses'),
      ),
      body: ListView.builder(
        itemCount: addresses.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: selectedIndex == index
                    ? Colors.blue.shade100
                    : Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: selectedIndex == index
                      ? Colors.blue
                      : Colors.grey.shade300,
                  width: 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    addresses[index]['name']!,
                    style:
                        const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    addresses[index]['phone']!,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    addresses[index]['address']!,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
