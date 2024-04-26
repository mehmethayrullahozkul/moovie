import 'package:workarea_v3/constants.dart';

class ConfigModel {
  final AppTheme theme;
  final AppLanguage language;

  const ConfigModel({
    required this.theme,
    required this.language,
  });

  factory ConfigModel.defaulted() {
    return ConfigModel(
      theme: AppTheme.light,
      language: AppLanguage.en,
    );
  }

  ConfigModel copyWith({
    AppTheme? theme,
    AppLanguage? language,
  }) {
    return ConfigModel(
      theme: theme ?? this.theme,
      language: language ?? this.language,
    );
  }
}
