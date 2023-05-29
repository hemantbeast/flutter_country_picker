import 'package:country_picker/src/res/strings/ar.dart';
import 'package:country_picker/src/res/strings/cn.dart';
import 'package:country_picker/src/res/strings/de.dart';
import 'package:country_picker/src/res/strings/en.dart';
import 'package:country_picker/src/res/strings/es.dart';
import 'package:country_picker/src/res/strings/et.dart';
import 'package:country_picker/src/res/strings/fr.dart';
import 'package:country_picker/src/res/strings/gr.dart';
import 'package:country_picker/src/res/strings/hr.dart';
import 'package:country_picker/src/res/strings/it.dart';
import 'package:country_picker/src/res/strings/ku.dart';
import 'package:country_picker/src/res/strings/lt.dart';
import 'package:country_picker/src/res/strings/lv.dart';
import 'package:country_picker/src/res/strings/nb.dart';
import 'package:country_picker/src/res/strings/nl.dart';
import 'package:country_picker/src/res/strings/nn.dart';
import 'package:country_picker/src/res/strings/np.dart';
import 'package:country_picker/src/res/strings/pl.dart';
import 'package:country_picker/src/res/strings/pt.dart';
import 'package:country_picker/src/res/strings/ru.dart';
import 'package:country_picker/src/res/strings/tr.dart';
import 'package:country_picker/src/res/strings/tw.dart';
import 'package:country_picker/src/res/strings/uk.dart';
import 'package:flutter/material.dart';

class CountryLocalizations {
  CountryLocalizations(this.locale);

  final Locale locale;

  /// The `CountryLocalizations` from the closest [Localizations] instance
  /// that encloses the given context.
  ///
  /// This method is just a convenient shorthand for:
  /// `Localizations.of<CountryLocalizations>(context, CountryLocalizations)`.
  ///
  /// References to the localized resources defined by this class are typically
  /// written in terms of this method. For example:
  ///
  /// ```dart
  /// CountryLocalizations.of(context).countryName(countryCode: country.countryCode),
  /// ```
  static CountryLocalizations? of(BuildContext context) {
    return Localizations.of<CountryLocalizations>(
      context,
      CountryLocalizations,
    );
  }

  /// A [LocalizationsDelegate] that uses [_CountryLocalizationsDelegate.load]
  /// to create an instance of this class.
  static const LocalizationsDelegate<CountryLocalizations> delegate = _CountryLocalizationsDelegate();

  /// The localized country name for the given country code.
  String? countryName({required String countryCode}) {
    switch (locale.languageCode) {
      case 'zh':
        switch (locale.scriptCode) {
          case 'Hant':
            return tw[countryCode];
          case 'Hans':
          default:
            return cn[countryCode];
        }
      case 'el':
        return gr[countryCode];
      case 'es':
        return es[countryCode];
      case 'et':
        return et[countryCode];
      case 'pt':
        return pt[countryCode];
      case 'nb':
        return nb[countryCode];
      case 'nn':
        return nn[countryCode];
      case 'uk':
        return uk[countryCode];
      case 'pl':
        return pl[countryCode];
      case 'tr':
        return tr[countryCode];
      case 'ru':
        return ru[countryCode];
      case 'hi':
      case 'ne':
        return np[countryCode];
      case 'ar':
        return ar[countryCode];
      case 'ku':
        return ku[countryCode];
      case 'hr':
        return hr[countryCode];
      case 'fr':
        return fr[countryCode];
      case 'de':
        return de[countryCode];
      case 'lv':
        return lv[countryCode];
      case 'lt':
        return lt[countryCode];
      case 'nl':
        return nl[countryCode];
      case 'it':
        return it[countryCode];
      case 'en':
      default:
        return en[countryCode];
    }
  }
}

class _CountryLocalizationsDelegate extends LocalizationsDelegate<CountryLocalizations> {
  const _CountryLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return [
      'en',
      'ar',
      'ku',
      'zh',
      'el',
      'es',
      'et',
      'pl',
      'pt',
      'nb',
      'nn',
      'ru',
      'uk',
      'hi',
      'ne',
      'tr',
      'hr',
      'fr',
      'de',
      'lt',
      'lv',
      'nl',
      'it',
    ].contains(locale.languageCode);
  }

  @override
  Future<CountryLocalizations> load(Locale locale) {
    final localizations = CountryLocalizations(locale);
    return Future.value(localizations);
  }

  @override
  bool shouldReload(_CountryLocalizationsDelegate old) => false;
}
