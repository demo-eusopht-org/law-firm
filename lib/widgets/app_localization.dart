// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
//
// class AppLocalization {
//   final Locale locale;
//
//   AppLocalization(this.locale);
//
//   static AppLocalization of(BuildContext context) {
//     return Localizations.of(context, AppLocalization)!;
//   }
//
//   late Map<String, String> _localizedValues = {}; // Initialize here
//
//   Future loadJson() async {
//     String jsonStringValues =
//         await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
//
//     Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
//
//     _localizedValues = mappedJson.map(
//       (key, value) => MapEntry(
//         key,
//         value.toString(),
//       ),
//     );
//   }
//
//   String? getTranslatedValues(String key) {
//     return _localizedValues[key];
//   }
//
//   static const LocalizationsDelegate<AppLocalization> delegate =
//       _AppLocalizationDelegate();
// }
//
// class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
//   const _AppLocalizationDelegate();
//
//   @override
//   bool isSupported(Locale locale) {
//     return ['en', 'ur'].contains(locale.languageCode);
//   }
//
//   @override
//   Future<AppLocalization> load(Locale locale) async {
//     AppLocalization localization = AppLocalization(locale);
//     await localization.loadJson();
//     return localization;
//   }
//
//   @override
//   bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) {
//     return false;
//   }
// }
