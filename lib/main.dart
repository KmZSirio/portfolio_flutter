import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dependencies.dart';
import 'main/core/app_theme_cubit.dart';
import 'main/core/bar_weight_cubit.dart';
import 'main/core/theme.dart';
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

    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent
    // ));

    return MultiRepositoryProvider(
      providers: buildRepositories(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider( create: (context) => AppThemeCubit( context.read() )..init() ),
          BlocProvider( create: (context) => BarWeightCubit( context.read() )..init() ),
        ],
        child: BlocBuilder<AppThemeCubit, bool>(
          builder: ( context, snapshotTheme ) {

            return MaterialApp(
              theme: snapshotTheme ? AppTheme.lightTheme : AppTheme.lightTheme,
              // theme: snapshotTheme ? AppTheme.darkTheme : AppTheme.lightTheme,
              title: "Calcular %'s",
              initialRoute: '/home',
              routes: {
                '/home'             : (_) => HomeScreen(),
                '/barbellcalculator': (_) => BarbellCalculatorScreen(),
                '/rmpercentages'    : (_) => RMPercentagesScreen()
              },
              debugShowCheckedModeBanner: false,
              
            );
          },
        ),
      ),
    );
  }
}