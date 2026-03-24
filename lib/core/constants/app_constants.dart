class AppConstants {
  // معلومات التطبيق
  static const String appName = 'Flex Yemen';
  static const String appVersion = '1.0.0';
  static const String appTagline = 'منصة التجارة الإلكترونية اليمنية';
  static const String appDescription = 'أكبر منصة للتجارة الإلكترونية في اليمن';
  
  // روابط التواصل
  static const String supportPhone = '+967-XXX-XXX-XXX';
  static const String supportEmail = 'support@flexyemen.com';
  static const String websiteUrl = 'https://flexyemen.com';
  static const String facebookUrl = 'https://facebook.com/flexyemen';
  static const String twitterUrl = 'https://twitter.com/flexyemen';
  static const String instagramUrl = 'https://instagram.com/flexyemen';
  
  // إعدادات Supabase
  static const String supabaseUrl = 'https://your-project.supabase.co';
  static const String supabaseAnonKey = 'your-anon-key';
  
  // إعدادات الخريطة
  static const String mapboxAccessToken = 'your-mapbox-token';
  static const double defaultLatitude = 15.3694;
  static const double defaultLongitude = 44.1910;
  static const double defaultZoom = 12.0;
  
  // حدود الصفحات
  static const int productsPerPage = 20;
  static const int ordersPerPage = 10;
  static const int chatsPerPage = 15;
  static const int notificationsPerPage = 20;
  
  // مدد الصلاحية
  static const int accessTokenExpiryDays = 7;
  static const int refreshTokenExpiryDays = 30;
  static const int otpExpiryMinutes = 5;
  static const int auctionReminderHours = 24;
  
  // أنواع المستخدمين
  static const String userTypeCustomer = 'customer';
  static const String userTypeSeller = 'seller';
  static const String userTypeAdmin = 'admin';
  
  // حالات الطلب
  static const String orderStatusPending = 'pending';
  static const String orderStatusConfirmed = 'confirmed';
  static const String orderStatusProcessing = 'processing';
  static const String orderStatusShipped = 'shipped';
  static const String orderStatusDelivered = 'delivered';
  static const String orderStatusCancelled = 'cancelled';
  static const String orderStatusRefunded = 'refunded';
  
  // حالات المنتج
  static const String productStatusActive = 'active';
  static const String productStatusSold = 'sold';
  static const String productStatusReserved = 'reserved';
  static const String productStatusHidden = 'hidden';
  
  // أنواع المعاملات
  static const String transactionTypeDeposit = 'deposit';
  static const String transactionTypeWithdrawal = 'withdrawal';
  static const String transactionTypeTransfer = 'transfer';
  static const String transactionTypePayment = 'payment';
  static const String transactionTypeRefund = 'refund';
  static const String transactionTypeCommission = 'commission';
  
  // حالات المعاملات
  static const String transactionStatusPending = 'pending';
  static const String transactionStatusCompleted = 'completed';
  static const String transactionStatusFailed = 'failed';
  static const String transactionStatusCancelled = 'cancelled';
  
  // أنواع الإشعارات
  static const String notificationTypeOrder = 'order';
  static const String notificationTypeMessage = 'message';
  static const String notificationTypeProduct = 'product';
  static const String notificationTypeWallet = 'wallet';
  static const String notificationTypeSystem = 'system';
  static const String notificationTypePromotion = 'promotion';
  
  // المدن اليمنية
  static final List<Map<String, dynamic>> yemeniCities = [
    {'id': 'sanaa', 'name': 'صنعاء', 'lat': 15.3694, 'lng': 44.1910},
    {'id': 'aden', 'name': 'عدن', 'lat': 12.7855, 'lng': 45.0187},
    {'id': 'taiz', 'name': 'تعز', 'lat': 13.5795, 'lng': 44.0209},
    {'id': 'hodeidah', 'name': 'الحديدة', 'lat': 14.7974, 'lng': 42.9541},
    {'id': 'ibb', 'name': 'إب', 'lat': 13.9667, 'lng': 44.1833},
    {'id': 'mukalla', 'name': 'المكلا', 'lat': 14.5333, 'lng': 49.1333},
    {'id': 'seiyun', 'name': 'سيئون', 'lat': 15.9667, 'lng': 48.8000},
    {'id': 'sayyan', 'name': 'سيان', 'lat': 15.1718, 'lng': 44.3244},
    {'id': 'zabid', 'name': 'زبيد', 'lat': 14.1951, 'lng': 43.3155},
    {'id': 'hajjah', 'name': 'حجة', 'lat': 15.6917, 'lng': 43.6021},
    {'id': 'dhamar', 'name': 'ذمار', 'lat': 14.5427, 'lng': 44.4051},
    {'id': 'amran', 'name': 'عمران', 'lat': 15.6594, 'lng': 43.9438},
    {'id': 'marib', 'name': 'مأرب', 'lat': 15.4627, 'lng': 45.3258},
    {'id': 'al_bayda', 'name': 'البيضاء', 'lat': 13.9852, 'lng': 45.5727},
    {'id': 'lahij', 'name': 'لحج', 'lat': 13.0567, 'lng': 44.8806},
    {'id': 'abyan', 'name': 'أبين', 'lat': 13.6667, 'lng': 45.8333},
    {'id': 'shabwah', 'name': 'شبوة', 'lat': 14.7500, 'lng': 46.7167},
    {'id': 'hadramout', 'name': 'حضرموت', 'lat': 16.0000, 'lng': 49.5000},
    {'id': 'al_jawf', 'name': 'الجوف', 'lat': 16.5944, 'lng': 44.3344},
    {'id': 'saada', 'name': 'صعدة', 'lat': 16.9408, 'lng': 43.7598},
    {'id': 'raymah', 'name': 'ريمة', 'lat': 14.6000, 'lng': 43.8000},
    {'id': 'mahwit', 'name': 'المحويت', 'lat': 15.4708, 'lng': 43.5444},
  ];
  
  // الفئات الرئيسية
  static final List<Map<String, dynamic>> mainCategories = [
    {'id': 'electronics', 'name': 'إلكترونيات', 'icon': 'devices'},
    {'id': 'vehicles', 'name': 'سيارات', 'icon': 'directions_car'},
    {'id': 'real_estate', 'name': 'عقارات', 'icon': 'home'},
    {'id': 'fashion', 'name': 'أزياء', 'icon': 'checkroom'},
    {'id': 'furniture', 'name': 'أثاث', 'icon': 'chair'},
    {'id': 'jobs', 'name': 'وظائف', 'icon': 'work'},
    {'id': 'services', 'name': 'خدمات', 'icon': 'build'},
    {'id': 'sports', 'name': 'رياضة', 'icon': 'sports'},
    {'id': 'books', 'name': 'كتب', 'icon': 'menu_book'},
    {'id': 'pets', 'name': 'حيوانات', 'icon': 'pets'},
    {'id': 'food', 'name': 'مطاعم', 'icon': 'restaurant'},
    {'id': 'health', 'name': 'صحة', 'icon': 'local_hospital'},
  ];
  
  // العملات
  static final List<Map<String, dynamic>> currencies = [
    {'code': 'YER', 'name': 'ريال يمني', 'symbol': 'ر.ي', 'flag': '🇾🇪'},
    {'code': 'SAR', 'name': 'ريال سعودي', 'symbol': 'ر.س', 'flag': '🇸🇦'},
    {'code': 'USD', 'name': 'دولار أمريكي', 'symbol': '$', 'flag': '🇺🇸'},
  ];
  
  // أسعار الصرف (تقريبية)
  static const double yerToSar = 0.015;
  static const double yerToUsd = 0.004;
  static const double sarToYer = 66.67;
  static const double usdToYer = 250.0;
  
  // رسوم المنصة
  static const double platformCommissionRate = 0.05; // 5%
  static const double withdrawalFee = 1000; // 1000 ريال يمني
  static const double minimumWithdrawal = 5000; // 5000 ريال يمني
  static const double minimumDeposit = 1000; // 1000 ريال يمني
  static const double featuredAdPrice = 5000; // 5000 ريال يمني
  static const double premiumAdPrice = 10000; // 10000 ريال يمني
  
  // حدود الملفات
  static const int maxImageSizeMB = 5;
  static const int maxImagesPerProduct = 10;
  static const int maxVideoSizeMB = 50;
  static const List<String> allowedImageExtensions = ['jpg', 'jpeg', 'png', 'webp'];
  static const List<String> allowedVideoExtensions = ['mp4', 'mov', 'avi'];
  
  // رسائل الخطأ
  static const String errorNetwork = 'خطأ في الاتصال بالشبكة';
  static const String errorServer = 'خطأ في الخادم';
  static const String errorUnauthorized = 'غير مصرح';
  static const String errorNotFound = 'غير موجود';
  static const String errorValidation = 'خطأ في التحقق من البيانات';
  static const String errorUnknown = 'حدث خطأ غير معروف';
  static const String errorTimeout = 'انتهت مهلة الطلب';
  static const String errorNoInternet = 'لا يوجد اتصال بالإنترنت';
  
  // رسائل النجاح
  static const String successLogin = 'تم تسجيل الدخول بنجاح';
  static const String successRegister = 'تم إنشاء الحساب بنجاح';
  static const String successLogout = 'تم تسجيل الخروج بنجاح';
  static const String successUpdate = 'تم التحديث بنجاح';
  static const String successDelete = 'تم الحذف بنجاح';
  static const String successCreate = 'تم الإنشاء بنجاح';
  static const String successOrder = 'تم تقديم الطلب بنجاح';
  static const String successPayment = 'تم الدفع بنجاح';
  static const String successTransfer = 'تم التحويل بنجاح';
  static const String successDeposit = 'تم الإيداع بنجاح';
  static const String successWithdrawal = 'تم السحب بنجاح';
  
  // نصوص واجهة المستخدم
  static const String welcomeMessage = 'مرحباً بك في Flex Yemen';
  static const String loginTitle = 'تسجيل الدخول';
  static const String registerTitle = 'إنشاء حساب جديد';
  static const String forgotPasswordTitle = 'نسيت كلمة المرور';
  static const String homeTitle = 'الرئيسية';
  static const String walletTitle = 'المحفظة';
  static const String chatTitle = 'المحادثات';
  static const String profileTitle = 'حسابي';
  static const String settingsTitle = 'الإعدادات';
  static const String notificationsTitle = 'الإشعارات';
  static const String favoritesTitle = 'المفضلة';
  static const String ordersTitle = 'طلباتي';
  static const String productsTitle = 'منتجاتي';
  static const String addProductTitle = 'إضافة منتج';
  static const String searchTitle = 'البحث';
  static const String cartTitle = 'سلة التسوق';
  static const String checkoutTitle = 'إتمام الشراء';
  
  // أسماء الأشهر العربية
  static final List<String> arabicMonths = [
    'يناير', 'فبراير', 'مارس', 'إبريل', 'مايو', 'يونيو',
    'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'
  ];
  
  // أيام الأسبوع العربية
  static final List<String> arabicWeekDays = [
    'الأحد', 'الإثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت'
  ];
}
