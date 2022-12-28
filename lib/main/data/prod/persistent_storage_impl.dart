import 'package:sirio_portfolio/main/data/persistent_storage_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _isDarkMode = "isDarkMode";
const _language   = "language";
const _is35lbs   = "is35lbs";

class PersistentStorageImpl extends PersistentStorageRepository {

  @override
  Future<bool> isDarkMode() async {
    final preference = await SharedPreferences.getInstance();
    return preference.getBool( _isDarkMode ) ?? false;
  }

  @override
  Future<void> updateDarkMode(bool isDarkMode) async {
    final preference = await SharedPreferences.getInstance();
    await preference.setBool( _isDarkMode, isDarkMode );
    return;
  }

  @override
  Future<int> whichLanguage() async {
    final preference = await SharedPreferences.getInstance();
    return preference.getInt( _language ) ?? 1;
  }

  @override
  Future<void> updateLanguage(int language) async {
    final preference = await SharedPreferences.getInstance();
    await preference.setInt( _language, language );
    return;
  }
  
  @override
  Future<bool> is35lbs() async {
    final preference = await SharedPreferences.getInstance();
    return preference.getBool( _is35lbs ) ?? false;
  }
  
  @override
  Future<void> updateBarWeight(bool is35lbs) async {
    final preference = await SharedPreferences.getInstance();
    await preference.setBool( _is35lbs, is35lbs );
    return;
  }
}