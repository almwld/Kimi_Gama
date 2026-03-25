import 'package:hive/hive.dart';


@HiveType(typeId: 11)
class AdModel extends HiveObject {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String title;
  
  @HiveField(2)
  final String description;
  
  @HiveField(3)
  final List<String> images;
  
  @HiveField(4)
  final String? videoUrl;
  
  @HiveField(5)
  final String linkUrl;
  
  @HiveField(6)
  final String type;
  
  @HiveField(7)
  final String position;
  
  @HiveField(8)
  final DateTime startDate;
  
  @HiveField(9)
  final DateTime endDate;
  
  @HiveField(10)
  final bool isActive;
  
  @HiveField(11)
  final int impressions;
  
  @HiveField(12)
  final int clicks;
  
  @HiveField(13)
  final double budget;
  
  @HiveField(14)
  final double spent;
  
  @HiveField(15)
  final String? targetCity;
  
  @HiveField(16)
  final String? targetCategory;
  
  @HiveField(17)
  final DateTime createdAt;

  AdModel({
    required this.id,
    required this.title,
    required this.description,
    required this.images,
    this.videoUrl,
    required this.linkUrl,
    required this.type,
    required this.position,
    required this.startDate,
    required this.endDate,
    this.isActive = true,
    this.impressions = 0,
    this.clicks = 0,
    required this.budget,
    this.spent = 0.0,
    this.targetCity,
    this.targetCategory,
    required this.createdAt,
  });

  factory AdModel.fromJson(Map<String, dynamic> json) {
    return AdModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      videoUrl: json['video_url'],
      linkUrl: json['link_url'] ?? '',
      type: json['type'] ?? 'banner',
      position: json['position'] ?? 'home',
      startDate: json['start_date'] != null 
          ? DateTime.parse(json['start_date']) 
          : DateTime.now(),
      endDate: json['end_date'] != null 
          ? DateTime.parse(json['end_date']) 
          : DateTime.now(),
      isActive: json['is_active'] ?? true,
      impressions: json['impressions'] ?? 0,
      clicks: json['clicks'] ?? 0,
      budget: (json['budget'] ?? 0.0).toDouble(),
      spent: (json['spent'] ?? 0.0).toDouble(),
      targetCity: json['target_city'],
      targetCategory: json['target_category'],
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'images': images,
      'video_url': videoUrl,
      'link_url': linkUrl,
      'type': type,
      'position': position,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'is_active': isActive,
      'impressions': impressions,
      'clicks': clicks,
      'budget': budget,
      'spent': spent,
      'target_city': targetCity,
      'target_category': targetCategory,
      'created_at': createdAt.toIso8601String(),
    };
  }

  // CTR (Click Through Rate)
  double get ctr {
    if (impressions == 0) return 0.0;
    return (clicks / impressions * 100);
  }

  // بيانات وهمية
  static List<AdModel> get dummyAds => [
    AdModel(
      id: 'ad_001',
      title: 'تخفيضات كبرى',
      description: 'خصومات تصل إلى 50% على جميع المنتجات',
      images: ['https://picsum.photos/800/400?random=70'],
      linkUrl: 'https://flexyemen.com/sale',
      type: 'banner',
      position: 'home_slider',
      startDate: DateTime.now().subtract(Duration(days: 5)),
      endDate: DateTime.now().add(Duration(days: 10)),
      isActive: true,
      impressions: 15000,
      clicks: 850,
      budget: 500000,
      spent: 250000,
      createdAt: DateTime.now().subtract(Duration(days: 5)),
    ),
    AdModel(
      id: 'ad_002',
      title: 'آيفون 15 الجديد',
      description: 'احصل على آيفون 15 بأفضل سعر',
      images: ['https://picsum.photos/800/400?random=71'],
      linkUrl: 'https://flexyemen.com/products/iphone15',
      type: 'banner',
      position: 'home_slider',
      startDate: DateTime.now().subtract(Duration(days: 3)),
      endDate: DateTime.now().add(Duration(days: 15)),
      isActive: true,
      impressions: 12000,
      clicks: 720,
      budget: 400000,
      spent: 180000,
      targetCategory: 'electronics',
      createdAt: DateTime.now().subtract(Duration(days: 3)),
    ),
    AdModel(
      id: 'ad_003',
      title: 'عروض السيارات',
      description: 'أفضل عروض السيارات المستعملة',
      images: ['https://picsum.photos/800/400?random=72'],
      linkUrl: 'https://flexyemen.com/cars',
      type: 'banner',
      position: 'home_slider',
      startDate: DateTime.now().subtract(Duration(days: 1)),
      endDate: DateTime.now().add(Duration(days: 20)),
      isActive: true,
      impressions: 8000,
      clicks: 450,
      budget: 300000,
      spent: 120000,
      targetCategory: 'vehicles',
      createdAt: DateTime.now().subtract(Duration(days: 1)),
    ),
    AdModel(
      id: 'ad_004',
      title: 'عقارات صنعاء',
      description: 'أفضل العقارات في صنعاء بأسعار منافسة',
      images: ['https://picsum.photos/800/400?random=73'],
      linkUrl: 'https://flexyemen.com/realestate/sanaa',
      type: 'banner',
      position: 'category',
      startDate: DateTime.now().subtract(Duration(days: 7)),
      endDate: DateTime.now().add(Duration(days: 30)),
      isActive: true,
      impressions: 6000,
      clicks: 280,
      budget: 250000,
      spent: 90000,
      targetCity: 'sanaa',
      targetCategory: 'real_estate',
      createdAt: DateTime.now().subtract(Duration(days: 7)),
    ),
    AdModel(
      id: 'ad_005',
      title: 'أزياء رمضان',
      description: 'تشكيلة جديدة من الأزياء الرمضانية',
      images: ['https://picsum.photos/800/400?random=74'],
      linkUrl: 'https://flexyemen.com/fashion/ramadan',
      type: 'banner',
      position: 'home_middle',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: 25)),
      isActive: true,
      impressions: 2000,
      clicks: 120,
      budget: 200000,
      spent: 30000,
      targetCategory: 'fashion',
      createdAt: DateTime.now(),
    ),
  ];
}
