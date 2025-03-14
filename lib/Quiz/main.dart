import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/Quiz/authen.dart';
import '../provider/theme_provider.dart';
import '../provider/theme.dart';
import '../Quiz/register.dart';
import '../Quiz/forgot.dart';
import '../Quiz/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeProvider.themeMode,
      initialRoute: '/',
      routes: {
        '/': (context) => Authen_Screen(),
        '/home': (context) => Home_Screen(),
        '/register': (context) => Register_Screen(),
        '/forgot': (context) => Forgot_Screen(),
      },
    );
  }
}
