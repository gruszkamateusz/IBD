class Printer {
  int? localization;
  String? owner;
  String? type;
  int? id;

  Printer({this.localization, this.owner, this.type, this.id});

  Printer.fromJson(Map<String, dynamic> json) {
    localization = json['localization'];
    owner = json['owner'];
    type = json['type'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['localization'] = this.localization;
    data['owner'] = this.owner;
    data['type'] = this.type;
    data['id'] = this.id;
    return data;
  }
}