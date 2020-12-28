class LanguagesData {
  final String flag;
  final String name;
  final String languageCode;

  LanguagesData(this.flag, this.name, this.languageCode);

  static List<LanguagesData> languageList() {
    return <LanguagesData>[
      LanguagesData("🇺🇸", "English", 'en'),
      LanguagesData("🇮🇳", "हिंदी", 'hi'),
    ];
  }
}