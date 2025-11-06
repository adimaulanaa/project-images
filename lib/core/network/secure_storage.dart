// file: core/secure_storage.dart (Asumsi)

class SecureStorage {
  // Ganti ini dengan implementasi storage Anda yang sebenarnya (misalnya flutter_secure_storage)
  String? _token; 

  // Method untuk mengambil token (harus Future/async jika menggunakan flutter_secure_storage)
  Future<String?> getToken() async {
    // Implementasi real: return await _storage.read(key: 'user_token');
    return _token; 
  }
  
  // Getter sederhana
  Future<String?> get token async => await getToken();

  // Method untuk menyimpan token
  Future<void> saveToken(String token) async {
    _token = token;
    // Implementasi real: await _storage.write(key: 'user_token', value: token);
  }
}