class HistoPrincipalModel {
  final String type;
  final String montant;
  final String devise;
  final String date;

  HistoPrincipalModel.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        montant = json['montant'],
        devise = json['devise'],
        date = json['date'];
}
