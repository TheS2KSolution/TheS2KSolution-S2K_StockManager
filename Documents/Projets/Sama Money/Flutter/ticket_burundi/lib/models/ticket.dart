class Ticket {
  String? imei;
  String? phoneBenef;
  String? code;

  Ticket({this.imei, this.phoneBenef, this.code});

  Ticket.fromJson(Map<String, dynamic> json) {
    imei = json['imei'];
    phoneBenef = json['phoneBenef'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imei'] = this.imei;
    data['phoneBenef'] = this.phoneBenef;
    data['code'] = this.code;
    return data;
  }
}
