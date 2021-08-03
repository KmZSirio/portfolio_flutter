
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_flutter/main/tmdb/screens/details_screen.dart';
import 'package:portfolio_flutter/main/tmdb/screens/tmdb_home_screen.dart';
import 'package:provider/provider.dart';

import 'dependencies.dart';
import 'main/core/app_theme_cubit.dart';
import 'main/core/l10n/l10n.dart';
import 'main/core/l10n/l10n_cubit.dart';
import 'main/core/theme.dart';
import 'main/tmdb/providers/movies_provider.dart';
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
          BlocProvider( create: (context) => AppThemeCubit( context.read() )..init() ),
          BlocProvider( create: (context) => L10nCubit( context.read() )..init() ),
        ],
        child: BlocBuilder<AppThemeCubit, bool>(
          builder: ( context, snapshotTheme ) {

            return BlocBuilder<L10nCubit, int >(builder: ( context, snapshotLanguage ) {

              return MultiProvider(
                providers: [

                  ChangeNotifierProvider( create: (_) => MoviesProvider(), lazy: true ),

                ],
                child: MaterialApp(
                  theme: snapshotTheme ? AppTheme.darkTheme : AppTheme.lightTheme,
                  title: 'Portfolio',
                  initialRoute: '/home',
                  routes: {
                    '/home'         : (_) => HomeScreen(),
                    '/roundcounter' : (_) => RoundCounterScreen(),
                    '/barbellcalculator': (_) => BarbellCalculatorScreen(),
                    '/rmpercentages': (_) => RMPercentagesScreen(),
                    '/tmdb_home'    : (_) => TmdbHomeScreen(),
                    '/tmdb_details' : (_) => DetailsScreen(),
                  },
                  supportedLocales: L10n.all,
                  locale: (snapshotLanguage == 1) 
                            ? L10n.en
                            : (snapshotLanguage == 2)
                                ? L10n.es
                                : L10n.en,  // English as predetermined
                  localizationsDelegates: [
                    
                  ],
                  debugShowCheckedModeBanner: false,
                ),
              );
            });
          },
        ),
      ),
    );
  }
}