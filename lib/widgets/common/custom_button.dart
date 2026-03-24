import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flex_yemen/theme/app_theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double height;
  final double borderRadius;
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsets padding;

  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height = 54,
    this.borderRadius = 12,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? AppColors.goldPrimary;
    final txtColor = textColor ?? Colors.white;

    Widget buttonChild;
    
    if (isLoading) {
      buttonChild = SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            isOutlined ? bgColor : Colors.white,
          ),
          strokeWidth: 2.5,
        ),
      );
    } else {
      buttonChild = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, color: isOutlined ? bgColor : txtColor, size: 20),
            SizedBox(width: 10),
          ],
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Changa',
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: isOutlined ? bgColor : txtColor,
            ),
          ),
        ],
      );
    }

    final button = SizedBox(
      width: width,
      height: height,
      child: isOutlined
          ? OutlinedButton(
              onPressed: isLoading ? null : onPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: bgColor, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                padding: padding,
              ),
              child: buttonChild,
            )
          : ElevatedButton(
              onPressed: isLoading ? null : onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: bgColor,
                foregroundColor: txtColor,
                elevation: 2,
                shadowColor: bgColor.withOpacity(0.4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                padding: padding,
              ),
              child: buttonChild,
            ),
    );

    return button
        .animate(target: onPressed != null && !isLoading ? 1 : 0)
        .scale(
          begin: Offset(0.98, 0.98),
          end: Offset(1, 1),
          duration: 100.ms,
        );
  }
}

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final double size;
  final double iconSize;

  const CustomIconButton({
    Key? key,
    required this.icon,
    this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.size = 48,
    this.iconSize = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.goldPrimary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(size / 4),
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: iconColor ?? AppColors.goldPrimary,
          size: iconSize,
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class CustomFloatingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String? label;
  final Color? backgroundColor;

  const CustomFloatingButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.label,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      backgroundColor: backgroundColor ?? AppColors.goldPrimary,
      icon: Icon(icon, color: Colors.white),
      label: label != null
          ? Text(
              label!,
              style: TextStyle(
                fontFamily: 'Changa',
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            )
          : SizedBox.shrink(),
    );
  }
}
