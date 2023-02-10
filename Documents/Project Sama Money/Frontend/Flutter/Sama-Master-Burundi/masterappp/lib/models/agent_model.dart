class AgentModel {
  final String phone;
  final String id;
  final String nom;
  final String prenom;
  final String logine;

  AgentModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        phone = json['phone'],
        nom = json['nom'],
        prenom = json['prenom'],
        logine = json['logine'];
}
