import 'package:flutter/cupertino.dart';
import 'package:ibd/models/Localization.dart';
import 'package:ibd/models/Printer.dart';
import 'package:ibd/models/Printout.dart';

import 'package:http/http.dart' as http;
import 'package:ibd/services/localization_services.dart';
import 'package:ibd/services/printout_services.dart';

class LocalizationProvider extends ChangeNotifier {

  
  bool loading = false;
  List<Localization>? list = [];


  LocalizationProvider() {
    fetchData();
  }

  Future<void> fetchData() async {
    setLoading(true);
    list = await LocalizationServices().fetchData();
    setLoading(false);
    notifyListeners();
  }
  setLoading(bool value){
    loading = value;
    notifyListeners();
  }
      Future<String> add(Localization data) async {

      var text ='';

    //setLoading(true);

    var response = await LocalizationServices().add(data);

    if(response == 201||response == 200){
      list!.add(data);
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
    //setLoading(true);
    var response = await LocalizationServices().remove(id);

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