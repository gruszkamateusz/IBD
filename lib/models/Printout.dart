class Printout {
  String? title;
  String? date;
  int? idprinter;
  int? id;

  Printout({this.title, this.date, this.idprinter, this.id});

  Printout.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    date = json['date'];
    idprinter = json['idprinter'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['date'] = this.date;
    data['idprinter'] = this.idprinter;
    data['id'] = this.id;
    return data;
  }
}