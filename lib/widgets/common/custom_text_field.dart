import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flex_yemen/theme/app_theme.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? errorText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final int? maxLines;
  final int? maxLength;
  final bool enabled;
  final bool readOnly;
  final FocusNode? focusNode;
  final TextCapitalization textCapitalization;
  final EdgeInsets contentPadding;

  const CustomTextField({
    Key? key,
    this.controller,
    this.label,
    this.hint,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.maxLines = 1,
    this.maxLength,
    this.enabled = true,
    this.readOnly = false,
    this.focusNode,
    this.textCapitalization = TextCapitalization.none,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: TextStyle(
              fontFamily: 'Changa',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : Colors.black.withOpacity(0.08)7,
            ),
          ),
          SizedBox(height: 8),
        ],
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
          validator: validator,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          maxLines: maxLines,
          maxLength: maxLength,
          enabled: enabled,
          readOnly: readOnly,
          focusNode: focusNode,
          textCapitalization: textCapitalization,
          style: TextStyle(
            fontFamily: 'Changa',
            fontSize: 15,
            color: isDark ? Colors.white : Colors.black.withOpacity(0.08)7,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontFamily: 'Changa',
              fontSize: 14,
              color: isDark ? Colors.white38 : Colors.black38,
            ),
            errorText: errorText,
            errorStyle: TextStyle(
              fontFamily: 'Changa',
              fontSize: 12,
            ),
            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    color: isDark ? Colors.white54 : Colors.black54,
                    size: 22,
                  )
                : null,
            suffixIcon: suffixIcon != null
                ? GestureDetector(
                    onTap: onSuffixTap,
                    child: Icon(
                      suffixIcon,
                      color: AppColors.goldPrimary,
                      size: 22,
                    ),
                  )
                : null,
            contentPadding: contentPadding,
            filled: true,
            fillColor: isDark
                ? AppColors.darkCard
                : AppColors.lightCard,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark ? Colors.white12 : Colors.black12,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.goldPrimary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.error,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.error,
                width: 2,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.08),
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final VoidCallback? onClear;

  const CustomSearchField({
    Key? key,
    this.controller,
    this.hint = 'بحث...',
    this.onChanged,
    this.onSubmitted,
    this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TextField(
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      textInputAction: TextInputAction.search,
      style: TextStyle(
        fontFamily: 'Changa',
        fontSize: 15,
        color: isDark ? Colors.white : Colors.black.withOpacity(0.08)7,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontFamily: 'Changa',
          fontSize: 14,
          color: isDark ? Colors.white38 : Colors.black38,
        ),
        prefixIcon: Icon(
          Icons.search,
          color: isDark ? Colors.white54 : Colors.black54,
          size: 22,
        ),
        suffixIcon: controller?.text.isNotEmpty == true
            ? GestureDetector(
                onTap: () {
                  controller?.clear();
                  onClear?.call();
                },
                child: Icon(
                  Icons.clear,
                  color: isDark ? Colors.white54 : Colors.black54,
                  size: 20,
                ),
              )
            : null,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        filled: true,
        fillColor: isDark
            ? AppColors.darkCard
            : AppColors.lightCard,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: isDark ? Colors.white12 : Colors.black12,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: AppColors.goldPrimary,
            width: 2,
          ),
        ),
      ),
    );
  }
}

class CustomDropdownField<T> extends StatelessWidget {
  final String? label;
  final String? hint;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final IconData? prefixIcon;

  const CustomDropdownField({
    Key? key,
    this.label,
    this.hint,
    this.value,
    required this.items,
    this.onChanged,
    this.validator,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: TextStyle(
              fontFamily: 'Changa',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : Colors.black.withOpacity(0.08)7,
            ),
          ),
          SizedBox(height: 8),
        ],
        DropdownButtonFormField<T>(
          value: value,
          items: items,
          onChanged: onChanged,
          validator: validator,
          hint: hint != null
              ? Text(
                  hint!,
                  style: TextStyle(
                    fontFamily: 'Changa',
                    fontSize: 14,
                    color: isDark ? Colors.white38 : Colors.black38,
                  ),
                )
              : null,
          icon: Icon(
            Icons.arrow_drop_down,
            color: AppColors.goldPrimary,
          ),
          decoration: InputDecoration(
            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    color: isDark ? Colors.white54 : Colors.black54,
                    size: 22,
                  )
                : null,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            filled: true,
            fillColor: isDark
                ? AppColors.darkCard
                : AppColors.lightCard,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark ? Colors.white12 : Colors.black12,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.goldPrimary,
                width: 2,
              ),
            ),
          ),
          style: TextStyle(
            fontFamily: 'Changa',
            fontSize: 15,
            color: isDark ? Colors.white : Colors.black.withOpacity(0.08)7,
          ),
          dropdownColor: isDark ? AppColors.darkCard : AppColors.lightCard,
        ),
      ],
    );
  }
}
