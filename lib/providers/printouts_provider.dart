import 'package:flutter/cupertino.dart';
import 'package:ibd/models/Printer.dart';
import 'package:ibd/models/Printout.dart';

import 'package:http/http.dart' as http;
import 'package:ibd/services/printout_services.dart';

class PrintoutProvider extends ChangeNotifier {

  
  bool loading = false;
  List<Printout>? list = [];


  PrintoutProvider() {
    fetchData();
  }

  Future<void> fetchData() async {
    setLoading(true);
    list = await PrintoutsServices().fetchData();
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
    var response = await PrintoutsServices().remove(id);

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

  add(Printout printout) async {
          var text ='';

    //setLoading(true);

    var response = await PrintoutsServices().add(printout);

    if(response == 201||response == 200){
            list!.add(printout);
      text = "Poprawnie dodano zasob";
    }else{
      text = "Nie udalo sie dodac zasobu";
    }
    //setLoading(false);
    notifyListeners();

    return text;
  }
}