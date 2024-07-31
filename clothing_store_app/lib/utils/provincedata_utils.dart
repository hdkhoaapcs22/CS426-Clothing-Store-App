import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

mixin ProvincedataUtils {
  static List<String> provinceList = [];

  static Map<String, List<String>>? districtMap;

  static Map<String, List<String>>? wardMap;

  static Future<void> loadVietnameseProvinceDataFromJsonFile() async {
    if (provinceList.isNotEmpty) return;

    try {
      final String provinceJson =
          await rootBundle.loadString('assets/json/provinces_vn.json');
      final List<dynamic> provinceData = jsonDecode(provinceJson);

      provinceList = List<String>.from(provinceData);

      final String districtJson =
          await rootBundle.loadString('assets/json/districts_vn.json');
      final Map<String, dynamic> districtData = jsonDecode(districtJson);

      districtMap = districtData.map((key, value) {
        return MapEntry(key, List<String>.from(value));
      });

      final String wardJson =
          await rootBundle.loadString('assets/json/wards_vn.json');
      final Map<String, dynamic> wardData = jsonDecode(wardJson);

      wardMap = wardData.map((key, value) {
        return MapEntry(key, List<String>.from(value));
      });
    } catch (e) {
      throw Exception('Error loading Vietnamese province data: $e');
    }
  }
}
