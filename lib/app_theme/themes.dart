import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes
{
  ThemeData lightTheme()
  {
    return ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorScheme:  ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: Colors.indigo,
        ),
        brightness: Brightness.light,
        fontFamily: 'Poppins',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 17
            ),
            backgroundColor: const Color(0xff34c3eb),
            side: const BorderSide(
                width: 1
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          hintStyle: GoogleFonts.poppins(
              color: Colors.black,
              fontWeight: FontWeight.w500
          ),
          border: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.grey
              )
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.cyan
              )
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.grey
              )
          ),
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: Colors.blue,
        ),
        listTileTheme: ListTileThemeData(
          tileColor: Colors.orange,
          textColor: Colors.white,
          iconColor: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        cardTheme: CardTheme(
          color: Colors.blueGrey,
          shape: RoundedRectangleBorder(
              side: const BorderSide(
                  color: Colors.orange
              ),
              borderRadius: BorderRadius.circular(8)
          ),
        ),
        textTheme: TextTheme(
            displayLarge : GoogleFonts.poppins(color: Colors.white, fontSize: 20),
            bodyMedium: const TextStyle(color: Colors.black , fontSize: 16),
        )
    );
  }

  ThemeData darkTheme()
  {
    return ThemeData(
        useMaterial3: true,
        //scaffoldBackgroundColor: ColorConstants.darkModeThemeColor,
        //backgroundColor: Colors.orangeAccent,
        brightness: Brightness.dark,
        fontFamily: 'Poppins',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              side: const BorderSide(
                  width: 2
              )
          ),
        ),
        appBarTheme: const AppBarTheme(
            //backgroundColor: ColorConstants.darkModeThemeColor,
            foregroundColor: Colors.white,
            elevation: 0
        ),
        inputDecorationTheme: const InputDecorationTheme(
          //fillColor: ColorConstants.darkModeThemeColor,
          labelStyle: TextStyle(
              color: Colors.grey
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.orange
              )
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.orange
              )
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.grey
              )
          ),
        ),
        listTileTheme: ListTileThemeData(
          tileColor: Colors.orange,
          textColor: Colors.white,
          iconColor: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        cardTheme: CardTheme(
          color: Colors.blueGrey,
          shape: RoundedRectangleBorder(
              side: const BorderSide(
                  color: Colors.orange
              ),
              borderRadius: BorderRadius.circular(8)
          ),
        ),
        textTheme: const TextTheme(
            bodyText2: TextStyle(color: Colors.white)
        )
    );
  }
}