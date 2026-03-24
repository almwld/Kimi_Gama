import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 2)
class ProductModel extends HiveObject {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String title;
  
  @HiveField(2)
  final String description;
  
  @HiveField(3)
  final double price;
  
  @HiveField(4)
  final double? oldPrice;
  
  @HiveField(5)
  final List<String> images;
  
  @HiveField(6)
  final String categoryId;
  
  @HiveField(7)
  final String subcategoryId;
  
  @HiveField(8)
  final String sellerId;
  
  @HiveField(9)
  final String sellerName;
  
  @HiveField(10)
  final String? sellerAvatar;
  
  @HiveField(11)
  final String city;
  
  @HiveField(12)
  final String condition;
  
  @HiveField(13)
  final bool hasWarranty;
  
  @HiveField(14)
  final String? warrantyPeriod;
  
  @HiveField(15)
  final bool hasShipping;
  
  @HiveField(16)
  final double? shippingCost;
  
  @HiveField(17)
  final bool isNegotiable;
  
  @HiveField(18)
  final int views;
  
  @HiveField(19)
  final int favoritesCount;
  
  @HiveField(20)
  final double rating;
  
  @HiveField(21)
  final int ratingCount;
  
  @HiveField(22)
  final String status;
  
  @HiveField(23)
  final bool isFeatured;
  
  @HiveField(24)
  final bool isPromoted;
  
  @HiveField(25)
  final DateTime createdAt;
  
  @HiveField(26)
  final DateTime? updatedAt;
  
  @HiveField(27)
  final DateTime? expiryDate;
  
  @HiveField(28)
  final bool isAuction;
  
  @HiveField(29)
  final DateTime? auctionEndDate;
  
  @HiveField(30)
  final double? currentBid;
  
  @HiveField(31)
  final int? bidsCount;
  
  @HiveField(32)
  final Map<String, dynamic>? attributes;
  
  @HiveField(33)
  final double? latitude;
  
  @HiveField(34)
  final double? longitude;
  
  @HiveField(35)
  final bool isFavorite;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    this.oldPrice,
    required this.images,
    required this.categoryId,
    required this.subcategoryId,
    required this.sellerId,
    required this.sellerName,
    this.sellerAvatar,
    required this.city,
    required this.condition,
    this.hasWarranty = false,
    this.warrantyPeriod,
    this.hasShipping = false,
    this.shippingCost,
    this.isNegotiable = true,
    this.views = 0,
    this.favoritesCount = 0,
    this.rating = 0.0,
    this.ratingCount = 0,
    this.status = 'active',
    this.isFeatured = false,
    this.isPromoted = false,
    required this.createdAt,
    this.updatedAt,
    this.expiryDate,
    this.isAuction = false,
    this.auctionEndDate,
    this.currentBid,
    this.bidsCount,
    this.attributes,
    this.latitude,
    this.longitude,
    this.isFavorite = false,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      oldPrice: json['old_price']?.toDouble(),
      images: List<String>.from(json['images'] ?? []),
      categoryId: json['category_id'] ?? '',
      subcategoryId: json['subcategory_id'] ?? '',
      sellerId: json['seller_id'] ?? '',
      sellerName: json['seller_name'] ?? '',
      sellerAvatar: json['seller_avatar'],
      city: json['city'] ?? '',
      condition: json['condition'] ?? 'new',
      hasWarranty: json['has_warranty'] ?? false,
      warrantyPeriod: json['warranty_period'],
      hasShipping: json['has_shipping'] ?? false,
      shippingCost: json['shipping_cost']?.toDouble(),
      isNegotiable: json['is_negotiable'] ?? true,
      views: json['views'] ?? 0,
      favoritesCount: json['favorites_count'] ?? 0,
      rating: (json['rating'] ?? 0.0).toDouble(),
      ratingCount: json['rating_count'] ?? 0,
      status: json['status'] ?? 'active',
      isFeatured: json['is_featured'] ?? false,
      isPromoted: json['is_promoted'] ?? false,
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at']) 
          : null,
      expiryDate: json['expiry_date'] != null 
          ? DateTime.parse(json['expiry_date']) 
          : null,
      isAuction: json['is_auction'] ?? false,
      auctionEndDate: json['auction_end_date'] != null 
          ? DateTime.parse(json['auction_end_date']) 
          : null,
      currentBid: json['current_bid']?.toDouble(),
      bidsCount: json['bids_count'],
      attributes: json['attributes'] != null 
          ? Map<String, dynamic>.from(json['attributes']) 
          : null,
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      isFavorite: json['is_favorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'old_price': oldPrice,
      'images': images,
      'category_id': categoryId,
      'subcategory_id': subcategoryId,
      'seller_id': sellerId,
      'seller_name': sellerName,
      'seller_avatar': sellerAvatar,
      'city': city,
      'condition': condition,
      'has_warranty': hasWarranty,
      'warranty_period': warrantyPeriod,
      'has_shipping': hasShipping,
      'shipping_cost': shippingCost,
      'is_negotiable': isNegotiable,
      'views': views,
      'favorites_count': favoritesCount,
      'rating': rating,
      'rating_count': ratingCount,
      'status': status,
      'is_featured': isFeatured,
      'is_promoted': isPromoted,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'expiry_date': expiryDate?.toIso8601String(),
      'is_auction': isAuction,
      'auction_end_date': auctionEndDate?.toIso8601String(),
      'current_bid': currentBid,
      'bids_count': bidsCount,
      'attributes': attributes,
      'latitude': latitude,
      'longitude': longitude,
      'is_favorite': isFavorite,
    };
  }

  ProductModel copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    double? oldPrice,
    List<String>? images,
    String? categoryId,
    String? subcategoryId,
    String? sellerId,
    String? sellerName,
    String? sellerAvatar,
    String? city,
    String? condition,
    bool? hasWarranty,
    String? warrantyPeriod,
    bool? hasShipping,
    double? shippingCost,
    bool? isNegotiable,
    int? views,
    int? favoritesCount,
    double? rating,
    int? ratingCount,
    String? status,
    bool? isFeatured,
    bool? isPromoted,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? expiryDate,
    bool? isAuction,
    DateTime? auctionEndDate,
    double? currentBid,
    int? bidsCount,
    Map<String, dynamic>? attributes,
    double? latitude,
    double? longitude,
    bool? isFavorite,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      oldPrice: oldPrice ?? this.oldPrice,
      images: images ?? this.images,
      categoryId: categoryId ?? this.categoryId,
      subcategoryId: subcategoryId ?? this.subcategoryId,
      sellerId: sellerId ?? this.sellerId,
      sellerName: sellerName ?? this.sellerName,
      sellerAvatar: sellerAvatar ?? this.sellerAvatar,
      city: city ?? this.city,
      condition: condition ?? this.condition,
      hasWarranty: hasWarranty ?? this.hasWarranty,
      warrantyPeriod: warrantyPeriod ?? this.warrantyPeriod,
      hasShipping: hasShipping ?? this.hasShipping,
      shippingCost: shippingCost ?? this.shippingCost,
      isNegotiable: isNegotiable ?? this.isNegotiable,
      views: views ?? this.views,
      favoritesCount: favoritesCount ?? this.favoritesCount,
      rating: rating ?? this.rating,
      ratingCount: ratingCount ?? this.ratingCount,
      status: status ?? this.status,
      isFeatured: isFeatured ?? this.isFeatured,
      isPromoted: isPromoted ?? this.isPromoted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      expiryDate: expiryDate ?? this.expiryDate,
      isAuction: isAuction ?? this.isAuction,
      auctionEndDate: auctionEndDate ?? this.auctionEndDate,
      currentBid: currentBid ?? this.currentBid,
      bidsCount: bidsCount ?? this.bidsCount,
      attributes: attributes ?? this.attributes,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  // خصم
  double? get discountPercentage {
    if (oldPrice == null || oldPrice! <= 0) return null;
    return ((oldPrice! - price) / oldPrice! * 100).roundToDouble();
  }

  // صورة رئيسية
  String get mainImage => images.isNotEmpty ? images[0] : '';

  // بيانات وهمية - 130+ منتج
  static List<ProductModel> get dummyProducts {
    List<ProductModel> products = [];
    
    // إلكترونيات - هواتف
    products.addAll([
      _createProduct('p001', 'آيفون 15 برو ماكس 256GB', 'هاتف آيفون 15 برو ماكس جديد بالكامل مع ضمان سنتين', 450000, 520000, 
        ['https://picsum.photos/400/400?random=1', 'https://picsum.photos/400/400?random=2'], 'electronics', 'phones', 'user_001', 'أحمد محمد', 'sanaa', 125),
      _createProduct('p002', 'سامسونج جالكسي S24 الترا', 'أحدث هاتف من سامسونج مع قلم S Pen', 380000, 420000, 
        ['https://picsum.photos/400/400?random=3'], 'electronics', 'phones', 'user_002', 'فاطمة عبدالله', 'aden', 89),
      _createProduct('p003', 'شاومي 14 برو', 'هاتف شاومي الرائد بمواصفات عالية', 180000, 220000, 
        ['https://picsum.photos/400/400?random=4'], 'electronics', 'phones', 'user_003', 'خالد سعيد', 'taiz', 156),
      _createProduct('p004', 'آيفون 14 برو 128GB', 'آيفون 14 برو بحالة ممتازة', 320000, 380000, 
        ['https://picsum.photos/400/400?random=5'], 'electronics', 'phones', 'user_001', 'أحمد محمد', 'sanaa', 234),
      _createProduct('p005', 'سامسونج جالكسي Z Fold 5', 'هاتف قابل للطي من سامسونج', 550000, 650000, 
        ['https://picsum.photos/400/400?random=6'], 'electronics', 'phones', 'user_002', 'فاطمة عبدالله', 'aden', 67),
    ]);
    
    // إلكترونيات - لابتوبات
    products.addAll([
      _createProduct('p006', 'ماك بوك برو 16 M3', 'لابتوب آبل ماك بوك برو مع معالج M3', 980000, 1200000, 
        ['https://picsum.photos/400/400?random=7'], 'electronics', 'laptops', 'user_001', 'أحمد محمد', 'sanaa', 45),
      _createProduct('p007', 'ديل XPS 15', 'لابتوب ديل XPS 15 مع شاشة 4K', 420000, 480000, 
        ['https://picsum.photos/400/400?random=8'], 'electronics', 'laptops', 'user_003', 'خالد سعيد', 'taiz', 78),
      _createProduct('p008', 'HP Spectre x360', 'لابتوب HP قابل للتحويل', 380000, 450000, 
        ['https://picsum.photos/400/400?random=9'], 'electronics', 'laptops', 'user_002', 'فاطمة عبدالله', 'aden', 123),
      _createProduct('p009', 'لينوفو ثينك باد X1', 'لابتوب أعمال من لينوفو', 350000, 400000, 
        ['https://picsum.photos/400/400?random=10'], 'electronics', 'laptops', 'user_001', 'أحمد محمد', 'sanaa', 89),
      _createProduct('p010', 'آسوس ROG Strix', 'لابتوب ألعاب من آسوس', 520000, 600000, 
        ['https://picsum.photos/400/400?random=11'], 'electronics', 'laptops', 'user_003', 'خالد سعيد', 'taiz', 156),
    ]);
    
    // سيارات
    products.addAll([
      _createProduct('p011', 'تويوتا كامري 2023', 'تويوتا كامري فل كامل بحالة الوكالة', 8500000, 9200000, 
        ['https://picsum.photos/400/400?random=12'], 'vehicles', 'cars', 'user_001', 'أحمد محمد', 'sanaa', 234),
      _createProduct('p012', 'هيونداي توسان 2022', 'هيونداي توسان دبل بحالة ممتازة', 6500000, 7200000, 
        ['https://picsum.photos/400/400?random=13'], 'vehicles', 'cars', 'user_002', 'فاطمة عبدالله', 'aden', 189),
      _createProduct('p013', 'مرسيدس C200 2021', 'مرسيدس C200 بحالة نظيفة جداً', 12000000, 13500000, 
        ['https://picsum.photos/400/400?random=14'], 'vehicles', 'cars', 'user_003', 'خالد سعيد', 'taiz', 67),
      _createProduct('p014', 'كيا سبورتاج 2023', 'كيا سبورتاج جديدة بالكامل', 5800000, 6500000, 
        ['https://picsum.photos/400/400?random=15'], 'vehicles', 'cars', 'user_001', 'أحمد محمد', 'sanaa', 145),
      _createProduct('p015', 'نيسان باترول 2022', 'نيسان باترول بلاتينيوم', 18000000, 20000000, 
        ['https://picsum.photos/400/400?random=16'], 'vehicles', 'cars', 'user_002', 'فاطمة عبدالله', 'aden', 89),
    ]);
    
    // عقارات
    products.addAll([
      _createProduct('p016', 'فيلا فاخرة في صنعاء', 'فيلا 3 أدوار مع حديقة وموقف سيارات', 150000000, 180000000, 
        ['https://picsum.photos/400/400?random=17'], 'real_estate', 'villas', 'user_001', 'أحمد محمد', 'sanaa', 234),
      _createProduct('p017', 'شقة للبيع في عدن', 'شقة 3 غرف وصالة في منطقة هادئة', 35000000, 42000000, 
        ['https://picsum.photos/400/400?random=18'], 'real_estate', 'apartments', 'user_002', 'فاطمة عبدالله', 'aden', 156),
      _createProduct('p018', 'أرض سكنية في تعز', 'أرض 500 متر مربع في موقع مميز', 25000000, 30000000, 
        ['https://picsum.photos/400/400?random=19'], 'real_estate', 'lands', 'user_003', 'خالد سعيد', 'taiz', 89),
      _createProduct('p019', 'محل تجاري للإيجار', 'محل في موقع تجاري ممتاز', 500000, 600000, 
        ['https://picsum.photos/400/400?random=20'], 'real_estate', 'shops', 'user_001', 'أحمد محمد', 'sanaa', 45),
      _createProduct('p020', 'مستودع للإيجار', 'مستودع 1000 متر مربع', 800000, 1000000, 
        ['https://picsum.photos/400/400?random=21'], 'real_estate', 'warehouses', 'user_002', 'فاطمة عبدالله', 'aden', 67),
    ]);
    
    // أزياء
    products.addAll([
      _createProduct('p021', 'ساعة رولكس أصلية', 'ساعة رولكس ديت جست أصلية', 2500000, 3000000, 
        ['https://picsum.photos/400/400?random=22'], 'fashion', 'watches', 'user_001', 'أحمد محمد', 'sanaa', 234),
      _createProduct('p022', 'حقيبة قوتشي', 'حقيبة يد نسائية من قوتشي', 850000, 1200000, 
        ['https://picsum.photos/400/400?random=23'], 'fashion', 'bags', 'user_002', 'فاطمة عبدالله', 'aden', 189),
      _createProduct('p023', 'بدلة رجالية فاخرة', 'بدلة رسمية إيطالية الصنع', 180000, 250000, 
        ['https://picsum.photos/400/400?random=24'], 'fashion', 'clothing', 'user_003', 'خالد سعيد', 'taiz', 123),
      _createProduct('p024', 'فستان سهرة', 'فستان سهرة أنيق للمناسبات', 120000, 180000, 
        ['https://picsum.photos/400/400?random=25'], 'fashion', 'clothing', 'user_002', 'فاطمة عبدالله', 'aden', 156),
      _createProduct('p025', 'نظارة شمسية راي بان', 'نظارة شمسية أصلية من راي بان', 45000, 65000, 
        ['https://picsum.photos/400/400?random=26'], 'fashion', 'accessories', 'user_001', 'أحمد محمد', 'sanaa', 289),
    ]);
    
    // أثاث
    products.addAll([
      _createProduct('p026', 'طقم كنب فاخر', 'طقم كنب 7 أشخاص مع طاولة', 850000, 1200000, 
        ['https://picsum.photos/400/400?random=27'], 'furniture', 'living_room', 'user_001', 'أحمد محمد', 'sanaa', 167),
      _createProduct('p027', 'غرفة نوم كاملة', 'غرفة نوم مع دولاب وكومودينو', 650000, 850000, 
        ['https://picsum.photos/400/400?random=28'], 'furniture', 'bedroom', 'user_002', 'فاطمة عبدالله', 'aden', 234),
      _createProduct('p028', 'مطبخ جاهز', 'مطبخ كامل مع خزائن وأجهزة', 1200000, 1500000, 
        ['https://picsum.photos/400/400?random=29'], 'furniture', 'kitchen', 'user_003', 'خالد سعيد', 'taiz', 89),
      _createProduct('p029', 'مكتب خشبي', 'مكتب خشبي فاخر للمكاتب', 180000, 250000, 
        ['https://picsum.photos/400/400?random=30'], 'furniture', 'office', 'user_001', 'أحمد محمد', 'sanaa', 145),
      _createProduct('p030', 'طاولة طعام', 'طاولة طعام 8 أشخاص مع كراسي', 380000, 500000, 
        ['https://picsum.photos/400/400?random=31'], 'furniture', 'dining_room', 'user_002', 'فاطمة عبدالله', 'aden', 78),
    ]);
    
    // خدمات
    products.addAll([
      _createProduct('p031', 'تصميم مواقع إلكترونية', 'تصميم وتطوير مواقع احترافية', 150000, 200000, 
        ['https://picsum.photos/400/400?random=32'], 'services', 'web_design', 'user_001', 'أحمد محمد', 'sanaa', 234),
      _createProduct('p032', 'صيانة مكيفات', 'صيانة وتركيب المكيفات', 15000, 25000, 
        ['https://picsum.photos/400/400?random=33'], 'services', 'maintenance', 'user_002', 'فاطمة عبدالله', 'aden', 189),
      _createProduct('p033', 'نقل أثاث', 'نقل الأثاث بجميع المحافظات', 50000, 100000, 
        ['https://picsum.photos/400/400?random=34'], 'services', 'moving', 'user_003', 'خالد سعيد', 'taiz', 123),
      _createProduct('p034', 'تنظيف منازل', 'تنظيف شامل للمنازل والمكاتب', 25000, 40000, 
        ['https://picsum.photos/400/400?random=35'], 'services', 'cleaning', 'user_001', 'أحمد محمد', 'sanaa', 156),
      _createProduct('p035', 'دروس خصوصية', 'دروس في جميع المواد', 10000, 20000, 
        ['https://picsum.photos/400/400?random=36'], 'services', 'tutoring', 'user_002', 'فاطمة عبدالله', 'aden', 89),
    ]);
    
    // إضافة 100 منتج إضافي
    for (int i = 36; i < 130; i++) {
      final categories = ['electronics', 'vehicles', 'real_estate', 'fashion', 'furniture', 'services', 'sports', 'books', 'pets', 'food'];
      final cities = ['sanaa', 'aden', 'taiz', 'hodeidah', 'ibb', 'mukalla'];
      final sellers = ['user_001', 'user_002', 'user_003'];
      final sellerNames = ['أحمد محمد', 'فاطمة عبدالله', 'خالد سعيد'];
      
      final categoryIndex = i % categories.length;
      final cityIndex = i % cities.length;
      final sellerIndex = i % sellers.length;
      
      products.add(_createProduct(
        'p${(i + 1).toString().padLeft(3, '0')}',
        'منتج رقم ${i + 1} - ${categories[categoryIndex]}',
        'وصف المنتج رقم ${i + 1} بجودة عالية وسعر منافس',
        (i + 1) * 5000.0,
        (i + 1) * 6000.0,
        ['https://picsum.photos/400/400?random=${i + 37}'],
        categories[categoryIndex],
        'sub_${categories[categoryIndex]}',
        sellers[sellerIndex],
        sellerNames[sellerIndex],
        cities[cityIndex],
        (i * 7) % 300,
      ));
    }
    
    return products;
  }
  
  static ProductModel _createProduct(
    String id,
    String title,
    String description,
    double price,
    double oldPrice,
    List<String> images,
    String categoryId,
    String subcategoryId,
    String sellerId,
    String sellerName,
    String city,
    int views,
  ) {
    return ProductModel(
      id: id,
      title: title,
      description: description,
      price: price,
      oldPrice: oldPrice,
      images: images,
      categoryId: categoryId,
      subcategoryId: subcategoryId,
      sellerId: sellerId,
      sellerName: sellerName,
      sellerAvatar: 'https://i.pravatar.cc/150?u=$sellerId',
      city: city,
      condition: 'new',
      hasWarranty: true,
      warrantyPeriod: 'سنة',
      hasShipping: true,
      shippingCost: 5000,
      isNegotiable: true,
      views: views,
      favoritesCount: (views * 0.1).round(),
      rating: 3.5 + (views % 20) / 10,
      ratingCount: (views * 0.05).round(),
      status: 'active',
      isFeatured: views > 200,
      isPromoted: views > 150,
      createdAt: DateTime.now().subtract(Duration(days: views % 30)),
      updatedAt: DateTime.now().subtract(Duration(days: views % 10)),
      isAuction: views % 7 == 0,
      currentBid: views % 7 == 0 ? price * 1.1 : null,
      bidsCount: views % 7 == 0 ? (views % 20) : null,
    );
  }
}
