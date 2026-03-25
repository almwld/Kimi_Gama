import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton;
  final List<Widget>? actions;
  final VoidCallback? onSearchTap;
  final VoidCallback? onNotificationTap;
  final int? notificationCount;
  final Color? backgroundColor;
  
  const CustomAppBar({
    super.key,
    this.title,
    this.showBackButton = false,
    this.actions,
    this.onSearchTap,
    this.onNotificationTap,
    this.notificationCount,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return AppBar(
      backgroundColor: backgroundColor ?? (isDark ? AppTheme.darkBackground : AppTheme.lightBackground),
      elevation: 0,
      centerTitle: true,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      title: title != null
          ? Text(
              title!,
              style: const TextStyle(
                fontFamily: 'Changa',
                fontWeight: FontWeight.bold,
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'FLEX',
                  style: TextStyle(
                    color: AppTheme.goldColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(width: 4),
                Text(
                  'YEMEN',
                  style: TextStyle(
                    color: AppTheme.goldLight,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
      actions: actions ?? [
        if (onSearchTap != null)
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: onSearchTap,
          ),
        if (onNotificationTap != null)
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: onNotificationTap,
              ),
              if (notificationCount != null && notificationCount! > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: AppTheme.goldColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      notificationCount.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
