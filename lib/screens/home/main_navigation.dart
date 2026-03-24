import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flex_yemen/theme/app_theme.dart';
import 'package:flex_yemen/providers/order_provider.dart';
import 'package:flex_yemen/providers/notification_provider.dart';
import 'package:flex_yemen/screens/home/home_screen.dart';
import 'package:flex_yemen/screens/product/products_screen.dart';
import 'package:flex_yemen/screens/home/map_screen.dart';
import 'package:flex_yemen/screens/product/add_product_screen.dart';
import 'package:flex_yemen/screens/chat/chat_screen.dart';
import 'package:flex_yemen/screens/wallet/wallet_screen.dart';
import 'package:flex_yemen/screens/profile/profile_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    ProductsScreen(),
    MapScreen(),
    SizedBox.shrink(), // مكان فارغ للزر العائم
    ChatScreen(),
    WalletScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    if (index == 3) {
      // الزر العائم
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => AddProductScreen()),
      );
      return;
    }
    
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final orderProvider = Provider.of<OrderProvider>(context);
    final notificationProvider = Provider.of<NotificationProvider>(context);

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: BottomNavigationBar(
            currentIndex: _currentIndex == 3 ? 0 : _currentIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: AppColors.goldPrimary,
            unselectedItemColor: isDark ? Colors.white54 : Colors.black54,
            selectedLabelStyle: TextStyle(
              fontFamily: 'Changa',
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: TextStyle(
              fontFamily: 'Changa',
              fontSize: 11,
            ),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'الرئيسية',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.store_outlined),
                activeIcon: Icon(Icons.store),
                label: 'المتجر',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map_outlined),
                activeIcon: Icon(Icons.map),
                label: 'الخريطة',
              ),
              BottomNavigationBarItem(
                icon: SizedBox.shrink(),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Stack(
                  children: [
                    Icon(Icons.chat_bubble_outline),
                    // يمكن إضافة شارة للرسائل غير المقروءة
                  ],
                ),
                activeIcon: Icon(Icons.chat_bubble),
                label: 'الدردشة',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet_outlined),
                activeIcon: Icon(Icons.account_balance_wallet),
                label: 'المحفظة',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'حسابي',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.goldPrimary,
              AppColors.goldLight,
            ],
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.goldPrimary.withOpacity(0.4),
              blurRadius: 15,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () => _onItemTapped(3),
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
