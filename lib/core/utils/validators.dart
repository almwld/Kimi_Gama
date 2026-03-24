import 'package:flex_yemen/core/utils/helpers.dart';

class Validators {
  // التحقق من الحقل المطلوب
  static String? required(String? value, {String fieldName = 'هذا الحقل'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName مطلوب';
    }
    return null;
  }
  
  // التحقق من البريد الإلكتروني
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'البريد الإلكتروني مطلوب';
    }
    if (!Helpers.isValidEmail(value)) {
      return 'البريد الإلكتروني غير صالح';
    }
    return null;
  }
  
  // التحقق من رقم الهاتف
  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'رقم الهاتف مطلوب';
    }
    if (!Helpers.isValidYemeniPhone(value)) {
      return 'رقم الهاتف اليمني غير صالح';
    }
    return null;
  }
  
  // التحقق من كلمة المرور
  static String? password(String? value, {int minLength = 8}) {
    if (value == null || value.isEmpty) {
      return 'كلمة المرور مطلوبة';
    }
    if (value.length < minLength) {
      return 'كلمة المرور يجب أن تكون $minLength أحرف على الأقل';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'كلمة المرور يجب أن تحتوي على حرف كبير';
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'كلمة المرور يجب أن تحتوي على حرف صغير';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'كلمة المرور يجب أن تحتوي على رقم';
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'كلمة المرور يجب أن تحتوي على رمز خاص';
    }
    return null;
  }
  
  // التحقق من تأكيد كلمة المرور
  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'تأكيد كلمة المرور مطلوب';
    }
    if (value != password) {
      return 'كلمتا المرور غير متطابقتين';
    }
    return null;
  }
  
  // التحقق من الاسم
  static String? name(String? value, {String fieldName = 'الاسم', int minLength = 2, int maxLength = 50}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName مطلوب';
    }
    if (value.trim().length < minLength) {
      return '$fieldName يجب أن يكون $minLength أحرف على الأقل';
    }
    if (value.trim().length > maxLength) {
      return '$fieldName يجب أن لا يتجاوز $maxLength حرف';
    }
    return null;
  }
  
  // التحقق من العنوان
  static String? address(String? value, {int minLength = 5, int maxLength = 200}) {
    if (value == null || value.trim().isEmpty) {
      return 'العنوان مطلوب';
    }
    if (value.trim().length < minLength) {
      return 'العنوان يجب أن يكون $minLength أحرف على الأقل';
    }
    if (value.trim().length > maxLength) {
      return 'العنوان يجب أن لا يتجاوز $maxLength حرف';
    }
    return null;
  }
  
  // التحقق من الوصف
  static String? description(String? value, {int minLength = 10, int maxLength = 2000}) {
    if (value == null || value.trim().isEmpty) {
      return 'الوصف مطلوب';
    }
    if (value.trim().length < minLength) {
      return 'الوصف يجب أن يكون $minLength أحرف على الأقل';
    }
    if (value.trim().length > maxLength) {
      return 'الوصف يجب أن لا يتجاوز $maxLength حرف';
    }
    return null;
  }
  
  // التحقق من السعر
  static String? price(String? value, {double min = 0, double max = 1000000000}) {
    if (value == null || value.trim().isEmpty) {
      return 'السعر مطلوب';
    }
    final price = double.tryParse(value.replaceAll(',', ''));
    if (price == null) {
      return 'السعر غير صالح';
    }
    if (price < min) {
      return 'السعر يجب أن يكون $min أو أكثر';
    }
    if (price > max) {
      return 'السعر يجب أن يكون $max أو أقل';
    }
    return null;
  }
  
  // التحقق من الكمية
  static String? quantity(String? value, {int min = 1, int max = 10000}) {
    if (value == null || value.trim().isEmpty) {
      return 'الكمية مطلوبة';
    }
    final quantity = int.tryParse(value);
    if (quantity == null) {
      return 'الكمية غير صالحة';
    }
    if (quantity < min) {
      return 'الكمية يجب أن تكون $min أو أكثر';
    }
    if (quantity > max) {
      return 'الكمية يجب أن تكون $max أو أقل';
    }
    return null;
  }
  
  // التحقق من الرمز البريدي
  static String? postalCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // اختياري
    }
    if (!RegExp(r'^\d{5}$').hasMatch(value)) {
      return 'الرمز البريدي يجب أن يكون 5 أرقام';
    }
    return null;
  }
  
  // التحقق من رقم البطاقة
  static String? cardNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'رقم البطاقة مطلوب';
    }
    final cleaned = value.replaceAll(' ', '').replaceAll('-', '');
    if (!RegExp(r'^\d{16}$').hasMatch(cleaned)) {
      return 'رقم البطاقة يجب أن يكون 16 رقماً';
    }
    return null;
  }
  
  // التحقق من تاريخ انتهاء البطاقة
  static String? cardExpiry(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'تاريخ الانتهاء مطلوب';
    }
    if (!RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$').hasMatch(value)) {
      return 'التاريخ يجب أن يكون بالصيغة MM/YY';
    }
    
    final parts = value.split('/');
    final month = int.parse(parts[0]);
    final year = int.parse('20${parts[1]}');
    final expiryDate = DateTime(year, month + 1, 0);
    
    if (expiryDate.isBefore(DateTime.now())) {
      return 'البطاقة منتهية الصلاحية';
    }
    
    return null;
  }
  
  // التحقق من رمز CVV
  static String? cardCvv(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'رمز CVV مطلوب';
    }
    if (!RegExp(r'^\d{3,4}$').hasMatch(value)) {
      return 'CVV يجب أن يكون 3 أو 4 أرقام';
    }
    return null;
  }
  
  // التحقق من IBAN
  static String? iban(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'رقم IBAN مطلوب';
    }
    final cleaned = value.replaceAll(' ', '');
    if (!RegExp(r'^[A-Z]{2}\d{2}[A-Z0-9]{1,30}$').hasMatch(cleaned)) {
      return 'رقم IBAN غير صالح';
    }
    return null;
  }
  
  // التحقق من URL
  static String? url(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // اختياري
    }
    if (!Uri.tryParse(value)!.isAbsolute) {
      return 'الرابط غير صالح';
    }
    return null;
  }
  
  // التحقق من النص المخصص
  static String? custom(
    String? value, {
    required String fieldName,
    int? minLength,
    int? maxLength,
    RegExp? pattern,
    String? patternMessage,
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName مطلوب';
    }
    
    if (minLength != null && value.trim().length < minLength) {
      return '$fieldName يجب أن يكون $minLength أحرف على الأقل';
    }
    
    if (maxLength != null && value.trim().length > maxLength) {
      return '$fieldName يجب أن لا يتجاوز $maxLength حرف';
    }
    
    if (pattern != null && !pattern.hasMatch(value)) {
      return patternMessage ?? '$fieldName غير صالح';
    }
    
    return null;
  }
  
  // التحقق المركب (مجموعة من المحققات)
  static String? compose(String? value, List<String? Function(String?)> validators) {
    for (final validator in validators) {
      final result = validator(value);
      if (result != null) return result;
    }
    return null;
  }
  
  // التحقق من OTP
  static String? otp(String? value, {int length = 6}) {
    if (value == null || value.trim().isEmpty) {
      return 'رمز التحقق مطلوب';
    }
    if (!RegExp(r'^\d{$length}$').hasMatch(value)) {
      return 'رمز التحقق يجب أن يكون $length أرقام';
    }
    return null;
  }
  
  // التحقق من رقم الحساب البنكي
  static String? bankAccountNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'رقم الحساب مطلوب';
    }
    final cleaned = value.replaceAll(' ', '');
    if (!RegExp(r'^\d{10,20}$').hasMatch(cleaned)) {
      return 'رقم الحساب غير صالح';
    }
    return null;
  }
  
  // التحقق من اسم البنك
  static String? bankName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'اسم البنك مطلوب';
    }
    if (value.trim().length < 2) {
      return 'اسم البنك غير صالح';
    }
    return null;
  }
  
  // التحقق من اسم صاحب الحساب
  static String? accountHolderName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'اسم صاحب الحساب مطلوب';
    }
    if (value.trim().length < 3) {
      return 'اسم صاحب الحساب غير صالح';
    }
    return null;
  }
  
  // التحقق من المبلغ
  static String? amount(String? value, {double min = 1, double max = 1000000000}) {
    if (value == null || value.trim().isEmpty) {
      return 'المبلغ مطلوب';
    }
    final amount = double.tryParse(value.replaceAll(',', ''));
    if (amount == null) {
      return 'المبلغ غير صالح';
    }
    if (amount < min) {
      return 'المبلغ يجب أن يكون $min أو أكثر';
    }
    if (amount > max) {
      return 'المبلغ يجب أن يكون $max أو أقل';
    }
    return null;
  }
  
  // التحقق من رقم الهوية
  static String? nationalId(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'رقم الهوية مطلوب';
    }
    if (!RegExp(r'^\d{9}$').hasMatch(value)) {
      return 'رقم الهوية يجب أن يكون 9 أرقام';
    }
    return null;
  }
  
  // التحقق من العمر
  static String? age(String? value, {int minAge = 18, int maxAge = 120}) {
    if (value == null || value.trim().isEmpty) {
      return 'العمر مطلوب';
    }
    final age = int.tryParse(value);
    if (age == null) {
      return 'العمر غير صالح';
    }
    if (age < minAge) {
      return 'يجب أن يكون عمرك $minAge سنة على الأقل';
    }
    if (age > maxAge) {
      return 'العمر غير صالح';
    }
    return null;
  }
}
