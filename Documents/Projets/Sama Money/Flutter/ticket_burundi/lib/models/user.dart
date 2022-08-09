class User {
  String? nom;
  String? prenom;
  String? imei;

  User({this.nom, this.prenom, this.imei});

  User.fromJson(Map<String, dynamic> json) {
    nom = json['nom'];
    prenom = json['prenom'];
    imei = json['imei'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nom'] = this.nom;
    data['prenom'] = this.prenom;
    data['imei'] = this.imei;
    return data;
  }
}
