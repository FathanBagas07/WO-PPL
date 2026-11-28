import 'package:material_ui/material_ui.dart';

class WOrganiceColors {
  // Token utama dari WOrganice · Rose design system
  static const Color bg = Color(0xFFFFF9F6);
  static const Color ink = Color(0xFF542E3C);
  static const Color primary = Color(0xFF924D65);
  static const Color muted = Color(0xFF756068);
  static const Color line = Color(0xFFEADADD);
  static const Color pale = Color(0xFFF8E9EC);
  static const Color white = Color(0xFFFFFFFF);

  // Token aksen & status
  static const Color sage = Color(0xFF47634C);
  static const Color sageBg = Color(0xFFEDF3EA);
  static const Color error = Color(0xFFA33F3F);
  static const Color errorBg = Color(0xFFFBEDEC);
  static const Color warn = Color(0xFF815719);
  static const Color warnBg = Color(0xFFFFF3DB);

  // Alias kompatibilitas dengan widget yang sudah ada
  static const Color background = bg;
  static const Color surfaceWhite = white;
  static const Color headerSurface = bg;
  static const Color primaryPlum = primary;
  static const Color primaryPlumDark = ink;
  static const Color softRoseFill = pale;
  static const Color borderNeutral = line;
  static const Color textDark = ink;
  static const Color textMuted = muted;
  static const Color textHint = muted;
  static const Color rosePetal = primary;
  static const Color rosePetalDark = ink;
  static const Color leafSage = sage;
}

class WOrganiceSpacing {
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;

  static const double controlRadius = 8;
  static const double cardRadius = 12;
  static const double minTouchTarget = 48;
}

class WOrganiceTheme {
  static const String fontFamily = 'Inter';

  static ThemeData get lightTheme {
    final colorScheme = const ColorScheme(
      brightness: Brightness.light,
      primary: WOrganiceColors.primary,
      onPrimary: WOrganiceColors.white,
      primaryContainer: WOrganiceColors.pale,
      onPrimaryContainer: WOrganiceColors.ink,
      secondary: WOrganiceColors.sage,
      onSecondary: WOrganiceColors.white,
      secondaryContainer: WOrganiceColors.sageBg,
      onSecondaryContainer: WOrganiceColors.sage,
      error: WOrganiceColors.error,
      onError: WOrganiceColors.white,
      errorContainer: WOrganiceColors.errorBg,
      onErrorContainer: WOrganiceColors.error,
      surface: WOrganiceColors.white,
      onSurface: WOrganiceColors.ink,
      surfaceContainerLowest: WOrganiceColors.white,
      surfaceContainerLow: WOrganiceColors.bg,
      surfaceContainer: WOrganiceColors.pale,
      outline: WOrganiceColors.line,
      outlineVariant: WOrganiceColors.line,
    );

    final textTheme = const TextTheme(
      headlineMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 28,
        height: 36 / 28,
        fontWeight: FontWeight.w700,
        color: WOrganiceColors.ink,
      ),
      titleLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 20,
        height: 29 / 20,
        fontWeight: FontWeight.w600,
        color: WOrganiceColors.ink,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w400,
        color: WOrganiceColors.ink,
      ),
      labelLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w600,
        color: WOrganiceColors.ink,
      ),
      bodySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        height: 17 / 12,
        fontWeight: FontWeight.w400,
        color: WOrganiceColors.muted,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      fontFamily: fontFamily,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: WOrganiceColors.bg,
      textTheme: textTheme,
      cardTheme: CardThemeData(
        color: WOrganiceColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(WOrganiceSpacing.cardRadius),
          side: const BorderSide(color: WOrganiceColors.line),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: WOrganiceColors.white,
        hintStyle: textTheme.bodyMedium?.copyWith(color: WOrganiceColors.muted),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: WOrganiceSpacing.md,
          vertical: WOrganiceSpacing.sm,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(WOrganiceSpacing.controlRadius),
          borderSide: const BorderSide(color: WOrganiceColors.line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(WOrganiceSpacing.controlRadius),
          borderSide: const BorderSide(color: WOrganiceColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(WOrganiceSpacing.controlRadius),
          borderSide: const BorderSide(color: WOrganiceColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(WOrganiceSpacing.controlRadius),
          borderSide: const BorderSide(color: WOrganiceColors.error, width: 1.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(WOrganiceSpacing.minTouchTarget),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(WOrganiceSpacing.controlRadius),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
    );
  }
}