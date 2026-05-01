import 'package:flutter/material.dart';
import 'package:base_project/core/themes/custom_color_extension.dart';

class MyAppThemeHelper {
  // Define DMSans TextTheme
  static TextTheme _dmSansTextTheme(Color textColor, Color displayColor) {
    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'DMSans',
        color: displayColor,
        fontSize: 57,
        fontWeight: FontWeight.w400,
      ),
      displayMedium: TextStyle(
        fontFamily: 'DMSans',
        color: displayColor,
        fontSize: 45,
        fontWeight: FontWeight.w400,
      ),
      displaySmall: TextStyle(
        fontFamily: 'DMSans',
        color: displayColor,
        fontSize: 36,
        fontWeight: FontWeight.w400,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'DMSans',
        color: textColor,
        fontSize: 32,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'DMSans',
        color: textColor,
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'DMSans',
        color: textColor,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        fontFamily: 'DMSans',
        color: textColor,
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: TextStyle(
        fontFamily: 'DMSans',
        color: textColor,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        fontFamily: 'DMSans',
        color: textColor,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'DMSans',
        color: textColor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'DMSans',
        color: textColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        fontFamily: 'DMSans',
        color: textColor,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: TextStyle(
        fontFamily: 'DMSans',
        color: textColor,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        fontFamily: 'DMSans',
        color: textColor,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        fontFamily: 'DMSans',
        color: textColor,
        fontSize: 11,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        brightness: Brightness.light,
        primary: const Color(0xFFBCFF31),
        onPrimary: const Color(0xFFFFFFFF),
        primaryContainer: ThemeData().customColors.primaryColor,
        secondary: const Color(0xffECF0E9),
        onSecondary: const Color(0xFFBCFF31),
        secondaryContainer: const Color(0xFFBCFF31),
        error: const Color(0xFFDE221B),
        onError: const Color(0xFFDE221B),
        surface: const Color(0xFFF8F9FA),
        onSurface: const Color(0xFFBCFF31),
      ),
      scaffoldBackgroundColor: ThemeData().customColors.fillColor,
      brightness: Brightness.light,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      fontFamily: 'DMSans',
      textTheme: _dmSansTextTheme(
        const Color(0xFF000000),
        const Color(0xFF000000),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStatePropertyAll(Color(0xFF2E2E2E)),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF3C651D),
        titleTextStyle: TextStyle(
          fontFamily: 'DMSans',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFFFFFFFF),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Color(0xFF222222), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Color(0xFF222222), width: 1),
        ),
        errorMaxLines: 2,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Color(0xFFBCFF31), width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Color(0xFFDE221B), width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: const Color(
            0xFF3C651D,
          ).withValues(alpha: 0.5),
          backgroundColor: const Color(0xFF3C651D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          textStyle: const TextStyle(
            fontFamily: 'DMSans',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        checkColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return Color(0xFF5C5C5C);
        }),
        side: BorderSide(color: Color(0xFF5C5C5C), width: 2),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Color(0xFF3C651D);
          }
          return Colors.white;
        }),
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: Color(0xFF161616),
        headerBackgroundColor: const Color(0xFFBCFF31),
        headerForegroundColor: Color(0xFF000000),
        dividerColor: Color(0xFF161616),
        locale: const Locale("en", "GB"),
        dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const Color(0xFFBCFF31);
          }
          return Colors.transparent;
        }),
        dayForegroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.black;
          }
          return Colors.white;
        }),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.dark(
        brightness: Brightness.dark,
        primary: const Color(0xFFBCFF31),
        onPrimary: const Color(0xFF000000),
        primaryContainer: ThemeData().customColors.primaryColor,
        secondary: const Color(0xFF000000),
        onSecondary: const Color(0xFFBCFF31),
        secondaryContainer: const Color(0xFFBCFF31),
        error: const Color(0xFFDE221B),
        onError: const Color(0xFFDE221B),
        surface: const Color(0xFF000000),
        onSurface: const Color(0xFFBCFF31),
        outline: const Color(0xFFBCFF31),
      ),
      brightness: Brightness.dark,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      fontFamily: 'DMSans',
      textTheme: _dmSansTextTheme(
        const Color(0xFFFFFFFF),
        const Color(0xFF000000),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStatePropertyAll(Color(0xFF2E2E2E)),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFBCFF31),
        titleTextStyle: TextStyle(
          fontFamily: 'DMSans',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFFFFFFFF),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Color(0xFF222222), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Color(0xFF222222), width: 1),
        ),
        errorMaxLines: 2,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Color(0xFFBCFF31), width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Color(0xFFDE221B), width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: const Color(
            0xFFBCFF31,
          ).withValues(alpha: 0.5),
          backgroundColor: const Color(0xFFBCFF31),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          textStyle: const TextStyle(
            fontFamily: 'DMSans',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        checkColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return Color(0xFF5C5C5C);
        }),
        side: BorderSide(color: Color(0xFF5C5C5C), width: 2),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Color(0xFFBCFF31);
          }
          return Colors.white;
        }),
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: Color(0xFF161616),
        headerBackgroundColor: const Color(0xFFBCFF31),
        headerForegroundColor: Color(0xFF000000),
        dividerColor: Color(0xFF161616),
        locale: const Locale("en", "GB"),

        dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const Color(0xFFBCFF31);
          }
          return Colors.transparent;
        }),
        dayForegroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.black;
          } else if (states.contains(WidgetState.disabled)) {
            return Colors.white.withValues(alpha: 0.5);
          }
          return Colors.white;
        }),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Color(0xFF0F0F0F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        ),
        shadowColor: Color(0xFFBCFF31).withValues(alpha: 0.6),
        elevation: 8.0,
      ),
    );
  }
}
