import 'package:clothing_store_app/contracts/repositories/address_repository_interface.dart';
import 'package:clothing_store_app/models/address.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddressRepository implements AddressRepositoryInterface {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId;

  AddressRepository(this.userId);

  @override
  Future<List<Address>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<void> add(Address item) async {
    try {
      DocumentReference userDocRef = _firestore.collection('User').doc(userId);
      DocumentSnapshot userDoc = await userDocRef.get();

      if (!userDoc.exists) {
        throw Exception('User document does not exist');
      }

      List<String> addressList = List<String>.from(
          (userDoc.data() as Map<String, dynamic>)['addresses'] ?? []);

      addressList.add(item.toString());

      await userDocRef.update({
        'addresses': addressList,
      });
    } catch (e) {
      print("Error adding address: $e");
    }
  }

  @override
  Future<void> delete(int index) async {
    try {
      DocumentReference userDocRef = _firestore.collection('User').doc(userId);
      DocumentSnapshot userDoc = await userDocRef.get();

      if (!userDoc.exists) {
        throw Exception('User document does not exist');
      }

      List<String> addressList = List<String>.from(
          (userDoc.data() as Map<String, dynamic>)['addresses'] ?? []);

      if (index < 0 || index >= addressList.length) {
        throw Exception('Invalid index');
      }

      addressList.removeAt(index);

      await userDocRef.update({
        'addresses': addressList,
      });
    } catch (e) {
      print("Error deleting address: $e");
    }
  }

  @override
  Future<Address> getById(int id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<void> update(Address item, int id) async {
    try {
      DocumentReference userDocRef = _firestore.collection('User').doc(userId);
      DocumentSnapshot userDoc = await userDocRef.get();

      if (!userDoc.exists) {
        throw Exception('User document does not exist');
      }

      List<String> addressList = List<String>.from(
          (userDoc.data() as Map<String, dynamic>)['addresses'] ?? []);

      int index = id;

      if (index == -1) {
        throw Exception('Address to update not found');
      }

      addressList[index] = item.toString();

      await userDocRef.update({
        'addresses': addressList,
      });
    } catch (e) {
      print("Error updating address: $e");
    }
  }

  @override
  Future<List<String>> getAllStrings() async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('User').doc(userId).get();

      if (!userDoc.exists) {
        throw Exception('User document does not exist');
      }

      List<String> addressList = List<String>.from(
          (userDoc.data() as Map<String, dynamic>)['addresses'] ?? []);

      return addressList;
    } catch (e) {
      print("Error fetching addresses: $e");
      return [];
    }
  }
}
