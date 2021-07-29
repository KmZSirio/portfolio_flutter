
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/screens.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black
    ));

    return MaterialApp(
      title: 'Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.red[700],
          foregroundColor: Colors.white
        )
      ),
      initialRoute: '/home',
      routes: {
        '/home'        : (_) => HomeScreen(),
        '/roundcounter': (_) => RoundCounterScreen(),
        '/barbellcalculator': (_) => BarbellCalculatorScreen(),
        '/rmpercentages': (_) => RMPercentagesScreen(),
      },
    );
  }
}