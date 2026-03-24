import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flex_yemen/theme/app_theme.dart';
import 'package:flex_yemen/widgets/common/custom_button.dart';

class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final double iconSize;

  const EmptyState({
    Key? key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.buttonText,
    this.onButtonPressed,
    this.iconSize = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: iconSize,
              color: AppColors.goldPrimary.withOpacity(0.5),
            )
            .animate()
            .scale(duration: 500.ms, curve: Curves.easeOutBack),
            
            SizedBox(height: 24),
            
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            )
            .animate()
            .fadeIn(delay: 200.ms)
            .slideY(begin: 0.3, end: 0),
            
            if (subtitle != null) ...[
              SizedBox(height: 12),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 14,
                  color: isDark ? Colors.white60 : Colors.black54,
                ),
              )
              .animate()
              .fadeIn(delay: 300.ms),
            ],
            
            if (buttonText != null && onButtonPressed != null) ...[
              SizedBox(height: 32),
              CustomButton(
                text: buttonText!,
                onPressed: onButtonPressed!,
                isOutlined: true,
              )
              .animate()
              .fadeIn(delay: 400.ms)
              .scale(begin: Offset(0.9, 0.9), end: Offset(1, 1)),
            ],
          ],
        ),
      ),
    );
  }
}

class EmptyFavorites extends StatelessWidget {
  final VoidCallback? onBrowse;

  const EmptyFavorites({Key? key, this.onBrowse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: Icons.favorite_border,
      title: 'لا توجد مفضلات',
      subtitle: 'أضف منتجات إلى مفضلاتك لتجدها هنا بسهولة',
      buttonText: 'تصفح المنتجات',
      onButtonPressed: onBrowse,
    );
  }
}

class EmptyCart extends StatelessWidget {
  final VoidCallback? onBrowse;

  const EmptyCart({Key? key, this.onBrowse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: Icons.shopping_cart_outlined,
      title: 'سلة التسوق فارغة',
      subtitle: 'أضف منتجات إلى سلة التسوق للمتابعة',
      buttonText: 'تصفح المنتجات',
      onButtonPressed: onBrowse,
    );
  }
}

class EmptyOrders extends StatelessWidget {
  final VoidCallback? onBrowse;

  const EmptyOrders({Key? key, this.onBrowse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: Icons.receipt_long_outlined,
      title: 'لا توجد طلبات',
      subtitle: 'لم تقم بأي طلبات بعد، ابدأ التسوق الآن',
      buttonText: 'تصفح المنتجات',
      onButtonPressed: onBrowse,
    );
  }
}

class EmptyNotifications extends StatelessWidget {
  const EmptyNotifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: Icons.notifications_none_outlined,
      title: 'لا توجد إشعارات',
      subtitle: 'سنخبرك عندما يكون هناك جديد',
    );
  }
}

class EmptySearch extends StatelessWidget {
  final VoidCallback? onClear;

  const EmptySearch({Key? key, this.onClear}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: Icons.search_off_outlined,
      title: 'لا توجد نتائج',
      subtitle: 'جرب بحثاً مختلفاً أو تحقق من الإملاء',
      buttonText: 'مسح البحث',
      onButtonPressed: onClear,
    );
  }
}

class EmptyChats extends StatelessWidget {
  final VoidCallback? onStartChat;

  const EmptyChats({Key? key, this.onStartChat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: Icons.chat_bubble_outline,
      title: 'لا توجد محادثات',
      subtitle: 'ابدأ محادثة مع البائعين للتواصل',
      buttonText: 'بدء محادثة',
      onButtonPressed: onStartChat,
    );
  }
}

class ErrorState extends StatelessWidget {
  final String? message;
  final VoidCallback? onRetry;

  const ErrorState({
    Key? key,
    this.message,
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 80,
              color: AppColors.error.withOpacity(0.7),
            ),
            SizedBox(height: 24),
            Text(
              'حدث خطأ',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            SizedBox(height: 12),
            Text(
              message ?? 'حدث خطأ غير متوقع، يرجى المحاولة مرة أخرى',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 14,
                color: isDark ? Colors.white60 : Colors.black54,
              ),
            ),
            if (onRetry != null) ...[
              SizedBox(height: 32),
              CustomButton(
                text: 'إعادة المحاولة',
                onPressed: onRetry!,
                icon: Icons.refresh,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class NoInternetState extends StatelessWidget {
  final VoidCallback? onRetry;

  const NoInternetState({Key? key, this.onRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: Icons.wifi_off_outlined,
      title: 'لا يوجد اتصال',
      subtitle: 'تحقق من اتصالك بالإنترنت وحاول مرة أخرى',
      buttonText: 'إعادة المحاولة',
      onButtonPressed: onRetry,
    );
  }
}
