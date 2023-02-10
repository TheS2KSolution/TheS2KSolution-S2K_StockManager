import 'package:hive/hive.dart';

class AgentSamaWeb {
  static Box? userResulBox;
  static String userResultHiveKey = "userResultHiveKey";
  static String userResultHiveBoxKey = 'userResultHivebox';

  static Box? identifiantBox;
  static String identifiantHiveKey = "identifiantHiveKey";
  static String identifiantHiveBoxKey = 'identifiantHivebox';

  static const String authorization =
      'Basic c2FtYUNsaTpCYXNpYyBjMkZ0WVVOc2FUcENZWE5wWXlCak1rWjBXVlZPYzJGVWNGUlpWVEZvU1VaV1dFNTZWWHBRUkd4Q1dsUlNhRlpzWXpaT1dFazBUWHB3TWc9PQ==';

  static const String messageServiceNonDisponible =
      'Service momentanément indisponible. Veuillez réessayer plus tard ... Veuillez vérifier votre connexion Internet.';
}
