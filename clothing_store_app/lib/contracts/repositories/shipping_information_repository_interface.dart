import 'abstract_repository_interface.dart';
import '../../models/shipping_information.dart';

abstract class ShippingInformationRepositoryInterface
    extends AbstractRepositoryInterface<ShippingInformation> {
// You can define separate methods for ShippingInformation if needed, but here we inherit all methods from the AbstractRepositoryInterface.
  Future<List<String>> getAllStrings();
}
