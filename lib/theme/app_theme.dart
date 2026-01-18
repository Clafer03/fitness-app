import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    
    // ESTA ES LA REGLA DE ORO:
    // Define el fondo para TODAS las pantallas de la app
    scaffoldBackgroundColor: AppColors.background, 
    
    // Configuración global de textos
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColors.textPrimary),
      bodySmall: TextStyle(color: AppColors.textSecondary),
    ),

    // Quitamos el color de fondo del AppBar para que se fusione
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontSize: 24, 
        fontWeight: FontWeight.w800, 
        color: AppColors.textPrimary
      ),
    ),
  );
}