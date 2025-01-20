import 'package:country_picker/src/country.dart';
import 'package:country_picker/src/country_list_theme_data.dart';
import 'package:country_picker/src/country_list_view.dart';
import 'package:flutter/material.dart';

/// Country list bottom sheet
void showCountryListBottomSheet({
  required BuildContext context,
  required ValueChanged<Country> onSelect,
  VoidCallback? onClosed,
  List<String>? favorite,
  List<String>? exclude,
  List<String>? countryFilter,
  bool showPhoneCode = false,
  CountryListThemeData? countryListTheme,
  bool searchAutofocus = false,
  bool showWorldWide = false,
  bool showSearch = true,
  bool useSafeArea = false,
  bool isDismissible = true,
  String? titleText,
}) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    useSafeArea: useSafeArea,
    isDismissible: isDismissible,
    enableDrag: isDismissible,
    builder: (context) => _builder(
      context,
      onSelect,
      favorite,
      exclude,
      countryFilter,
      showPhoneCode,
      countryListTheme,
      searchAutofocus,
      showWorldWide,
      showSearch,
      titleText,
    ),
  ).whenComplete(() {
    if (onClosed != null) onClosed();
  });
}

Widget _builder(
  BuildContext context,
  ValueChanged<Country> onSelect,
  List<String>? favorite,
  List<String>? exclude,
  List<String>? countryFilter,
  bool showPhoneCode,
  CountryListThemeData? countryListTheme,
  bool searchAutofocus,
  bool showWorldWide,
  bool showSearch,
  String? titleText,
) {
  final device = MediaQuery.of(context).size.height;
  final statusBarHeight = MediaQuery.of(context).padding.top;
  final height = countryListTheme?.bottomSheetHeight ?? device - (statusBarHeight + (kToolbarHeight / 1.5));

  var backgroundColor = countryListTheme?.backgroundColor ?? Theme.of(context).bottomSheetTheme.backgroundColor;
  if (backgroundColor == null) {
    if (Theme.of(context).brightness == Brightness.light) {
      backgroundColor = Colors.white;
    } else {
      backgroundColor = Colors.black;
    }
  }

  final borderRadius = countryListTheme?.borderRadius ?? const BorderRadius.vertical(top: Radius.circular(40));

  return Container(
    height: height,
    padding: countryListTheme?.padding,
    margin: countryListTheme?.margin,
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: borderRadius,
    ),
    child: CountryListView(
      onSelect: onSelect,
      exclude: exclude,
      favorite: favorite,
      countryFilter: countryFilter,
      showPhoneCode: showPhoneCode,
      countryListTheme: countryListTheme,
      searchAutofocus: searchAutofocus,
      showWorldWide: showWorldWide,
      showSearch: showSearch,
      titleText: titleText,
    ),
  );
}
