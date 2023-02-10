import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/state_manager.dart';
import 'package:masterappp/models/countries.dart';

class CountryListController extends GetxController {
  var isCountryListLoaded = false.obs;

  var isCountryListLoadedIntl = false.obs;

  var countryList = <Country>[].obs;

  var countryListIntl = <Country>[].obs;

  @override
  void onInit() {
    // ignore: avoid_print
    print('start');
    super.onInit();
    loadCountriesJson().then((value) {
      isCountryListLoaded(true);
    });
    loadCountriesJsonIntl().then((value) {
      isCountryListLoadedIntl(true);
    });
  }

  Future<dynamic> loadCountriesJson() async {
    //countryList.clear();

    final data = await rootBundle.loadString('data/country_phone_codes.json');
    final countriesJson = json.decode(data);

    // ignore: avoid_print
    print(countriesJson);
    for (var country in countriesJson) {
      countryList.add(Country.fromJson(country));
    }
  }

  Future<dynamic> loadCountriesJsonIntl() async {
    final data = await rootBundle.loadString('data/envoi_phone_codes.json');
    final countriesJson = json.decode(data);

    // ignore: avoid_print
    print(countriesJson);
    for (var country in countriesJson) {
      countryListIntl.add(Country.fromJson(country));
    }
  }
}
