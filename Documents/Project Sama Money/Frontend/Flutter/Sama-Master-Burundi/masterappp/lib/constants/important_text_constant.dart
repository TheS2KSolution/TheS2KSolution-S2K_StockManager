import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kSamaBleuColor = Color(0xFF01224b);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

const headingStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

final otpInputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 3),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(3),
    borderSide: const BorderSide(color: kTextColor),
  );
}

const kMotDePasseInputDecoration = InputDecoration(
  icon: Icon(
    Icons.lock,
    color: Colors.white,
    size: 26,
  ),
//  hintText: ,
  hintText: 'Mot de passe',
  hintStyle: TextStyle(
      color: Colors.white,
      fontSize: 22,
      letterSpacing: 2,
      fontWeight: FontWeight.normal),
  errorStyle: TextStyle(color: Colors.white),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  ),
);

const kTextFieldContainerBoxDecoration = BoxDecoration(
  color: Color(0xFFEDEEEE),
  borderRadius: _cornerRadius,
);

const _rowHeight = 10.0;
const _cornerRadius = BorderRadius.all(Radius.circular(_rowHeight));

const kTextFieldStyle = TextStyle(
    fontWeight: FontWeight.bold, fontSize: 22.0, color: Color(0xFF01224b));

const kTextFieldStylePassword = TextStyle(
    fontWeight: FontWeight.bold, fontSize: 18.0, color: Color(0xFF01224b));

const kTextFieldContainerPadding =
    EdgeInsets.only(left: 4.0, right: 4.0, top: 6.0, bottom: 6.0);

const kTextFieldContainerPaddingPassword =
    EdgeInsets.only(left: 2.0, right: 2.0, top: 4.0, bottom: 4.0);

const kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.only(left: 5),
  hintText: 'Entrez le numéro du bénéficiaire',
  errorStyle: TextStyle(
    color: Colors.black87,
  ),
  hintStyle: TextStyle(
      letterSpacing: 0.0,
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      color: Colors.black87),
  enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
  focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
);

const kTextFieldDecorationPassword = InputDecoration(
  contentPadding: EdgeInsets.only(left: 5),
  hintText: 'Entrez le numéro du bénéficiaire',
  hintStyle: TextStyle(
      letterSpacing: 0.0,
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: Colors.black87),
  enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
  focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
);

const List<String> trancheDepart = [
  '2 000',
  '5 001',
  '10 001',
  '20 001',
  '30 001',
  '50 001',
  '75 001',
  '100 001',
  '150 001',
  '200 001',
  '300 001',
  '400 001',
  '500 001',
  '750 001',
  '1 000 001',
  '1 500 001'
];

const List<String> trancheFin = [
  '5 000',
  '10 000',
  '20 000',
  '30 000',
  '50 000',
  '75 000',
  '100 000',
  '150 000',
  '200 000',
  '300 000',
  '400 000',
  '500 000',
  '750 000',
  '1 000 000',
  '1 500 000',
  '2 000 000'
];

const List<String> frais = [
  '150',
  '300',
  '500',
  '750',
  '1 350',
  '1 700',
  '2 500',
  '3 000',
  '4 000',
  '6 000',
  '8 000',
  '11 000',
  '12 000',
  '15 000',
  '20 000',
  '25 000'
];

const List<String> trancheDepartCanal = [
  'ACCESS',
  'EVASION',
  'ESSENTIEL +',
  'ACCESS +',
  'EVASION +',
  'TOUT CANAL +',
];

const List<String> trancheFinCanal = [
  '5 000 F CFA',
  '10 000 F CFA',
  '12 000 F CFA',
  '15 000 F CFA',
  '20 000 F CFA',
  '40 000 F CFA',
];

const List<String> trancheDepartStarTimes = [
  'STARTIMES SMART',
  'STARTIMES SUPER',
  'STARTIMES ANGLAISE',
  'STARTIMES CHINOISE',
  'STARTIMES TOUT',
];

const List<String> trancheFinStarTimes = [
  '4 500 F CFA',
  '9 000 F CFA',
  '12 000 F CFA',
  '12 000 F CFA',
  '15 000 F CFA',
];

const List<String> trancheDepartMalivision = [
  'DECOUVERTE',
  'MALIVISION',
  'DECOUVERTE + CANAL',
  'HORONYA',
  'MALIVISION + CANAL',
  'VIP (HORONYA + CANAL)',
];

const List<String> trancheFinMalivision = [
  '5 000 F CFA',
  '12 000 F CFA',
  '15 000 F CFA',
  '15 000 F CFA',
  '20 000 F CFA',
  '25 000 F CFA',
];

const List<String> listeVignetteAutoMarque = [
  'AUDI',
  'BENTLEY',
  'BMW',
  'CHEVROLET',
  'CHRYSLER',
  'CITROEN',
  'DACIA',
  'DODGE',
  'FERRARI',
  'FIAT',
  'FORD',
  'GMC',
  'HONDA',
  'HUMMER',
  'HUNDAY',
  'INFINITI',
  'JEEP',
  'KAWASAKI',
  'LAND ROVER',
  'LEXUS',
  'LINCOLN',
  'MASERATI',
  'MAZDA',
  'MERCEDES-BENZ',
  'NISSAN',
  'OPEL',
  'PEUGEOT',
  'PORCHE',
  'SAAB',
  'SEAT',
  'SKODA',
  'SUZUKI',
  'TOYOTA',
  'VOLKSWAGEN',
  'AUTRE',
];

const List<String> listeVignetteAutoPuissance = [
  '2 - 6 CV',
  '7 - 9 CV',
  '10 - 14 CV',
  '15 - 19 CV',
  '20 CV - PLUS',
];

const List<String> listeVignetteAutoTarif = [
  '7 000 F CFA',
  '13 000 F CFA',
  '32 000 F CFA',
  '50 000 F CFA',
  '75 000 F CFA',
];

const List<String> listeVignetteMotoMarque = [
  'BMW',
  'BOXER',
  'HAOJUE',
  'HONDA',
  'KTM',
  'PULSTAR',
  'RATO',
  'ROYAL',
  'SUZUKI',
  'TVS',
  'YAMAHA',
  'AUTRE',
];

const List<String> listeVignetteMotoPuissance = [
  '51 - 125 CM3',
  '126 CM3 - PLUS',
];

const List<String> listeVignetteMotoTarif = [
  '6 000 F CFA',
  '12 000 F CFA',
];

const List<String> listeVignetteTricycleMarque = [
  'APSONIC',
  'CARGAISON',
  'KAVAKI',
  'TUK TUK',
  'XINGDA',
  'AUTRE',
];

const List<String> listeVignetteTricyclePuissance = [
  'PUISSANCE - MOTEUR 125',
  'PUISSANCE - MOTEUR 150',
  'PPUISSANCE - MOTEUR 175 - 200',
];

const List<String> listeVignetteTricycleTarif = [
  '33 000 F CFA',
  '46 000 F CFA',
  '60 000 F CFA',
];

const List<String> listeVignetteCamionMarque = [
  'DAF',
  'MAN',
  'MERCEDES-BENZ',
  'RENAULT',
  'SCANIA',
  'VOLVO',
  'AUTRE',
];

const List<String> listeVignetteCamionPuissance = [
  'AGE : - 10 ANS',
  'AGE : + 10 ANS',
];

const List<String> listeVignetteCamion10TTarif = [
  '188 600 F CFA',
  '133 400 F CFA',
];

const List<String> listeVignetteCamion15TTarif = [
  '243 800 F CFA',
  '170 200 F CFA',
];

const List<String> listeVignetteCamion24TTarif = [
  '414 000 F CFA',
  '289 800 F CFA',
];

const List<String> listeVignetteTransportPublicMarque = [
  'IVECO',
  'MERCEDES-BENZ',
  'PEUGEOT',
  'TOYOTA',
  'AUTRE',
];

const List<String> listeVignetteTransportPublic36P45PMarque = [
  'MERCEDES-BENZ',
  'RENAULT',
];

const List<String> listeVignetteTransportPublicPuissance = [
  'AGE : - 2 ANS',
  'AGE : + 2 ANS',
];

const List<String> listeVignetteTransportPublic16PTTarif = [
  '128 000 F CFA',
  '88 000 F CFA',
];

const List<String> listeVignetteTransportPublic17P35PTTarif = [
  '168 000 F CFA',
  '116 000 F CFA',
];

const List<String> listeVignetteTransportPublic36P45PTTarif = [
  '253 000 F CFA',
  '174 800 F CFA',
];

const List<String> listeVignetteTransportPublic45PTTarif = [
  '326 600 F CFA',
  '230 000 F CFA',
];
