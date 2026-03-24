import 'package:flutter/material.dart';
import 'package:flex_yemen/theme/app_theme.dart';
import 'package:badges/badges.dart' as badges;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBackButton;
  final bool centerTitle;
  final double elevation;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final PreferredSizeWidget? bottom;
  final VoidCallback? onBackPressed;
  final int notificationCount;
  final int cartCount;
  final bool showNotification;
  final bool showCart;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onCartTap;
  final VoidCallback? onSearchTap;
  final bool showSearch;

  const CustomAppBar({
    Key? key,
    this.title,
    this.actions,
    this.leading,
    this.showBackButton = true,
    this.centerTitle = true,
    this.elevation = 0,
    this.backgroundColor,
    this.foregroundColor,
    this.bottom,
    this.onBackPressed,
    this.notificationCount = 0,
    this.cartCount = 0,
    this.showNotification = true,
    this.showCart = true,
    this.onNotificationTap,
    this.onCartTap,
    this.onSearchTap,
    this.showSearch = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return AppBar(
      title: title != null 
          ? Text(
              title!,
              style: TextStyle(
                fontFamily: 'Changa',
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: foregroundColor ?? (isDark ? Colors.white : Colors.black87),
              ),
            )
          : null,
      centerTitle: centerTitle,
      elevation: elevation,
      backgroundColor: backgroundColor ?? (isDark ? AppColors.darkSurface : AppColors.lightSurface),
      foregroundColor: foregroundColor ?? (isDark ? Colors.white : Colors.black87),
      leading: leading ?? (showBackButton && Navigator.canPop(context)
          ? IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: onBackPressed ?? () => Navigator.pop(context),
            )
          : null),
      actions: actions ?? _buildDefaultActions(context),
      bottom: bottom,
    );
  }

  List<Widget> _buildDefaultActions(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark ? Colors.white : Colors.black87;
    
    return [
      if (showSearch)
        IconButton(
          icon: Icon(Icons.search, color: iconColor),
          onPressed: onSearchTap,
        ),
      if (showNotification)
        Padding(
          padding: EdgeInsets.only(right: 8),
          child: badges.Badge(
            showBadge: notificationCount > 0,
            badgeContent: Text(
              notificationCount > 99 ? '99+' : '$notificationCount',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            badgeStyle: badges.BadgeStyle(
              badgeColor: AppColors.goldPrimary,
            ),
            position: badges.BadgePosition.topEnd(top: 8, end: 5),
            child: IconButton(
              icon: Icon(Icons.notifications_outlined, color: iconColor),
              onPressed: onNotificationTap,
            ),
          ),
        ),
      if (showCart)
        Padding(
          padding: EdgeInsets.only(right: 8),
          child: badges.Badge(
            showBadge: cartCount > 0,
            badgeContent: Text(
              cartCount > 99 ? '99+' : '$cartCount',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            badgeStyle: badges.BadgeStyle(
              badgeColor: AppColors.goldPrimary,
            ),
            position: badges.BadgePosition.topEnd(top: 8, end: 5),
            child: IconButton(
              icon: Icon(Icons.shopping_cart_outlined, color: iconColor),
              onPressed: onCartTap,
            ),
          ),
        ),
      SizedBox(width: 8),
    ];
  }

  @override
  Size get preferredSize => Size.fromHeight(
    kToolbarHeight + (bottom?.preferredSize.height ?? 0),
  );
}

// AppBar مخصص للصفحة الرئيسية
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int notificationCount;
  final int cartCount;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onCartTap;
  final VoidCallback? onSearchTap;

  const HomeAppBar({
    Key? key,
    this.notificationCount = 0,
    this.cartCount = 0,
    this.onNotificationTap,
    this.onCartTap,
    this.onSearchTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.goldPrimary, AppColors.goldLight],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.shopping_bag,
              color: Colors.white,
              size: 20,
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'FLEX',
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              Text(
                'YEMEN',
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: AppColors.goldPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
      centerTitle: false,
      elevation: 0,
      backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
      actions: [
        IconButton(
          icon: Icon(
            Icons.search,
            color: isDark ? Colors.white : Colors.black87,
          ),
          onPressed: onSearchTap,
        ),
        badges.Badge(
          showBadge: notificationCount > 0,
          badgeContent: Text(
            notificationCount > 99 ? '99+' : '$notificationCount',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          badgeStyle: badges.BadgeStyle(
            badgeColor: AppColors.goldPrimary,
          ),
          position: badges.BadgePosition.topEnd(top: 8, end: 5),
          child: IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              color: isDark ? Colors.white : Colors.black87,
            ),
            onPressed: onNotificationTap,
          ),
        ),
        badges.Badge(
          showBadge: cartCount > 0,
          badgeContent: Text(
            cartCount > 99 ? '99+' : '$cartCount',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          badgeStyle: badges.BadgeStyle(
            badgeColor: AppColors.goldPrimary,
          ),
          position: badges.BadgePosition.topEnd(top: 8, end: 5),
          child: IconButton(
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: isDark ? Colors.white : Colors.black87,
            ),
            onPressed: onCartTap,
          ),
        ),
        SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
