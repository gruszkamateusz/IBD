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

}