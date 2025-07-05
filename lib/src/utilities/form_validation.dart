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

  static String? validateWeight(String? number) {
    if (number == null || number.isEmpty) {
      return 'Tidak boleh dikosongkan';
    }
    final int? weight = int.tryParse(number);
    if (weight == null) {
      return 'Bukan angka';
    }
    if (weight < 20 || weight > 300) {
      return 'Berat badan harus antara 20 dan 300 kg';
    }
    return null;
  }

  static String? validateHeight(String? number) {
    if (number == null || number.isEmpty) {
      return 'Tidak boleh dikosongkan';
    }
    final int? height = int.tryParse(number);
    if (height == null) {
      return 'Bukan angka';
    }
    if (height < 50 || height > 250) {
      return 'Tinggi badan harus antara 50 dan 250 cm';
    }
    return null;
  }

  static String? validateBloodSugars(String? number) {
    if (number == null || number.isEmpty) {
      return 'Tidak boleh dikosongkan';
    }
    final int? bloodSugar = int.tryParse(number);
    if (bloodSugar == null) {
      return 'Bukan angka';
    }
    if (bloodSugar < 40 || bloodSugar > 600) {
      return 'Kadar gula darah harus antara 40 dan 600 mg/dL';
    }
    return null;
  }
}
