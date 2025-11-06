class StringResources {
  StringResources._();

  //! Core
  static const String baseUrl = 'https://notula.ai';
  static const String nameApps = 'Notula AI';
  static const String nameAppsFirst = 'Notula ';
  static const String nameAppsLast = 'AI';
  static const String emailPattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static const String passwordPattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{6,}$';

  static const String networkFailureMessage =
      "Koneksi internet Anda tidak stabil atau terputus. Silakan periksa jaringan Anda dan coba kembali.";
  static const String authenticationFailureMessage = "Autentikasi gagal. Silakan periksa kredensial Anda dan coba lagi."; 

  //! Onboarding
  static String bordingIn = "Masuk";
  static String bordingDontHaveAccount = "Tidak punya akun? ";
  static String bordingSignUp = "Daftar Sekarang";
  //! Onboarding Informastion Feature
  static String onSlideOnetitle = 'Rekaman & \nTranskrip Otomatis';
  static String onSlideOneDesc =
      'Rekam meeting langsung dari browser Anda dan dapatkan transkrip secara real-time dengan dukungan penuh Bahasa Indonesia.';
  static String onSlideSecondtitle = 'Rangkuman Meeting (MoM)';
  static String onSlideSecondDesc =
      'AI kami secara otomatis menghasilkan rangkuman meeting dalam format formal, poin-poin, atau conversational sesuai kebutuhan Anda.';
  static String onSlideTreetitle = 'Join Meeting Online';
  static String onSlideTreeDesc =
      'Cukup paste link meeting (Zoom, Google Meet, MS Teams) dan notula.ai akan bergabung sebagai peserta untuk mencatat semuanya.';
  static String onSlideFourtitle = 'Export & \nSharing';
  static String onSlideFourDesc =
      'Ekspor transkrip dan ringkasan ke Word/PDF atau bagikan dengan cepat via link yang dapat disesuaikan aksesnya.';

  //! Registration
  static String registration = 'Registration';
  static String txtForgetPassword = 'Lupa Password?';
  static String txtSubForgetPassword = 'Masukkan email Anda dan kami akan mengirimkan link untuk reset password';
  static String txtRegisSignUp = 'Daftar';
  static String txtRegisSubSignUp = 'Buat akun baru untuk menggunakan Notula AI';
  static String txtRegisCharacterPwd = 'Password harus mengandung huruf kecil, huruf besar, dan angka (min. 6 karakter)';
  static const String errorLoginRegister = "Gagal registrasi:";

  //! Auth
  static String login = 'Masuk';
  static String txtSubLogin = 'Masukkan email dan password untuk masuk ke akun Anda';
}
