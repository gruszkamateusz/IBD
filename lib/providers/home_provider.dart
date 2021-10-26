import 'package:flutter/cupertino.dart';
import 'package:ibd/models/yellow_dots.dart';
import 'package:ibd/services/home_services.dart';

class HomeProvider extends ChangeNotifier {

  
  bool loading = false;
  List<YellowDots> list = [];

  HomeProvider() {
    fetchData();
  }

  Future<void> fetchData() async {
    setLoading(true);
    list = await HomeServices().fetchData();
    setLoading(false);
    notifyListeners();
  }
  setLoading(bool value){
    loading = value;
    notifyListeners();
  }

    Future<String> removeDot(int id) async {
      var text ='';
    //setLoading(true);
    var response = await HomeServices().remove(id);
    if(response == 200){
      var toRemove;
      list.forEach((element) {
        if(element.id == id){
          toRemove = element;
      }});
      list.remove(toRemove);
      text = "Poprawnie usunieto zasob";
    }else{
      text = "Nie udalo sie usunac zasobu";
    }
    //setLoading(false);
    notifyListeners();

    return text;
  }
    Future<String> editDot(int id, String data) async {
      var text ='';
    //setLoading(true);
    var response = await HomeServices().remove(id);
    if(response == 200){
      var toRemove;
      list.forEach((element) {
        if(element.id == id){
          element.data = data;
      }});
      list.remove(toRemove);
      text = "Poprawnie edytowano zasob";
    }else{
      text = "Nie udalo sie edytowac zasobu";
    }
    //setLoading(false);
    notifyListeners();

    return text;
  }
      Future<String> addDot(int id, String data) async {

      var text ='';
    //setLoading(true);
    var response = await HomeServices().add(id,data);
    if(response == 201){
      
      list.add(YellowDots(id: id, data : data ));
      text = "Poprawnie dodano zasob";
    }else{
      text = "Nie udalo sie dodac zasobu";
    }
    //setLoading(false);
    notifyListeners();

    return text;
  }
}