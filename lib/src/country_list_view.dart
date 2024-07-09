import 'package:country_picker/src/country.dart';
import 'package:country_picker/src/country_list_theme_data.dart';
import 'package:country_picker/src/country_localizations.dart';
import 'package:country_picker/src/country_service.dart';
import 'package:country_picker/src/res/country_codes.dart';
import 'package:country_picker/src/utils.dart';
import 'package:flutter/material.dart';

class CountryListView extends StatefulWidget {
  const CountryListView({
    required this.onSelect,
    Key? key,
    this.exclude,
    this.favorite,
    this.countryFilter,
    this.showPhoneCode = false,
    this.countryListTheme,
    this.searchAutofocus = false,
    this.showWorldWide = false,
    this.showSearch = true,
    this.titleText,
    this.hintText,
  })  : assert(
          exclude == null || countryFilter == null,
          'Cannot provide both exclude and countryFilter',
        ),
        super(key: key);

  /// Called when a country is select.
  ///
  /// The country picker passes the new value to the callback.
  final ValueChanged<Country> onSelect;

  /// An optional [showPhoneCode] argument can be used to show phone code.
  final bool showPhoneCode;

  /// An optional [exclude] argument can be used to exclude(remove) one ore more
  /// country from the countries list. It takes a list of country code(iso2).
  /// Note: Can't provide both [exclude] and [countryFilter]
  final List<String>? exclude;

  /// An optional [countryFilter] argument can be used to filter the
  /// list of countries. It takes a list of country code(iso2).
  /// Note: Can't provide both [countryFilter] and [exclude]
  final List<String>? countryFilter;

  /// An optional [favorite] argument can be used to show countries
  /// at the top of the list. It takes a list of country code(iso2).
  final List<String>? favorite;

  /// An optional argument for customizing the
  /// country list bottom sheet.
  final CountryListThemeData? countryListTheme;

  /// An optional argument for initially expanding virtual keyboard
  final bool searchAutofocus;

  /// An optional argument for showing "World Wide" option at the beginning of the list
  final bool showWorldWide;

  /// An optional argument for hiding the search bar
  final bool showSearch;

  final String? titleText;

  final String? hintText;

  @override
  State<CountryListView> createState() => _CountryListViewState();
}

class _CountryListViewState extends State<CountryListView> {
  final CountryService _countryService = CountryService();
  List<Country> _searchResult = <Country>[];
  late List<Country> _countryList;
  late List<Country> _filteredList;
  List<Country>? _favoriteList;
  late TextEditingController _searchController;
  late bool _searchAutofocus;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();

    _countryList = _countryService.getAll();
    _countryList = countryCodes.map((country) => Country.from(json: country)).toList();

    //Remove duplicates country if not use phone code
    if (!widget.showPhoneCode) {
      final ids = _countryList.map((e) => e.countryCode).toSet();
      _countryList.retainWhere((country) => ids.remove(country.countryCode));
    }

    if (widget.favorite != null) {
      _favoriteList = _countryService.findCountriesByCode(widget.favorite!);
    }

    if (widget.exclude != null) {
      _countryList.removeWhere(
        (element) => widget.exclude!.contains(element.countryCode),
      );
    }

    if (widget.countryFilter != null) {
      _countryList.removeWhere(
        (element) => !widget.countryFilter!.contains(element.countryCode),
      );
    }

    _filteredList = <Country>[];
    if (widget.showWorldWide) {
      _filteredList.add(Country.worldWide);
    }

    _filteredList.addAll(_countryList);
    _searchAutofocus = widget.searchAutofocus;
  }

  @override
  Widget build(BuildContext context) {
    final searchLabel = widget.hintText ?? CountryLocalizations.of(context)?.countryName(countryCode: 'search') ?? 'Search';

    return Column(
      children: <Widget>[
        const SizedBox(height: 12),
        if (widget.titleText?.isNotEmpty ?? false) ...{
          Text(
            widget.titleText ?? '',
            style: widget.countryListTheme?.titleTextStyle ?? _defaultTextStyle,
          ),
        },
        if (widget.showSearch) ...{
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: TextField(
              autofocus: _searchAutofocus,
              controller: _searchController,
              style: widget.countryListTheme?.searchTextStyle ?? _defaultTextStyle,
              decoration: widget.countryListTheme?.inputDecoration ??
                  InputDecoration(
                    labelText: searchLabel,
                    hintText: searchLabel,
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: const Color(0xFF8C98A8).withOpacity(0.2),
                      ),
                    ),
                  ),
              onChanged: _filterSearchResults,
            ),
          ),
        },
        if (_filteredList.isNotEmpty) ...{
          Expanded(
            child: ListView(
              children: [
                if (_favoriteList != null) ...{
                  ..._favoriteList!.map<Widget>(_listRow),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(thickness: 1),
                  ),
                },
                ..._filteredList.map<Widget>(_listRow),
              ],
            ),
          ),
        } else ...{
          Expanded(
            child: Center(
              child: Text(
                widget.countryListTheme?.emptyText ?? 'Data is not available',
                style: widget.countryListTheme?.emptyTextStyle ?? _defaultTextStyle,
              ),
            ),
          ),
        },
      ],
    );
  }

  Widget _listRow(Country country) {
    final textStyle = widget.countryListTheme?.textStyle ?? _defaultTextStyle;
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Material(
      // Add Material Widget with transparent color
      // so the ripple effect of InkWell will show on tap
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          country.nameLocalized = CountryLocalizations.of(context)?.countryName(countryCode: country.countryCode)?.replaceAll(RegExp(r'\s+'), ' ');
          widget.onSelect(country);
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              const SizedBox(width: 20),
              _flagWidget(country),
              if (widget.showPhoneCode && !country.iswWorldWide) ...{
                const SizedBox(width: 15),
                SizedBox(
                  width: 60,
                  child: Text(
                    '${isRtl ? '' : '+'}${country.phoneCode}${isRtl ? '+' : ''}',
                    style: textStyle,
                  ),
                ),
                const SizedBox(width: 5),
              } else ...{
                const SizedBox(width: 15),
              },
              Expanded(
                child: Text(
                  CountryLocalizations.of(context)?.countryName(countryCode: country.countryCode)?.replaceAll(RegExp(r'\s+'), ' ') ?? country.name,
                  style: textStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _flagWidget(Country country) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return SizedBox(
      // the conditional 50 prevents irregularities caused by the flags in RTL mode
      width: isRtl ? 50 : null,
      child: Text(
        country.iswWorldWide ? '\uD83C\uDF0D' : Utils.countryCodeToEmoji(country.countryCode),
        style: TextStyle(
          fontSize: widget.countryListTheme?.flagSize ?? 25,
        ),
      ),
    );
  }

  void _filterSearchResults(String query) {
    final localizations = CountryLocalizations.of(context);

    if (query.isEmpty) {
      _searchResult.addAll(_countryList);
    } else {
      _searchResult = _countryList.where((c) => c.startsWith(query, localizations)).toList();
      if (_searchResult.isEmpty) {
      } else {}
      setState(() => _filteredList = _searchResult);
    }
  }

  TextStyle get _defaultTextStyle => const TextStyle(fontSize: 16);
}
