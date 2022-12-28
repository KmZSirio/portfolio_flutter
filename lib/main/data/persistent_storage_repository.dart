abstract class PersistentStorageRepository {
  Future<bool> isDarkMode();
  Future<void> updateDarkMode( bool isDarkMode );
  Future<int> whichLanguage();
  Future<void> updateLanguage( int language );
  Future<bool> is35lbs();
  Future<void> updateBarWeight( bool is35lbs );
  
}