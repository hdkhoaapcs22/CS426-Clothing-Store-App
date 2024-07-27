import 'package:clothing_store_app/modules/Address/add_new_address_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../common/common.dart';
import '../../languages/appLocalizations.dart';
import '../Address/edit_address_screen.dart';

class AddressListScreen extends StatefulWidget {
  @override
  _AddressListScreenState createState() =>
      _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  int selectedIndex = 0;

  Future<Map<String, dynamic>> _getAddresses() async {
    Map<String, dynamic> addresses = {};
    final snapshot = await firestore.collection('addresses').get();

    for (var doc in snapshot.docs) {
      addresses[doc.id] = doc.data();
    }

    return addresses;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations(context).of("edit-address")),
      ),
      body: FutureBuilder(
        future: _getAddresses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final addresses = snapshot.data as Map<String, dynamic>;

          return ListView.builder(
            itemCount: addresses.length,
            itemBuilder: (context, index) {
              final addressId = addresses.keys.elementAt(index);
              final addressData = addresses[addressId]!;

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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              addressData['name']!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.0),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              addressData['phone']!,
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              addressData['address']!,
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewAddressScreen(),
            ),
          ).then((_) {
            setState(() {}); // Refresh the list after returning
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
