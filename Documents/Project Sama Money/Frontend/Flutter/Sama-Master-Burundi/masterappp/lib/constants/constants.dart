import 'package:flutter/material.dart';

const kSamaBleuDegradeColor = Color(0xFF1D579F);
const String urlLink = 'https://bumapi.sama.money/V1/';

//const String urlfactureLink = 'https://lima.sama.money/';

//const String urlLinkSmall = 'https://lima.sama.money/apia/V6/';
//const String urlLinkSomagep = 'https://lima.sama.money/apia/V6/';

const kBackGroundDecoration = BoxDecoration(
  gradient: LinearGradient(
      colors: [
        Color(0xFFf3797d),
        Color(0xFFd42027),
        Color(0xFF7c1e22),
        //Color(0xFF1D579F),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomLeft,
      // Add one stop for each color
      // Values should increase from 0.0 to 1.0
      stops: [0.1, 0.4, 0.7]),
);

const kBackGroundDecorationSec = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomLeft,
    stops: [0.1, 0.4, 0.6, 0.9],
    colors: [
      Color(0xFF1D579F),
      Color(0xFF1D579F),
      Color(0xFF01224b),
      Color(0xFF01224b),
    ],
  ),
);

List<ChoiceAchat> abonnementTvList = <ChoiceAchat>[
  const ChoiceAchat(
      title: 'CANAL +', image: 'images/canal.png', sizeBo: 30, valuePadd: 10),
  const ChoiceAchat(
      title: 'STARTIMES',
      image: 'images/startimes.png',
      sizeBo: 40,
      valuePadd: 5),
];

class ChoiceAchat {
  const ChoiceAchat({this.title, this.image, this.sizeBo, this.valuePadd});

  final String? title;
  final String? image;
  final double? sizeBo;
  final double? valuePadd;
}

const kSamaRougeDegradeColor = Color(0xFFf3797d);

const String CountryCode = 'countryCode';
const String CountryCodeText1 = 'texte1';
const String CountryCodeText2 = 'texte2';
const String CountryCodeText3 = 'texte3';
const String CountryCodeText4 = 'texte4';

const String OptCode = 'optCode';
const String OptCodeTitre = 'titre';
const String OptCodeButton = 'button';
const String OptCodeText1 = 'texte1';
const String OptCodeText2 = 'texte2';

const String Login = 'login';
const String LoginErrorMessage1 = 'errorMessage1';
const String LoginButton = 'button';
const String LoginChamp1 = 'champ1';
const String LoginChamp2 = 'champ2';
const String LoginErrorMessage2 = 'errorMessage2';
const String LoginErrorMessage3 = 'errorMessage3';
const String LoginOu = 'ou';

const String Home = 'home';
const String HomeListe1 = 'liste1';
const String HomeListe2 = 'liste2';
const String HomeListe3 = 'liste3';
const String HomeListe4 = 'liste4';
const String HomeListe5 = 'liste5';
const String HomeListe6 = 'liste6';
const String HomeListe7 = 'liste7';
const String HomeListe8 = 'liste8';
const String HomeListe9 = 'liste9';

const String Compte = 'compte';
const String CompteTitre = 'titre';
const String CompteUv = 'uv';
const String CompteCommission = 'commission';
const String CompteSolde = 'solde';

const String Envoi = 'envoi';
const String EnvoiTitre = 'titre';
const String EnvoiButton = 'button';
const String EnvoiChamp1 = 'champ1';
const String EnvoiChamp2 = 'champ2';
const String EnvoiErrorMessage1 = 'errorMessage1';
const String EnvoiErrorMessage2 = 'errorMessage2';
const String EnvoiErrorMessage3 = 'errorMessage3';
const String EnvoiErrorMessage4 = 'errorMessage4';
const String EnvoiPhoneValid = 'phoneValid';

const String EnvoiMontantValid = 'montantValid';
const String EnvoiTexte1 = 'texte1';

const String Retour = 'retour';
const String RetourTitre = 'titre';
const String RetourButton = 'button';
const String RetourChamp1 = 'champ1';
const String RetourMessage1 = 'errorMessage1';

const String Converssion = 'converssion';
const String ConverssionTitre = 'titre';
const String ConverssionButton = 'button';
const String ConverssionChamp1 = 'champ1';
const String ConverssionErrorMessage1 = 'errorMessage1';

const String Password = 'password';
const String PasswordTitre = 'titre';
const String PasswordButton = 'button';
const String PasswordChamp1 = 'champ1';
const String PasswordChamp2 = 'champ2';
const String PasswordChamp3 = 'champ3';

const String PasswordErrorMessage1 = 'errorMessage1';
const String PasswordErrorMessage2 = 'errorMessage2';
const String PasswordErrorMessage3 = 'errorMessage3';
const String PasswordErrorMessage4 = 'errorMessage4';

const String Frais = 'frais';
const String FraisTitre = 'titre';
const String FraisTexte1 = 'texte1';
const String FraisListe1 = 'liste1';
const String FraisListe2 = 'liste2';
const String FraisListe3 = 'liste3';

const String FingerprintMessage = 'fingerprintMessage';
const String MessageTexte1 = 'messageTexte1';
const String MessageOK = 'messageOk';
const String MessageContinue = 'messageContinue';

const String ServiceIndisp = 'serviceIndisp';

const String MessageAnnuler = 'messageAnnuler';
const String NoGroup = 'noGroupe';
const String LanguagesChange = 'changeLanguage';

const String NumNotSame = 'numNotSame';
const String Chargement = 'chargement';

const String NoInternetTitre = 'noInternetTitre';
const String noInternetMessage = 'noInternetMessage';

const String PasseInitTitre = 'passeInitTitre';

const String Bienvenue = 'bienvenue';

const String HistoError1 = 'histoError1';
const String HistoError2 = 'histoError2';

const String ShowDialog = 'showDialog';

const String EnvoiDialog = 'envoiDialog';
const String EnvoiDialog1 = 'envoiDialog1';

const String ConversionDialog = 'conversionDialog';
const String RetourDialog = 'retourDialog';
const String RetourDialog1 = 'retourDialog1';
const String EnvoiDirectDialog = 'envoiDirectDialog';
const String StandartDialog = 'standartDialog';

const String EnvoiDirectDialog1 = 'envoiDirectDialog1';
const String ConversionDialog1 = 'conversionDialog1';

const String ShowDialogChamp1 = 'champ1';
const String ShowDialogErrorMessage1 = 'errorMessage1';
const String ShowDialogErrorMessage2 = 'errorMessage2';

const String Agents = 'agents';
const String ErrorAgent1 = 'errorAgent1';
const String ErrorAgent2 = 'errorAgent2';

const String AgentInfoPhone = 'agentInfoPhone';
const String AgentInfoNom = 'agentInfoNom';
const String AgentInfoDate = 'agentInfoDate';
const String AgentInfoUV = 'agentInfoUV';
const String AgentInfoComm = 'agentInfoComm';

const String Reclamation = 'reclamation';
const String ReclamationTitre = 'titre';
const String ReclamationWhatsapp = 'whatsapp';
const String ReclamationAppel = 'appel';
const String ReclamationTextAppel = 'textappel';
const String ReclamationMail = 'mail';
const String ReclamationMessenger = 'messenger';
const String ReclamationWeb = 'web';

const String FraisDevise = 'fraisdevise';

const String FraisA = 'fraisa';
const String FraisDe = 'fraisde';
const String FraisButton = 'button';

const String FraisErrorMessage1 = 'errorMessage1';
const String FraisTitre1 = 'titre1';
const String FraisChamp1 = 'champ1';

const String FraisTitre2 = 'titre2';
const String FraisTitre3 = 'titre3';
const String FraisBouquet = 'bouquet';

const String FraisCout = 'cout';

const String FraisTexte2 = 'texte2';
const String FraisTexte3 = 'texte3';

const String DrawerC = 'drawer';
const String DrawerListe1 = 'liste1';
const String DrawerListe2 = 'liste2';

const String DrawerListe3 = 'liste3';
const String DrawerListe4 = 'liste4';
const String DrawerListe5 = 'liste5';

const String DrawerTexte1 = 'texte1';
const String DrawerTexte2 = 'texte2';

const String DrawerTexte3 = 'texte3';
const String DrawerTexte4 = 'texte4';
const String DrawerTexte5 = 'texte5';
const String DrawerTexte6 = 'texte6';

const String Inscription = 'inscription';
const String InscriptionButton1 = 'button1';
const String InscriptionButton2 = 'button2';

const String InscriptionTitre = 'titre';
const String InscriptionSoustitre1 = 'soustitre1';
const String InscriptionSoustitre2 = 'soustitre2';
const String InscriptionSoustitre3 = 'soustitre3';

const String InscriptionChamp1 = 'champ1';
const String InscriptionChamp2 = 'champ2';
const String InscriptionChamp3 = 'champ3';
const String InscriptionChamp4 = 'champ4';
const String InscriptionChamp5 = 'champ5';
const String InscriptionChamp6 = 'champ6';
const String InscriptionChamp7 = 'champ7';
const String InscriptionChamp8 = 'champ8';
const String InscriptionChamp9 = 'champ9';
const String InscriptionChamp10 = 'champ10';
const String InscriptionChamp11 = 'champ11';
const String InscriptionChamp12 = 'champ12';
const String InscriptionChamp13 = 'champ13';
const String InscriptionChamp14 = 'champ14';

const String InscriptionErrorMessage1 = 'errorMessage1';
const String InscriptionErrorMessage2 = 'errorMessage2';
const String InscriptionErrorMessage3 = 'errorMessage3';
const String InscriptionErrorMessage4 = 'errorMessage4';
const String InscriptionErrorMessage5 = 'errorMessage5';
const String InscriptionErrorMessage6 = 'errorMessage6';
const String InscriptionErrorMessage7 = 'errorMessage7';
const String InscriptionErrorMessage8 = 'errorMessage8';
const String InscriptionErrorMessage9 = 'errorMessage9';
const String InscriptionErrorMessage10 = 'errorMessage10';
const String InscriptionErrorMessage11 = 'errorMessage11';
const String InscriptionErrorMessage12 = 'errorMessage12';
const String InscriptionErrorMessage13 = 'errorMessage13';

const String ListeRegistration = 'listeRegistration';
const String ListeRegistrationListe1 = 'liste1';
const String ListeRegistrationListe2 = 'liste2';
const String ListeRegistrationListe3 = 'liste3';
const String ListeRegistrationListe4 = 'liste4';
