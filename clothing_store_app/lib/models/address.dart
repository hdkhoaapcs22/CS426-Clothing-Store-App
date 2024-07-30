class Address {
  String? _name;
  String? _phoneNumber;
  String? _street;
  String? _ward;
  String? _district;
  String? _city;

  Address({
    required String? name,
    required String? phoneNumber,
    required String? street,
    required String? ward,
    required String? district,
    required String? city,
  })  : _city = city,
        _district = district,
        _ward = ward,
        _street = street,
        _phoneNumber = phoneNumber,
        _name = name;

  Address.fromAddressString(String addressString) {
    List<String> addressList = addressString.split(', ');
    _name = addressList[0];
    _phoneNumber = addressList[1];
    _street = addressList[2];
    _ward = addressList[3];
    _district = addressList[4];
    _city = addressList[5];
  }

  String get name => _name!;
  String get phoneNumber => _phoneNumber!;
  String get street => _street!;
  String get ward => _ward!;
  String get district => _district!;
  String get city => _city!;

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      street: map['street'],
      ward: map['ward'],
      district: map['district'],
      city: map['city'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': _name,
      'phoneNumber': _phoneNumber,
      'street': _street,
      'ward': _ward,
      'district': _district,
      'city': _city,
    };
  }

  @override
  String toString() {
    return '$_name, $_phoneNumber, $_street, $_ward, $_district, $_city';
  }
}
