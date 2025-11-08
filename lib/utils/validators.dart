class Validators {
  /// Email validator
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Email tidak valid';
    }
    
    return null;
  }
  
  /// Password validator
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    
    if (value.length < 6) {
      return 'Password minimal 6 karakter';
    }
    
    return null;
  }
  
  /// Required field validator
  static String? required(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? "Field"} tidak boleh kosong';
    }
    return null;
  }
  
  /// Amount validator (for money input)
  static String? amount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Jumlah tidak boleh kosong';
    }
    
    final amount = double.tryParse(value);
    if (amount == null) {
      return 'Jumlah harus berupa angka';
    }
    
    if (amount <= 0) {
      return 'Jumlah harus lebih dari 0';
    }
    
    return null;
  }
  
  /// Percentage validator
  static String? percentage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Persentase tidak boleh kosong';
    }
    
    final percentage = double.tryParse(value);
    if (percentage == null) {
      return 'Persentase harus berupa angka';
    }
    
    if (percentage < 0 || percentage > 100) {
      return 'Persentase harus antara 0-100';
    }
    
    return null;
  }
  
  /// Confirm password validator
  static String? confirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Konfirmasi password tidak boleh kosong';
    }
    
    if (value != password) {
      return 'Password tidak cocok';
    }
    
    return null;
  }
  
  /// API Key validator
  static String? apiKey(String? value) {
    if (value == null || value.isEmpty) {
      return 'API Key tidak boleh kosong';
    }
    
    if (value.length < 10) {
      return 'API Key tidak valid';
    }
    
    return null;
  }
  
  /// URL validator
  static String? url(String? value) {
    if (value == null || value.isEmpty) {
      return 'URL tidak boleh kosong';
    }
    
    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$'
    );
    
    if (!urlRegex.hasMatch(value)) {
      return 'URL tidak valid';
    }
    
    return null;
  }
}

