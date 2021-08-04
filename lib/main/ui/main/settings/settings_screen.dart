import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_flutter/main/core/app_theme_cubit.dart';
import 'package:portfolio_flutter/main/ui/main/settings/settings_cubit.dart';
import 'package:portfolio_flutter/main/common_widgets/fake_appbar.dart';


class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return MultiBlocProvider(
      providers: [

        BlocProvider(
          create: (_) => 
              SettingsSwitchCubit( context.read<AppThemeCubit>().isDark ),
        )

      ],
      child: Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                
                SizedBox( height: 30 ),
                fakeAppBar(
                  context: context, 
                  size: size, 
                  text: "Settings",
                  showButton: false),
                SizedBox( height: 40 ),
                _darkModeCard()

              ]
            ),
          ),
        ),
      ),
    );
  }



  Card _darkModeCard() {

    return Card(
      child: BlocBuilder<AppThemeCubit, bool>(builder: (context, snapshot) {

        return SwitchListTile(
          value: snapshot, 
          onChanged: (value) {
            context.read<SettingsSwitchCubit>().onChangeDarkMode( value );
            context.read<AppThemeCubit>().updateTheme( value );
          },
          title: Text(
            "Dark Mode",
            style: TextStyle( color: Theme.of(context).scaffoldBackgroundColor, fontSize: 18 ),
          ),
        );
      }),
    );
  }
}