
import 'package:my_gallery/core/storage/shared_pref_storage.dart';

class StorageProvider {
  static const _storagePrefix = 'app_storage';

  static const _keyUserId = 'user_id';
  static const _keyToken = 'token';
  static const _keyFirstName = 'first_name';
  static const _keyLastName = 'last_name';
  static const _keyDisplayName = 'display_name';
  static const _keyEmail = 'email';
  static const _keyPassword = 'password';
  static const _keyRole = 'role';
  static const _keyPhotoUrl = 'photo_url';
  static const _keyEmailVerified = 'email_verified';
  static const _keyAuthProvider = 'auth_provider';
  static const _keyLastLogin = 'last_login';
  static const _keyInitialization = 'initialization';
  static const _keyTermsCondition = 'terms_condition';

  final SharedPrefStorage _storage;

  StorageProvider._(this._storage);

  static Future<StorageProvider> create() async {
    final storage = SharedPrefStorage(prefix: _storagePrefix);
    await storage.init();
    return StorageProvider._(storage);
  }

  Future<void> clear() => _storage.clear();

  // String
  String? get userId => _storage.get<String>(_keyUserId);
  set userId(String? value) => _storage.set<String>(_keyUserId, value ?? '');

  String? get token => _storage.get<String>(_keyToken);
  set token(String? value) => _storage.set<String>(_keyToken, value ?? '');

  String? get displayName => _storage.get<String>(_keyDisplayName);
  set displayName(String? value) => _storage.set<String>(_keyDisplayName, value ?? '');

  String? get firstName => _storage.get<String>(_keyFirstName);
  set firstName(String? value) => _storage.set<String>(_keyFirstName, value ?? '');

  String? get lastName => _storage.get<String>(_keyLastName);
  set lastName(String? value) => _storage.set<String>(_keyLastName, value ?? '');

  String? get email => _storage.get<String>(_keyEmail);
  set email(String? value) => _storage.set<String>(_keyEmail, value ?? '');

  String? get password => _storage.get<String>(_keyPassword);
  set password(String? value) => _storage.set<String>(_keyPassword, value ?? '');

  String? get role => _storage.get<String>(_keyRole);
  set role(String? value) => _storage.set<String>(_keyRole, value ?? '');

  String? get photoUrl => _storage.get<String>(_keyPhotoUrl);
  set photoUrl(String? value) => _storage.set<String>(_keyPhotoUrl, value ?? '');

  String? get authProvider => _storage.get<String>(_keyAuthProvider);
  set authProvider(String? value) => _storage.set<String>(_keyAuthProvider, value ?? '');

  // Int
  // int get age => _storage.get<int>(_keyAge, defaultValue: 0)!;
  // set age(int value) => _storage.set<int>(_keyAge, value);

  // Bool
  bool get isInitialization => _storage.get<bool>(_keyInitialization, defaultValue: false)!;
  set isInitialization(bool value) => _storage.set<bool>(_keyInitialization, value);

  bool get isTermsCondition => _storage.get<bool>(_keyTermsCondition, defaultValue: false)!;
  set isTermsCondition(bool value) => _storage.set<bool>(_keyTermsCondition, value);

  bool get emailVerified => _storage.get<bool>(_keyEmailVerified, defaultValue: false)!;
  set emailVerified(bool value) => _storage.set<bool>(_keyEmailVerified, value);

  // // Double
  // double get balance => _storage.get<double>(_keyBalance, defaultValue: 0.0)!;
  // set balance(double value) => _storage.set<double>(_keyBalance, value);

  // DateTime (di-handle sebagai String ISO)
  // DateTime? get lastLogin {
  //   final str = _storage.get<String>(_keyLastLogin);
  //   return str != null ? DateTime.tryParse(str) : null;
  // }

  set lastLogin(DateTime? value) {
    _storage.set<String>(_keyLastLogin, value?.toIso8601String() ?? '');
  }
}
