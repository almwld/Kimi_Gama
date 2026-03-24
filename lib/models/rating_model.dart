import 'package:hive/hive.dart';

part 'rating_model.g.dart';

@HiveType(typeId: 10)
class RatingModel extends HiveObject {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String productId;
  
  @HiveField(2)
  final String reviewerId;
  
  @HiveField(3)
  final String reviewerName;
  
  @HiveField(4)
  final String? reviewerAvatar;
  
  @HiveField(5)
  final double rating;
  
  @HiveField(6)
  final String? comment;
  
  @HiveField(7)
  final List<String>? images;
  
  @HiveField(8)
  final DateTime createdAt;
  
  @HiveField(9)
  final DateTime? updatedAt;
  
  @HiveField(10)
  final bool isVerified;
  
  @HiveField(11)
  final int helpfulCount;
  
  @HiveField(12)
  final String? sellerReply;
  
  @HiveField(13)
  final DateTime? sellerReplyAt;

  RatingModel({
    required this.id,
    required this.productId,
    required this.reviewerId,
    required this.reviewerName,
    this.reviewerAvatar,
    required this.rating,
    this.comment,
    this.images,
    required this.createdAt,
    this.updatedAt,
    this.isVerified = false,
    this.helpfulCount = 0,
    this.sellerReply,
    this.sellerReplyAt,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      id: json['id'] ?? '',
      productId: json['product_id'] ?? '',
      reviewerId: json['reviewer_id'] ?? '',
      reviewerName: json['reviewer_name'] ?? '',
      reviewerAvatar: json['reviewer_avatar'],
      rating: (json['rating'] ?? 0.0).toDouble(),
      comment: json['comment'],
      images: json['images'] != null 
          ? List<String>.from(json['images']) 
          : null,
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at']) 
          : null,
      isVerified: json['is_verified'] ?? false,
      helpfulCount: json['helpful_count'] ?? 0,
      sellerReply: json['seller_reply'],
      sellerReplyAt: json['seller_reply_at'] != null 
          ? DateTime.parse(json['seller_reply_at']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'reviewer_id': reviewerId,
      'reviewer_name': reviewerName,
      'reviewer_avatar': reviewerAvatar,
      'rating': rating,
      'comment': comment,
      'images': images,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'is_verified': isVerified,
      'helpful_count': helpfulCount,
      'seller_reply': sellerReply,
      'seller_reply_at': sellerReplyAt?.toIso8601String(),
    };
  }

  // بيانات وهمية
  static List<RatingModel> get dummyRatings => [
    RatingModel(
      id: 'rate_001',
      productId: 'p001',
      reviewerId: 'user_002',
      reviewerName: 'فاطمة عبدالله',
      reviewerAvatar: 'https://i.pravatar.cc/150?img=5',
      rating: 5.0,
      comment: 'منتج رائع وجودة عالية، التوصيل كان سريع والبائع محترم',
      images: ['https://picsum.photos/400/400?random=60'],
      createdAt: DateTime.now().subtract(Duration(days: 5)),
      isVerified: true,
      helpfulCount: 12,
      sellerReply: 'شكراً لتقييمك، نسعد بخدمتك دائماً',
      sellerReplyAt: DateTime.now().subtract(Duration(days: 4)),
    ),
    RatingModel(
      id: 'rate_002',
      productId: 'p001',
      reviewerId: 'user_003',
      reviewerName: 'خالد سعيد',
      reviewerAvatar: 'https://i.pravatar.cc/150?img=3',
      rating: 4.5,
      comment: 'المنتج ممتاز لكن التغليف كان يحتاج لاهتمام أكثر',
      createdAt: DateTime.now().subtract(Duration(days: 10)),
      isVerified: true,
      helpfulCount: 8,
    ),
    RatingModel(
      id: 'rate_003',
      productId: 'p001',
      reviewerId: 'user_004',
      reviewerName: 'محمد علي',
      reviewerAvatar: 'https://i.pravatar.cc/150?img=8',
      rating: 5.0,
      comment: 'أفضل منتج اشتريته هذا العام، أنصح الجميع به',
      images: ['https://picsum.photos/400/400?random=61', 'https://picsum.photos/400/400?random=62'],
      createdAt: DateTime.now().subtract(Duration(days: 15)),
      isVerified: true,
      helpfulCount: 25,
      sellerReply: 'نشكر ثقتك بنا ونسعد بخدمتك',
      sellerReplyAt: DateTime.now().subtract(Duration(days: 14)),
    ),
    RatingModel(
      id: 'rate_004',
      productId: 'p002',
      reviewerId: 'user_001',
      reviewerName: 'أحمد محمد',
      reviewerAvatar: 'https://i.pravatar.cc/150?img=11',
      rating: 4.0,
      comment: 'جيد لكن السعر مرتفع قليلاً',
      createdAt: DateTime.now().subtract(Duration(days: 7)),
      isVerified: true,
      helpfulCount: 5,
    ),
    RatingModel(
      id: 'rate_005',
      productId: 'p003',
      reviewerId: 'user_005',
      reviewerName: 'سارة أحمد',
      reviewerAvatar: 'https://i.pravatar.cc/150?img=9',
      rating: 5.0,
      comment: 'ممتاز جداً، سعر منافس وجودة عالية',
      createdAt: DateTime.now().subtract(Duration(days: 3)),
      isVerified: true,
      helpfulCount: 15,
    ),
  ];
}
