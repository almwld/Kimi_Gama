import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Formatters {
  // منسق رقم الهاتف اليمني
  static TextInputFormatter get phoneFormatter {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      String digits = newValue.text.replaceAll(RegExp(r'[^\d+]'), '');
      
      if (digits.startsWith('+967')) {
        digits = digits.substring(4);
        if (digits.length > 9) digits = digits.substring(0, 9);
        String formatted = '+967';
        if (digits.isNotEmpty) formatted += ' $digits';
        return TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      } else if (digits.startsWith('00967')) {
        digits = digits.substring(5);
        if (digits.length > 9) digits = digits.substring(0, 9);
        String formatted = '00967';
        if (digits.isNotEmpty) formatted += ' $digits';
        return TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      } else if (digits.startsWith('0')) {
        digits = digits.substring(1);
        if (digits.length > 9) digits = digits.substring(0, 9);
        String formatted = '0';
        if (digits.isNotEmpty) formatted += digits;
        return TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      } else {
        if (digits.length > 9) digits = digits.substring(0, 9);
        return TextEditingValue(
          text: digits,
          selection: TextSelection.collapsed(offset: digits.length),
        );
      }
    });
  }
  
  // منسق السعر
  static TextInputFormatter get priceFormatter {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      if (newValue.text.isEmpty) return newValue;
      
      String digits = newValue.text.replaceAll(RegExp(r'[^\d.]'), '');
      
      // التأكد من وجود نقطة عشرية واحدة فقط
      if (digits.split('.').length > 2) {
        digits = digits.substring(0, digits.lastIndexOf('.'));
      }
      
      // تقييد المنازل العشرية إلى رقمين
      if (digits.contains('.')) {
        final parts = digits.split('.');
        if (parts[1].length > 2) {
          digits = '${parts[0]}.${parts[1].substring(0, 2)}';
        }
      }
      
      // تنسيق الأرقام بفواصل
      final number = double.tryParse(digits);
      if (number != null) {
        final formatted = NumberFormat('#,##0.##', 'en').format(number);
        return TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      }
      
      return newValue;
    });
  }
  
  // منسق الأرقام الصحيحة
  static TextInputFormatter get numberFormatter {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      if (newValue.text.isEmpty) return newValue;
      
      String digits = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
      
      if (digits.isEmpty) return TextEditingValue.empty;
      
      final number = int.tryParse(digits);
      if (number != null) {
        final formatted = NumberFormat('#,##0', 'en').format(number);
        return TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      }
      
      return newValue;
    });
  }
  
  // منسق رقم البطاقة
  static TextInputFormatter get cardNumberFormatter {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      String digits = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
      
      if (digits.length > 16) digits = digits.substring(0, 16);
      
      String formatted = '';
      for (int i = 0; i < digits.length; i++) {
        if (i > 0 && i % 4 == 0) formatted += ' ';
        formatted += digits[i];
      }
      
      return TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    });
  }
  
  // منسق تاريخ انتهاء البطاقة
  static TextInputFormatter get cardExpiryFormatter {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      String digits = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
      
      if (digits.length > 4) digits = digits.substring(0, 4);
      
      String formatted = '';
      for (int i = 0; i < digits.length; i++) {
        if (i == 2) formatted += '/';
        formatted += digits[i];
      }
      
      return TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    });
  }
  
  // منسق CVV
  static TextInputFormatter get cvvFormatter {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      String digits = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
      
      if (digits.length > 4) digits = digits.substring(0, 4);
      
      return TextEditingValue(
        text: digits,
        selection: TextSelection.collapsed(offset: digits.length),
      );
    });
  }
  
  // منسق OTP
  static TextInputFormatter otpFormatter(int length) {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      String digits = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
      
      if (digits.length > length) digits = digits.substring(0, length);
      
      return TextEditingValue(
        text: digits,
        selection: TextSelection.collapsed(offset: digits.length),
      );
    });
  }
  
  // منسق IBAN
  static TextInputFormatter get ibanFormatter {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      String text = newValue.text.toUpperCase().replaceAll(' ', '');
      
      if (text.length > 34) text = text.substring(0, 34);
      
      String formatted = '';
      for (int i = 0; i < text.length; i++) {
        if (i > 0 && i % 4 == 0) formatted += ' ';
        formatted += text[i];
      }
      
      return TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    });
  }
  
  // منسق الاسم (حروف فقط)
  static TextInputFormatter get nameFormatter {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      String text = newValue.text.replaceAll(RegExp(r'[^\u0600-\u06FFa-zA-Z\s]'), '');
      
      // إزالة المسافات المتعددة
      text = text.replaceAll(RegExp(r'\s+'), ' ');
      
      return TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    });
  }
  
  // منسق النص العربي
  static TextInputFormatter get arabicTextFormatter {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      String text = newValue.text.replaceAll(RegExp(r'[^\u0600-\u06FF\s\d]'), '');
      
      return TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    });
  }
  
  // منسق حدود الطول
  static TextInputFormatter lengthFormatter(int maxLength) {
    return LengthLimitingTextInputFormatter(maxLength);
  }
  
  // منسق حدود القيمة الرقمية
  static TextInputFormatter numberRangeFormatter({int min = 0, int max = 999999}) {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      if (newValue.text.isEmpty) return newValue;
      
      String digits = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
      
      if (digits.isEmpty) return TextEditingValue.empty;
      
      int? number = int.tryParse(digits);
      if (number == null) return oldValue;
      
      if (number < min) number = min;
      if (number > max) number = max;
      
      final formatted = NumberFormat('#,##0', 'en').format(number);
      
      return TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    });
  }
  
  // منسق النسبة المئوية
  static TextInputFormatter get percentageFormatter {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      if (newValue.text.isEmpty) return newValue;
      
      String text = newValue.text.replaceAll(RegExp(r'[^\d.]'), '');
      
      // التأكد من وجود نقطة عشرية واحدة فقط
      if (text.split('.').length > 2) {
        text = text.substring(0, text.lastIndexOf('.'));
      }
      
      double? value = double.tryParse(text);
      if (value == null) return oldValue;
      
      if (value > 100) value = 100;
      
      return TextEditingValue(
        text: value.toString(),
        selection: TextSelection.collapsed(offset: value.toString().length),
      );
    });
  }
  
  // منسق رقم الحساب البنكي
  static TextInputFormatter get bankAccountFormatter {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      String digits = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
      
      if (digits.length > 20) digits = digits.substring(0, 20);
      
      return TextEditingValue(
        text: digits,
        selection: TextSelection.collapsed(offset: digits.length),
      );
    });
  }
  
  // منسق رقم الهوية
  static TextInputFormatter get nationalIdFormatter {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      String digits = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
      
      if (digits.length > 9) digits = digits.substring(0, 9);
      
      return TextEditingValue(
        text: digits,
        selection: TextSelection.collapsed(offset: digits.length),
      );
    });
  }
  
  // منسق كود الدولة
  static TextInputFormatter get countryCodeFormatter {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      String text = newValue.text.toUpperCase();
      
      if (text.length > 2) text = text.substring(0, 2);
      
      return TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    });
  }
  
  // منسق رمز التحقق
  static TextInputFormatter verificationCodeFormatter(int length) {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      String text = newValue.text.toUpperCase().replaceAll(RegExp(r'[^A-Z0-9]'), '');
      
      if (text.length > length) text = text.substring(0, length);
      
      return TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    });
  }
  
  // منسق العنوان
  static TextInputFormatter get addressFormatter {
    return FilteringTextInputFormatter.allow(
      RegExp(r'[\u0600-\u06FFa-zA-Z0-9\s,\-\/]'),
    );
  }
  
  // منسق البريد الإلكتروني
  static TextInputFormatter get emailFormatter {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      String text = newValue.text.toLowerCase().trim();
      
      // إزالة المسافات
      text = text.replaceAll(' ', '');
      
      return TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    });
  }
  
  // منسق URL
  static TextInputFormatter get urlFormatter {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      String text = newValue.text.trim();
      
      // إضافة https:// تلقائياً إذا لم يكن موجوداً
      if (text.isNotEmpty && !text.startsWith('http')) {
        text = 'https://$text';
      }
      
      return TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    });
  }
}
