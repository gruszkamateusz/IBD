import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ibd/models/Printer.dart';

import 'package:http/http.dart' as http;
import 'package:ibd/models/Printout.dart';

class PrintoutsServices{

List<Printout> parsePrintout(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return (parsed
      .map<Printout>((json) => Printout.fromJson(json))
      .toList());
}

Future<List<Printout>?> fetchData() async {
    try{
            var uri = 'http://127.0.0.1:8080/printouts/all';
            final response = await http.get(
              Uri.parse(uri),
                headers: {
                "Access-Control_Allow_Origin": "*"
            },
                );
            if (response.statusCode == 200) {
              return compute(parsePrintout, response.body);
            }
            }on Error catch (e) {

            }
  }
  @override
  Future<int> remove(int id) async {

                var uri = 'http://127.0.0.1:8080/printouts/${id}';
            final response = await http.delete(
              Uri.parse(uri),
                headers: {
                "Access-Control_Allow_Origin": "*"
            },
                );

      return response.statusCode;
  }
     
      Future<int> add(Printout data) async {

          var body = "{\"printer\":{\"id\":${data.printer!.id}},\"title\":\"${data.title}\",\"date\":${data.date}}";

                var uri = 'http://127.0.0.1:8080/printouts/add';
            final response = await http.post(
              Uri.parse(uri),
                headers: {
                "Content-type": "application/json",
                "Access-Control_Allow_Origin": "*"
            },
            body:body
                );

                return response.statusCode;
  }
  }

