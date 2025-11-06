// Menggunakan mekanisme yang umum di Flutter untuk mengelola environment variable.
// Pastikan variabel ini didefinisikan saat compile (misalnya, menggunakan --dart-define).

class Env {
  // Singleton Pattern
  static final Env _instance = Env._internal();

  factory Env() => _instance;

  Env._internal();

  // --- Core Configuration ---

  /// Base URL API utama (Contoh: https://api.notula.ai/)
  // ⚠️ Anda harus mengganti nilai placeholder ini dengan nilai Base URL yang sebenarnya
  final String apiBaseUrl = ''; 
  
  /// Status apakah aplikasi sedang dalam mode debug/development
  // Kita asumsikan ini true di environment dev/debug
  final bool isInDebugMode = true; 

  // --- HTTP Timeouts (Digunakan oleh AppHttpManager) ---
  
  /// Timeout untuk request normal (dalam detik)
  final int configHttpTimeout = 60; 

  /// Timeout untuk request upload gambar (lebih lama, dalam detik)
  final int configHttpUploadTimeout = 120; 

  // --- Demo Credentials (Opsional, dari .env file Anda) ---

  // Ini hanya contoh, disarankan tidak menyimpan kredensial di kode sumber
  final String demoUsername = '0856736576456';
  final String demoPassword = '36576456';

  // Helper untuk mendapatkan config yang berbeda berdasarkan build flavor (jika ada)
  // Anda dapat memperluas ini untuk mendukung multiple environment (dev, staging, prod)
}
