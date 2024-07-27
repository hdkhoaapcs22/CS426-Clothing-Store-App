import 'package:clothing_store_app/languages/appLocalizations.dart';
import 'package:clothing_store_app/modules/Address/add_new_address_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Address/edit_address_screen.dart';

class EditableAddressListScreen extends StatefulWidget {
  @override
  _EditableAddressListScreenState createState() =>
      _EditableAddressListScreenState();
}

class _EditableAddressListScreenState extends State<EditableAddressListScreen> {
  int selectedIndex = 0;

  final firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> _getAddresses() async {
    Map<String, dynamic> addresses = {};
    final snapshot = await firestore.collection('addresses').get();

    snapshot.docs.forEach((doc) {
      addresses[doc.id] = doc.data();
    });

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
            return Center(child: CircularProgressIndicator());
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
                  margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  padding: EdgeInsets.all(12.0),
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
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.0),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              addressData['phone']!,
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              addressData['address']!,
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditAddressScreen(
                                addressData: addressData,
                                addressId: addressId,
                              ),
                            ),
                          ).then((_) {
                            setState(() {}); // Refresh the list after returning
                          });
                        },
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
              builder: (context) => AddNewAddressScreen(),
            ),
          ).then((_) {
            setState(() {}); // Refresh the list after returning
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
