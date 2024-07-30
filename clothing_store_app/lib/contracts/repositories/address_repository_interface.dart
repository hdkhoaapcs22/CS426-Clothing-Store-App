import 'abstract_repository_interface.dart';
import '../../models/address.dart';

abstract class AddressRepositoryInterface extends AbstractRepositoryInterface<Address> {
// You can define separate methods for Address if needed, but here we inherit all methods from the AbstractRepositoryInterface.
  Future<List<String>> getAllStrings();
}
