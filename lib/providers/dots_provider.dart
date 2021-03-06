import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:ibd/models/Dot.dart';
import 'package:ibd/models/Localization.dart';
import 'package:ibd/models/Printer.dart';
import 'package:ibd/models/Printout.dart';

import 'package:http/http.dart' as http;
import 'package:ibd/services/dots_services.dart';
import 'package:ibd/services/printout_services.dart';

class DotProvider extends ChangeNotifier {

  
  bool loading = false;
  List<Dot>? list = [];


  DotProvider() {
    fetchData();
  }

  Future<void> fetchData() async {
    setLoading(true);
    list = await DotServices().fetchData();
    setLoading(false);
    notifyListeners();
  }
  setLoading(bool value){
    loading = value;
    notifyListeners();
  }

    Future<String> removeDot(int id,int index) async {
      var text ='';
    //setLoading(true);
    var response = await DotServices().remove(id);

    if(response == 200){
      list!.removeAt(index);
      text = "Poprawnie usunieto zasob";
    }else{
      text = "Nie udalo sie usunac zasobu";
    }
    //setLoading(false);
    notifyListeners();

    return text;
  }
  add(Dot dot) async {
          var text ='';

    //setLoading(true);

    var response = await DotServices().add(dot);

    if(response == 201||response == 200){
            list!.add(dot);
      text = "Poprawnie dodano zasob";
    }else{
      text = "Nie udalo sie dodac zasobu";
    }
    //setLoading(false);
    notifyListeners();

    return text;
  }
        Future<String> remove(int id,int index) async {
      var text ='';
    var response = await DotServices().remove(id);

    if(response == 200){
      list!.removeAt(index);
      text = "Poprawnie usunieto zasob";
    }else{
      text = "Nie udalo sie usunac zasobu";
    }
    //setLoading(false);
    notifyListeners();

    return text;
  }
}