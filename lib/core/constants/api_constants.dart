class ApiConstants {
  // Base URLs
  static const String baseUrl = 'https://api.flexyemen.com/v1';
  static const String supabaseUrl = 'https://your-project.supabase.co';
  static const String storageUrl = 'https://your-project.supabase.co/storage/v1';
  
  // Auth Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String verifyEmail = '/auth/verify-email';
  static const String verifyPhone = '/auth/verify-phone';
  static const String resendOtp = '/auth/resend-otp';
  
  // User Endpoints
  static const String getUser = '/users/me';
  static const String updateUser = '/users/me';
  static const String deleteUser = '/users/me';
  static const String updateProfile = '/users/profile';
  static const String updateAvatar = '/users/avatar';
  static const String changePassword = '/users/change-password';
  static const String getUserById = '/users';
  static const String followUser = '/users/follow';
  static const String unfollowUser = '/users/unfollow';
  static const String getFollowers = '/users/followers';
  static const String getFollowing = '/users/following';
  
  // Product Endpoints
  static const String getProducts = '/products';
  static const String getProduct = '/products';
  static const String createProduct = '/products';
  static const String updateProduct = '/products';
  static const String deleteProduct = '/products';
  static const String getUserProducts = '/products/user';
  static const String getFeaturedProducts = '/products/featured';
  static const String getRecentProducts = '/products/recent';
  static const String getPopularProducts = '/products/popular';
  static const String searchProducts = '/products/search';
  static const String getProductsByCategory = '/products/category';
  static const String getProductsByCity = '/products/city';
  static const String toggleFavorite = '/products/favorite';
  static const String getFavorites = '/products/favorites';
  static const String reportProduct = '/products/report';
  static const String boostProduct = '/products/boost';
  static const String renewProduct = '/products/renew';
  
  // Category Endpoints
  static const String getCategories = '/categories';
  static const String getCategory = '/categories';
  static const String getSubcategories = '/categories/subcategories';
  
  // Order Endpoints
  static const String getOrders = '/orders';
  static const String getOrder = '/orders';
  static const String createOrder = '/orders';
  static const String updateOrder = '/orders';
  static const String cancelOrder = '/orders/cancel';
  static const String confirmOrder = '/orders/confirm';
  static const String shipOrder = '/orders/ship';
  static const String deliverOrder = '/orders/deliver';
  static const String getOrderTracking = '/orders/tracking';
  
  // Cart Endpoints
  static const String getCart = '/cart';
  static const String addToCart = '/cart/add';
  static const String updateCartItem = '/cart/update';
  static const String removeFromCart = '/cart/remove';
  static const String clearCart = '/cart/clear';
  
  // Wallet Endpoints
  static const String getWallet = '/wallet';
  static const String getWalletBalance = '/wallet/balance';
  static const String deposit = '/wallet/deposit';
  static const String withdraw = '/wallet/withdraw';
  static const String transfer = '/wallet/transfer';
  static const String getTransactions = '/wallet/transactions';
  static const String getTransaction = '/wallet/transactions';
  
  // Payment Endpoints
  static const String createPayment = '/payments';
  static const String verifyPayment = '/payments/verify';
  static const String getPaymentMethods = '/payments/methods';
  static const String addPaymentMethod = '/payments/methods';
  static const String removePaymentMethod = '/payments/methods';
  
  // Chat Endpoints
  static const String getChats = '/chats';
  static const String getChat = '/chats';
  static const String createChat = '/chats';
  static const String getMessages = '/chats/messages';
  static const String sendMessage = '/chats/messages';
  static const String deleteMessage = '/chats/messages';
  static const String markAsRead = '/chats/read';
  static const String uploadChatImage = '/chats/upload';
  
  // Notification Endpoints
  static const String getNotifications = '/notifications';
  static const String markNotificationRead = '/notifications/read';
  static const String markAllNotificationsRead = '/notifications/read-all';
  static const String deleteNotification = '/notifications';
  static const String updateNotificationSettings = '/notifications/settings';
  static const String getNotificationSettings = '/notifications/settings';
  
  // Review Endpoints
  static const String getReviews = '/reviews';
  static const String createReview = '/reviews';
  static const String updateReview = '/reviews';
  static const String deleteReview = '/reviews';
  static const String getProductReviews = '/reviews/product';
  static const String getUserReviews = '/reviews/user';
  
  // Auction Endpoints
  static const String getAuctions = '/auctions';
  static const String getAuction = '/auctions';
  static const String createAuction = '/auctions';
  static const String placeBid = '/auctions/bid';
  static const String getAuctionBids = '/auctions/bids';
  static const String endAuction = '/auctions/end';
  
  // Ad Endpoints
  static const String getAds = '/ads';
  static const String getAd = '/ads';
  static const String createAd = '/ads';
  static const String updateAd = '/ads';
  static const String deleteAd = '/ads';
  static const String getUserAds = '/ads/user';
  static const String promoteAd = '/ads/promote';
  
  // Location Endpoints
  static const String getCities = '/locations/cities';
  static const String getCity = '/locations/cities';
  static const String getAreas = '/locations/areas';
  static const String geocode = '/locations/geocode';
  static const String reverseGeocode = '/locations/reverse-geocode';
  
  // Search Endpoints
  static const String search = '/search';
  static const String searchSuggestions = '/search/suggestions';
  static const String getRecentSearches = '/search/recent';
  static const String clearRecentSearches = '/search/clear';
  
  // Support Endpoints
  static const String createTicket = '/support/tickets';
  static const String getTickets = '/support/tickets';
  static const String getTicket = '/support/tickets';
  static const String addTicketReply = '/support/tickets/reply';
  static const String getFaqs = '/support/faqs';
  static const String getFaq = '/support/faqs';
  static const String contactUs = '/support/contact';
  
  // Settings Endpoints
  static const String getSettings = '/settings';
  static const String updateSettings = '/settings';
  static const String getAppVersion = '/settings/version';
  
  // Upload Endpoints
  static const String uploadImage = '/upload/image';
  static const String uploadMultipleImages = '/upload/images';
  static const String uploadVideo = '/upload/video';
  static const String uploadFile = '/upload/file';
  static const String deleteFile = '/upload/delete';
  
  // Headers
  static Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  
  static Map<String, String> authHeaders(String token) => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };
  
  static Map<String, String> multipartHeaders(String token) => {
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };
  
  // Timeouts
  static const int connectTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
  static const int sendTimeout = 30000; // 30 seconds
  
  // Pagination
  static const int defaultPage = 1;
  static const int defaultLimit = 20;
  static const int maxLimit = 100;
  
  // Retry
  static const int maxRetries = 3;
  static const int retryDelay = 1000; // 1 second
}
