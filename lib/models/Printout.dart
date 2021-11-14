import 'package:ibd/models/Printer.dart';

class Printout {
  Printer? printer;
  String? title;
  String? date;
  int? id;

  Printout({this.printer, this.title, this.date, this.id});

  Printout.fromJson(Map<String, dynamic> json) {
    printer =
        json['printer'] != null ? new Printer.fromJson(json['printer']) : null;
    title = json['title'];
    date = json['date'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.printer != null) {
      data['printer'] = this.printer!.toJson();
    }
    data['title'] = this.title;
    data['date'] = this.date;
    data['id'] = this.id;
    return data;
  }
}