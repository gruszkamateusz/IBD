
import 'package:flutter/cupertino.dart';

import 'package:ibd/models/Printer.dart';
import 'package:ibd/services/printer_services.dart';

class PrinterProvider extends ChangeNotifier {

  bool loading = false;
  List<Printer>? list = [];

  PrinterProvider() {
    fetchData();
  }

  Future<void> fetchData() async {
    setLoading(true);
    list = await PrinterServices().fetchData();
    setLoading(false);
    notifyListeners();
  }
  setLoading(bool value){
    loading = value;
    notifyListeners();
  }

    Future<String> remove(int id,int index) async {
      var text ='';
    //setLoading(true);
    var response = await PrinterServices().remove(id);

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
    Future<String> edit(int id, String data) async {
      var text ='';
    //setLoading(true);
    var response = await PrinterServices().remove(id);

    if(response == 200){

      text = "Poprawnie edytowano zasob";
    }else{
      text = "Nie udalo sie edytowac zasobu";
    }
    //setLoading(false);
    notifyListeners();

    return text;
  }
      Future<String> add(Printer data) async {

      var text ='';

    //setLoading(true);

    var response = await PrinterServices().add(data);

    if(response == 200){

      list!.add(data);
      text = "Poprawnie dodano zasob";
    }else{
      text = "Nie udalo sie dodac zasobu";
    }
    //setLoading(false);
    notifyListeners();

    return text;
  }
}