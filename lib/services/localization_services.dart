import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:ibd/models/Localization.dart';
import 'package:http/http.dart' as http;

class LocalizationServices{

List<Localization> parseLocalization(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return (parsed
      .map<Localization>((json) => Localization.fromJson(json))
      .toList());
}

Future<List<Localization>?> fetchData() async {
    try{
            var uri = 'http://127.0.0.1:8080/localizations/all';
            final response = await http.get(
              Uri.parse(uri),
                headers: {
                "Access-Control_Allow_Origin": "*"
            },
                );
            if (response.statusCode == 200) {
              return compute(parseLocalization, response.body);
            }
            }on Error catch (e) {

            }
  }
  @override
  Future<int> remove(int id) async {

                var uri = 'http://127.0.0.1:8080/localizations/${id}';
            final response = await http.delete(
              Uri.parse(uri),
                headers: {
                "Access-Control_Allow_Origin": "*"
            },
                );

      return response.statusCode;
  }
}