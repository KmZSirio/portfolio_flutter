
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_flutter/main/ui/core/app_theme_cubit.dart';

import 'dependencies.dart';
import 'main/ui/core/theme.dart';
import 'main/ui/main/screens.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}
 
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

    return MultiRepositoryProvider(
      providers: buildRepositories(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider( create: (context) => AppThemeCubit( context.read() )..init() )
        ],
        child: BlocBuilder<AppThemeCubit, bool>(
          builder: ( context, snapshotTheme ) {

            return MaterialApp(
              theme: snapshotTheme ? AppTheme.darkTheme : AppTheme.lightTheme,
              title: 'Portfolio',
              initialRoute: '/home',
              routes: {
                '/home'        : (_) => HomeScreen(),
                '/roundcounter': (_) => RoundCounterScreen(),
                '/barbellcalculator': (_) => BarbellCalculatorScreen(),
                '/rmpercentages': (_) => RMPercentagesScreen(),
              },
              debugShowCheckedModeBanner: false,
            );
          },
        ),
      ),
    );
  }
}