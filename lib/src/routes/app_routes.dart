class AppRoutes {
  static const String root = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String setupProfil = '/setup-profil';
  static const String catatanHarian = '/catatan-harian';
  static const String rekapBulanan = 'rekap-bulanan';
  static const String rekapMingguan = 'rekap-mingguan';
  static const String resep = '/resep';
  static const String profil = '/profil';
  static const String updateProfil = 'update-profil';
  static const String updatePassword = 'update-password';
  static const String asupan = '/asupan';
  static const String tambahMenu = 'tambah-menu';
  static const String konfirmasiMenu = 'konfirmasi-menu';

  static const List<String> rootPaths = [root, login, register];

  static const List<String> protectedPaths = [
    setupProfil,
    catatanHarian,
    rekapBulanan,
    rekapMingguan,
    resep,
    profil,
    updateProfil,
    updatePassword,
    asupan,
    tambahMenu,
    konfirmasiMenu,
  ];
}
