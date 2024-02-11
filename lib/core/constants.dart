// ignore_for_file: constant_identifier_names, camel_case_types

class SETTINGS_KEY {
  // SEED COLOR
  static const String SEED_COLOR_KEY = 'sc';
  static const String SEED_COLOR_PINK = 'Pink';
  static const String SEED_COLOR_RED = 'Red';
  static const String SEED_COLOR_ORANGE = 'Orange';
  static const String SEED_COLOR_AMBER = 'Amber';
  static const String SEED_COLOR_YELLOW = 'Yellow';
  static const String SEED_COLOR_LIME = 'Lime';
  static const String SEED_COLOR_GREEN = 'Green';
  static const String SEED_COLOR_TEAL = 'Teal';
  static const String SEED_COLOR_CYAN = 'Cyan';
  static const String SEED_COLOR_BLUE = 'Blue';
  static const String SEED_COLOR_INDIGO = 'Indigo';
  static const String SEED_COLOR_PURPLE = 'Purple';
  static const String SEED_COLOR_BLUE_GREY = 'Blue Grey';
  static const String SEED_COLOR_BROWN = 'Brown';
  static const String SEED_COLOR_GREY = 'Grey';

  static const List<String> SEED_COLORS = [
    SEED_COLOR_AMBER,
    SEED_COLOR_BLUE,
    SEED_COLOR_BLUE_GREY,
    SEED_COLOR_BROWN,
    SEED_COLOR_CYAN,
    SEED_COLOR_GREEN,
    SEED_COLOR_GREY,
    SEED_COLOR_INDIGO,
    SEED_COLOR_LIME,
    SEED_COLOR_ORANGE,
    SEED_COLOR_PINK,
    SEED_COLOR_PURPLE,
    SEED_COLOR_RED,
    SEED_COLOR_TEAL,
    SEED_COLOR_YELLOW
  ];
  // BRIGHTNESS
  static const String BRIGHTNESS_KEY = 'br';

  // TEXT FONT SIZE
  static const int TASK_FONT_SIZE_DEFAULT = 14;
  static const String TASK_FONT_SIZE_KEY = 'fts';
}

class DOTENV {
  static const String REALM_APP_ID = "REALM_APP_ID";
}

class NEW_TASK {
  static const String DEFAULT_NO_DUE_DATE = 'none';
}
