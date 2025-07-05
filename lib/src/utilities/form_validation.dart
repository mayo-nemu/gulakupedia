class InputValidation {
  InputValidation._();

  static String? validateEmail(String? email) {
    if (email == null) return 'Email tidak boleh dikosongkan';
    if (!RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(email)) {
      return 'Format email tidak valid';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null) return 'Password tidak boleh dikosongkan';
    if (password.length < 6) {
      return 'Password harus mengandung 6 karakter atau lebih';
    }
    return null;
  }

  static String? validateUsername(String? username) {
    if (username == null) return 'Nama tidak boleh dikosongkan';
    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(username)) {
      return 'Nama hanya boleh mengandung huruf';
    }
    return null;
  }
}
