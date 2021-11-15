import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ibd/models/Printer.dart';

import 'package:http/http.dart' as http;

class PrinterServices{

List<Printer> parsePrinters(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return (parsed
      .map<Printer>((json) => Printer.fromJson(json))
      .toList());
}

Future<List<Printer>?> fetchData() async {
    try{
            var uri = 'http://127.0.0.1:8080/printers/all';
            final response = await http.get(
              Uri.parse(uri),
                headers: {
                "Access-Control_Allow_Origin": "*"
            },
                );
            if (response.statusCode == 200) {
              //print(response.body);
              return compute(parsePrinters, response.body);
            }
            }on Error catch (e) {

            }
  }
  @override
  Future<int> remove(int id) async {

                var uri = 'http://127.0.0.1:8080/printers/${id}';
            final response = await http.delete(
              Uri.parse(uri),
                headers: {
                "Access-Control_Allow_Origin": "*"
            },
                );

      return response.statusCode;
  }

    Future<int> add(Printer data) async {
      
          var body = json.encode(data.toJson());
                var uri = 'http://127.0.0.1:8080/printers/add';
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

