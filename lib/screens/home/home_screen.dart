import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flex_yemen/theme/app_theme.dart';
import 'package:flex_yemen/core/constants/app_constants.dart';
import 'package:flex_yemen/core/utils/helpers.dart';
import 'package:flex_yemen/models/product_model.dart';
import 'package:flex_yemen/models/ad_model.dart';
import 'package:flex_yemen/providers/product_provider.dart';
import 'package:flex_yemen/providers/order_provider.dart';
import 'package:flex_yemen/providers/notification_provider.dart';
import 'package:flex_yemen/widgets/common/custom_app_bar.dart';
import 'package:flex_yemen/widgets/common/loading_widget.dart';
import 'package:flex_yemen/widgets/common/empty_state.dart';
import 'package:flex_yemen/widgets/cards/product_card.dart';
import 'package:flex_yemen/screens/notifications/notifications_screen.dart';
import 'package:flex_yemen/screens/order/cart_screen.dart';
import 'package:flex_yemen/screens/search/search_screen.dart';
import 'package:flex_yemen/screens/product/product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentBannerIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadData() {
    Future.microtask(() {
      Provider.of<ProductProvider>(context, listen: false).getProducts(refresh: true);
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      Provider.of<ProductProvider>(context, listen: false).getProducts();
    }
  }

  Future<void> _onRefresh() async {
    await Provider.of<ProductProvider>(context, listen: false).getProducts(refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final productProvider = Provider.of<ProductProvider>(context);
    final orderProvider = Provider.of<OrderProvider>(context);
    final notificationProvider = Provider.of<NotificationProvider>(context);

    return Scaffold(
      appBar: HomeAppBar(
        notificationCount: notificationProvider.unreadCount,
        cartCount: orderProvider.cartItemCount,
        onNotificationTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => NotificationsScreen()),
          );
        },
        onCartTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CartScreen()),
          );
        },
        onSearchTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => SearchScreen()),
          );
        },
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        color: AppColors.goldPrimary,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // السلايدر الإعلاني
            SliverToBoxAdapter(
              child: _buildBannerSlider(),
            ),

            // قسم "مزيد من ما تريد"
            SliverToBoxAdapter(
              child: _buildQuickAccessSection(),
            ),

            // قسم المزادات
            SliverToBoxAdapter(
              child: _buildAuctionsSection(),
            ),

            // قسم العقارات
            SliverToBoxAdapter(
              child: _buildRealEstateSection(),
            ),

            // قسم الإلكترونيات
            SliverToBoxAdapter(
              child: _buildElectronicsSection(),
            ),

            // عنوان منتجات مقترحة
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 24,
                      decoration: BoxDecoration(
                        color: AppColors.goldPrimary,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'منتجات مقترحة لك',
                      style: TextStyle(
                        fontFamily: 'Changa',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        // عرض الكل
                      },
                      child: Text(
                        'عرض الكل',
                        style: TextStyle(
                          fontFamily: 'Changa',
                          color: AppColors.goldPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // شبكة المنتجات (130+ منتج)
            productProvider.isLoading && productProvider.products.isEmpty
                ? SliverToBoxAdapter(
                    child: GridShimmer(),
                  )
                : productProvider.products.isEmpty
                    ? SliverToBoxAdapter(
                        child: EmptySearch(),
                      )
                    : SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        sliver: SliverGrid(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final product = productProvider.products[index];
                              return ProductCard(
                                product: product.toJson(),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ProductDetailScreen(
                                        productId: product.id,
                                      ),
                                    ),
                                  );
                                },
                              )
                              .animate()
                              .fadeIn(delay: (index * 50).ms)
                              .slideY(begin: 0.2, end: 0);
                            },
                            childCount: productProvider.products.length,
                          ),
                        ),
                      ),

            // مؤشر التحميل
            if (productProvider.isLoading && productProvider.products.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: LoadingWidget(size: 30),
                  ),
                ),
              ),

            SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerSlider() {
    final ads = AdModel.dummyAds;

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 180,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            onPageChanged: (index, reason) {
              setState(() {
                _currentBannerIndex = index;
              });
            },
          ),
          items: ads.map((ad) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: NetworkImage(ad.images.first),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ad.title,
                          style: TextStyle(
                            fontFamily: 'Changa',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          ad.description,
                          style: TextStyle(
                            fontFamily: 'Changa',
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: ads.asMap().entries.map((entry) {
            return Container(
              width: 8,
              height: 8,
              margin: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentBannerIndex == entry.key
                    ? AppColors.goldPrimary
                    : Colors.grey,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildQuickAccessSection() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final items = [
      {'icon': Icons.location_on, 'label': 'معلمات', 'color': Colors.red},
      {'icon': Icons.home_work, 'label': 'عقارات', 'color': Colors.green},
      {'icon': Icons.flight, 'label': 'سفر', 'color': Colors.blue},
      {'icon': Icons.local_shipping, 'label': 'شحن', 'color': Colors.orange},
      {'icon': Icons.sports_esports, 'label': 'ألعاب', 'color': Colors.purple},
      {'icon': Icons.restaurant, 'label': 'مطاعم', 'color': Colors.teal},
      {'icon': Icons.directions_car, 'label': 'سيارات', 'color': Colors.indigo},
      {'icon': Icons.more_horiz, 'label': 'المزيد', 'color': Colors.grey},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
          child: Text(
            'مزيد من ما تريد',
            style: TextStyle(
              fontFamily: 'Changa',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Padding(
                padding: EdgeInsets.only(right: 12),
                child: Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: (item['color'] as Color).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        item['icon'] as IconData,
                        color: item['color'] as Color,
                        size: 28,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      item['label'] as String,
                      style: TextStyle(
                        fontFamily: 'Changa',
                        fontSize: 12,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                    ),
                  ],
                ),
              )
              .animate()
              .fadeIn(delay: (index * 50).ms)
              .scale(begin: Offset(0.8, 0.8), end: Offset(1, 1));
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAuctionsSection() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final auctionProducts = ProductModel.dummyProducts
        .where((p) => p.isAuction)
        .take(4)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
          child: Row(
            children: [
              Icon(
                Icons.gavel,
                color: AppColors.goldPrimary,
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                'مزاد الجنابي الأسبوعي',
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.timer,
                      color: AppColors.error,
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '02:45:30',
                      style: TextStyle(
                        fontFamily: 'Changa',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.error,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: auctionProducts.length,
            itemBuilder: (context, index) {
              final product = auctionProducts[index];
              return _buildAuctionCard(product);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAuctionCard(ProductModel product) {
    return Container(
      width: 160,
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: Stack(
              children: [
                Image.network(
                  product.mainImage,
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'مزاد',
                      style: TextStyle(
                        fontFamily: 'Changa',
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: TextStyle(
                    fontFamily: 'Changa',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  Helpers.formatPrice(product.currentBid ?? product.price),
                  style: TextStyle(
                    fontFamily: 'Changa',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.goldPrimary,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.gavel,
                      size: 14,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '${product.bidsCount} مزايدة',
                      style: TextStyle(
                        fontFamily: 'Changa',
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRealEstateSection() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final categories = [
      {'icon': Icons.apartment, 'label': 'شقق', 'color': Colors.blue},
      {'icon': Icons.villa, 'label': 'فلل', 'color': Colors.green},
      {'icon': Icons.landscape, 'label': 'أراضي', 'color': Colors.brown},
      {'icon': Icons.storefront, 'label': 'محلات', 'color': Colors.orange},
      {'icon': Icons.business, 'label': 'مكاتب', 'color': Colors.purple},
      {'icon': Icons.warehouse, 'label': 'مستودعات', 'color': Colors.teal},
      {'icon': Icons.trending_up, 'label': 'استثمار', 'color': Colors.red},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
          child: Text(
            'العقارات والاستثمارات',
            style: TextStyle(
              fontFamily: 'Changa',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ),
        SizedBox(
          height: 90,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Container(
                width: 80,
                margin: EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: (category['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      category['icon'] as IconData,
                      color: category['color'] as Color,
                      size: 32,
                    ),
                    SizedBox(height: 8),
                    Text(
                      category['label'] as String,
                      style: TextStyle(
                        fontFamily: 'Changa',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildElectronicsSection() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final categories = [
      {'icon': Icons.smartphone, 'label': 'هواتف', 'color': Colors.blue},
      {'icon': Icons.laptop, 'label': 'لابتوب', 'color': Colors.grey},
      {'icon': Icons.router, 'label': 'ستارلينك', 'color': Colors.cyan},
      {'icon': Icons.camera_alt, 'label': 'كاميرات', 'color': Colors.purple},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
          child: Text(
            'عالم الإلكترونيات والتقنية',
            style: TextStyle(
              fontFamily: 'Changa',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Container(
                width: 90,
                margin: EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      (category['color'] as Color).withOpacity(0.2),
                      (category['color'] as Color).withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        category['icon'] as IconData,
                        color: category['color'] as Color,
                        size: 28,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      category['label'] as String,
                      style: TextStyle(
                        fontFamily: 'Changa',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
