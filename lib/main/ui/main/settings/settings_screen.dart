import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirio_portfolio/main/core/app_theme_cubit.dart';
import 'package:sirio_portfolio/main/core/bar_weight_cubit.dart';
import 'package:sirio_portfolio/main/ui/main/settings/settings_cubit.dart';
import 'package:sirio_portfolio/main/common_widgets/fake_appbar.dart';


class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return MultiBlocProvider(
      providers: [

        // BlocProvider(
        //   create: (_) => 
        //       SettingsSwitchCubit( context.read<AppThemeCubit>().isDark ),
        // )
        BlocProvider(
          create: (_) => 
              SettingsSwitchCubit( context.read<BarWeightCubit>().bar35lbs ),
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
                  text: "Configuración",
                  showButton: false),
                SizedBox( height: 40 ),
                // _darkModeCard()
                _barraCard()

              ]
            ),
          ),
        ),
      ),
    );
  }

  Card _barraCard() {

    return Card(
      child: BlocBuilder<BarWeightCubit, bool>(builder: (context, snapshot) {

        return SwitchListTile(
          value: snapshot, 
          onChanged: (value) {
            context.read<SettingsSwitchCubit>().onChangeBarWeight( value );
            context.read<BarWeightCubit>().updateBarWeight( value );
          },
          title: Text(
            "Barra de 35 lb",
            style: TextStyle( color: Theme.of(context).scaffoldBackgroundColor, fontSize: 18 ),
          ),
        );
      }),
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
            "Modo Oscuro",
            style: TextStyle( color: Theme.of(context).scaffoldBackgroundColor, fontSize: 18 ),
          ),
        );
      }),
    );
  }
}