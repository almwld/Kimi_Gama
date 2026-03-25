import 'package:hive/hive.dart';


@HiveType(typeId: 1)
class UserModel extends HiveObject {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String fullName;
  
  @HiveField(2)
  final String email;
  
  @HiveField(3)
  final String phone;
  
  @HiveField(4)
  final String? avatarUrl;
  
  @HiveField(5)
  final String? coverUrl;
  
  @HiveField(6)
  final String userType;
  
  @HiveField(7)
  final String city;
  
  @HiveField(8)
  final String? address;
  
  @HiveField(9)
  final DateTime createdAt;
  
  @HiveField(10)
  final DateTime? lastLogin;
  
  @HiveField(11)
  final bool isVerified;
  
  @HiveField(12)
  final bool isActive;
  
  @HiveField(13)
  final int adsCount;
  
  @HiveField(14)
  final int followersCount;
  
  @HiveField(15)
  final int followingCount;
  
  @HiveField(16)
  final double rating;
  
  @HiveField(17)
  final int ratingCount;
  
  @HiveField(18)
  final String? bio;
  
  @HiveField(19)
  final String? website;
  
  @HiveField(20)
  final String? facebook;
  
  @HiveField(21)
  final String? instagram;
  
  @HiveField(22)
  final String? twitter;
  
  @HiveField(23)
  final bool notificationsEnabled;
  
  @HiveField(24)
  final String language;
  
  @HiveField(25)
  final String theme;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    this.avatarUrl,
    this.coverUrl,
    required this.userType,
    required this.city,
    this.address,
    required this.createdAt,
    this.lastLogin,
    this.isVerified = false,
    this.isActive = true,
    this.adsCount = 0,
    this.followersCount = 0,
    this.followingCount = 0,
    this.rating = 0.0,
    this.ratingCount = 0,
    this.bio,
    this.website,
    this.facebook,
    this.instagram,
    this.twitter,
    this.notificationsEnabled = true,
    this.language = 'ar',
    this.theme = 'system',
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      avatarUrl: json['avatar_url'],
      coverUrl: json['cover_url'],
      userType: json['user_type'] ?? 'customer',
      city: json['city'] ?? '',
      address: json['address'],
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
      lastLogin: json['last_login'] != null 
          ? DateTime.parse(json['last_login']) 
          : null,
      isVerified: json['is_verified'] ?? false,
      isActive: json['is_active'] ?? true,
      adsCount: json['ads_count'] ?? 0,
      followersCount: json['followers_count'] ?? 0,
      followingCount: json['following_count'] ?? 0,
      rating: (json['rating'] ?? 0.0).toDouble(),
      ratingCount: json['rating_count'] ?? 0,
      bio: json['bio'],
      website: json['website'],
      facebook: json['facebook'],
      instagram: json['instagram'],
      twitter: json['twitter'],
      notificationsEnabled: json['notifications_enabled'] ?? true,
      language: json['language'] ?? 'ar',
      theme: json['theme'] ?? 'system',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'avatar_url': avatarUrl,
      'cover_url': coverUrl,
      'user_type': userType,
      'city': city,
      'address': address,
      'created_at': createdAt.toIso8601String(),
      'last_login': lastLogin?.toIso8601String(),
      'is_verified': isVerified,
      'is_active': isActive,
      'ads_count': adsCount,
      'followers_count': followersCount,
      'following_count': followingCount,
      'rating': rating,
      'rating_count': ratingCount,
      'bio': bio,
      'website': website,
      'facebook': facebook,
      'instagram': instagram,
      'twitter': twitter,
      'notifications_enabled': notificationsEnabled,
      'language': language,
      'theme': theme,
    };
  }

  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phone,
    String? avatarUrl,
    String? coverUrl,
    String? userType,
    String? city,
    String? address,
    DateTime? createdAt,
    DateTime? lastLogin,
    bool? isVerified,
    bool? isActive,
    int? adsCount,
    int? followersCount,
    int? followingCount,
    double? rating,
    int? ratingCount,
    String? bio,
    String? website,
    String? facebook,
    String? instagram,
    String? twitter,
    bool? notificationsEnabled,
    String? language,
    String? theme,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      coverUrl: coverUrl ?? this.coverUrl,
      userType: userType ?? this.userType,
      city: city ?? this.city,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
      isVerified: isVerified ?? this.isVerified,
      isActive: isActive ?? this.isActive,
      adsCount: adsCount ?? this.adsCount,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      rating: rating ?? this.rating,
      ratingCount: ratingCount ?? this.ratingCount,
      bio: bio ?? this.bio,
      website: website ?? this.website,
      facebook: facebook ?? this.facebook,
      instagram: instagram ?? this.instagram,
      twitter: twitter ?? this.twitter,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      language: language ?? this.language,
      theme: theme ?? this.theme,
    );
  }

  // بيانات وهمية للاختبار
  static UserModel get dummyUser => UserModel(
    id: 'user_001',
    fullName: 'أحمد محمد علي',
    email: 'ahmed@example.com',
    phone: '+967 777 123 456',
    avatarUrl: 'https://i.pravatar.cc/150?img=11',
    coverUrl: 'https://picsum.photos/800/300',
    userType: 'seller',
    city: 'sanaa',
    address: 'شارع تعز، صنعاء',
    createdAt: DateTime.now().subtract(Duration(days: 365)),
    lastLogin: DateTime.now(),
    isVerified: true,
    isActive: true,
    adsCount: 25,
    followersCount: 150,
    followingCount: 80,
    rating: 4.8,
    ratingCount: 45,
    bio: 'تاجر إلكتروني متخصص في بيع الإلكترونيات والأجهزة الذكية',
    website: 'https://ahmedstore.com',
    notificationsEnabled: true,
    language: 'ar',
    theme: 'light',
  );

  static List<UserModel> get dummyUsers => [
    dummyUser,
    UserModel(
      id: 'user_002',
      fullName: 'فاطمة عبدالله',
      email: 'fatima@example.com',
      phone: '+967 777 234 567',
      avatarUrl: 'https://i.pravatar.cc/150?img=5',
      userType: 'customer',
      city: 'aden',
      createdAt: DateTime.now().subtract(Duration(days: 180)),
      isVerified: true,
      rating: 4.5,
      ratingCount: 12,
    ),
    UserModel(
      id: 'user_003',
      fullName: 'خالد سعيد',
      email: 'khaled@example.com',
      phone: '+967 777 345 678',
      avatarUrl: 'https://i.pravatar.cc/150?img=3',
      userType: 'seller',
      city: 'taiz',
      createdAt: DateTime.now().subtract(Duration(days: 90)),
      adsCount: 15,
      followersCount: 50,
      rating: 4.2,
      ratingCount: 20,
    ),
  ];
}
