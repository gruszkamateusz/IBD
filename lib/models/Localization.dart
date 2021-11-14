class Localization {
  int? idlocalization;
  String? city;
  String? street;
  String? postcode;

  Localization({this.idlocalization, this.city, this.street, this.postcode});

  Localization.fromJson(Map<String, dynamic> json) {
    idlocalization = json['id'];
    city = json['city'];
    street = json['street'];
    postcode = json['postcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.idlocalization;
    data['city'] = this.city;
    data['street'] = this.street;
    data['postcode'] = this.postcode;
    return data;
  }
}