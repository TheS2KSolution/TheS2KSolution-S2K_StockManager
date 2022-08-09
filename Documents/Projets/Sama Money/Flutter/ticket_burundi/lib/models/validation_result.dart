class ValidationResult {
  int? status;
  String? type;
  String? typeNomFr;
  String? msg;

  ValidationResult({this.status, this.type, this.typeNomFr, this.msg});

  ValidationResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    type = json['type'];
    typeNomFr = json['type_nom_fr'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['type'] = this.type;
    data['type_nom_fr'] = this.typeNomFr;
    data['msg'] = this.msg;
    return data;
  }
}
