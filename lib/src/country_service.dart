import 'package:collection/collection.dart';
import 'package:country_picker/src/country.dart';
import 'package:country_picker/src/res/country_codes.dart';

class CountryService {
  CountryService() : _countries = countryCodes.map((country) => Country.from(json: country)).toList();

  final List<Country> _countries;

  ///Return list with all countries
  List<Country> getAll() {
    return _countries;
  }

  ///Returns the first country that mach the given code.
  Country? findByCode(String? code) {
    final uppercaseCode = code?.toUpperCase();
    return _countries.firstWhereOrNull((country) => country.countryCode == uppercaseCode);
  }

  Country? findByPhoneCode(String? code) {
    final uppercaseCode = code?.toUpperCase();
    return _countries.firstWhereOrNull((country) => country.phoneCode == uppercaseCode);
  }

  ///Returns the first country that mach the given name.
  Country? findByName(String? name) {
    return _countries.firstWhereOrNull((country) => country.name == name);
  }

  ///Returns a list with all the countries that mach the given codes list.
  List<Country> findCountriesByCode(List<String> codes) {
    final codes0 = codes.map((code) => code.toUpperCase()).toList();
    final countries = <Country>[];

    for (final code in codes0) {
      final country = findByCode(code);
      if (country != null) {
        countries.add(country);
      }
    }
    return countries;
  }
}
