import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/todo/presentation/pages/home_page.dart';
import 'features/todo/presentation/viewmodels/todo_viewmodel.dart';
import 'features/todo/presentation/viewmodels/theme_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ToDoViewModel()),
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
      ],
      child: Consumer<ThemeViewModel>(
        builder: (context, themeViewModel, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Tasks',
            themeMode: themeViewModel.themeMode,
            theme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.light,
              scaffoldBackgroundColor: const Color(0xFFF5F5F5),
              colorScheme: ColorScheme.light(
                primary: const Color(0xFFE65100),
                secondary: const Color(0xFFFF6D00),
                surface: Colors.white,
                onSurface: Colors.black87,
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF3C4043),
                foregroundColor: Colors.white,
                centerTitle: true,
                elevation: 0,
              ),
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Color(0xFFFF5722),
                foregroundColor: Colors.white,
                shape: CircleBorder(),
              ),
              cardTheme: CardTheme(
                color: Colors.white,
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              iconTheme: const IconThemeData(
                color: Colors.black54,
              ),
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark,
              scaffoldBackgroundColor: const Color(0xFF202124),
              colorScheme: ColorScheme.dark(
                primary: const Color(0xFFFF6D00),
                secondary: const Color(0xFFFFAB40),
                surface: const Color(0xFF303134),
                onSurface: Colors.white,
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF3C4043),
                foregroundColor: Colors.white,
                centerTitle: true,
                elevation: 0,
              ),
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Color(0xFFFF5722),
                foregroundColor: Colors.white,
                shape: CircleBorder(),
              ),
              cardTheme: CardTheme(
                color: const Color(0xFF303134),
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              iconTheme: const IconThemeData(
                color: Colors.white70,
              ),
            ),
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
