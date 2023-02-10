import 'package:get/get.dart';
import 'package:masterappp/authentication/login_screen.dart';
import 'package:masterappp/authentication/password_default_screen.dart';
import 'package:masterappp/authentication/phone_number_auth.dart';
import 'package:masterappp/routes/route_constants.dart';
import 'package:masterappp/screens/agent_registration_screen.dart';
import 'package:masterappp/screens/conversion_commission_screen.dart';
import 'package:masterappp/screens/envoi_uv_screen.dart';
import 'package:masterappp/screens/envoi_uv_valid_screen.dart';
import 'package:masterappp/screens/fraisservice/canal_plus_tarif_screen.dart';
import 'package:masterappp/screens/fraisservice/sama_frais_service_screen.dart';
import 'package:masterappp/screens/fraisservice/startimes_tarif_screen.dart';
import 'package:masterappp/screens/historique_screen.dart';
import 'package:masterappp/screens/home_page.dart';
import 'package:masterappp/screens/mes_agents_screen.dart';
import 'package:masterappp/screens/password_screen.dart';
import 'package:masterappp/screens/reclamations_screen.dart';
import 'package:masterappp/screens/retour_uv_screen.dart';
import 'package:masterappp/screens/tarif_screen.dart';
import 'package:masterappp/splashscreen/splash_screen.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: splashScreenRoute, page: () => SplashScreen()),
    GetPage(name: phoneNumberAuthRoute, page: () => const PhoneNumberAuth()),
    GetPage(name: loginScreenRoute, page: () => const LoginScreen()),
    GetPage(
        name: passwordDefaultScreenRoute, page: () => PasswordDefaultScreen()),
    GetPage(name: homePageRoute, page: () => MyHomePage()),
    GetPage(name: historiquePageRoute, page: () => HistoriqueScreen()),
    GetPage(name: envoiUvPageRoute, page: () => const EnvoiUvScreen()),
    GetPage(
        name: envoiUvValidPageRoute, page: () => const EnvoiUvValidScreen()),
    GetPage(name: retourUvPageRoute, page: () => const RetourUvScreen()),
    GetPage(
        name: convertCommPageRoute,
        page: () => const ConversionCommissionScreen()),
    GetPage(
        name: agentRegistrationPageRoute,
        page: () => const AgentRegistrationScreen()),
    GetPage(name: passwordEditPageRoute, page: () => const PasswordScreen()),
    GetPage(name: mesAgentsPageRoute, page: () => const MesAgentScreen()),
    GetPage(name: reclamationPageRoute, page: () => ReclamationScreen()),
    GetPage(name: tarifPageRoute, page: () => const TarifScreen()),
    GetPage(
        name: samaFraisServicePageRoute, page: () => SamaFraisServiceScreen()),
    GetPage(name: canalTarifPageRoute, page: () => CanalTarifScreen()),
    GetPage(name: starTimesTarifPageRoute, page: () => StarTimesTarifScreen()),
  ];
}
