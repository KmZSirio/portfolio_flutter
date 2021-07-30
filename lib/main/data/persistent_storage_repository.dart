abstract class PersistentStorageRepository {
  Future<bool> isDarkMode();
  Future<void> updateDarkMode( bool isDarkMode );
  Future<int> whichLanguage();
  Future<void> updateLanguage( int language );
}