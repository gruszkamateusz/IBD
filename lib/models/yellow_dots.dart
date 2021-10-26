class YellowDots {
  int? id;
  String? data;

  YellowDots({this.id,this.data});

  YellowDots.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['data'] = this.data;
    return data;
  }
}
