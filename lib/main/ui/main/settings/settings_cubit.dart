import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsSwitchCubit extends Cubit<bool> {
  SettingsSwitchCubit( bool state ) : super(state);

  void onChangeDarkMode( bool isDark ) => emit( isDark );
  void onChangeBarWeight( bool is35lbs ) => emit( is35lbs );
}