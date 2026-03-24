# Flex Yemen - منصة التجارة الإلكترونية اليمنية

تطبيق Flex Yemen هو منصة تجارة إلكترونية شاملة مصممة خصيصاً للسوق اليمني، تنافس Amazon و Alibaba في الميزات والتصميم.

## المميزات الرئيسية

### المصادقة والمستخدمين
- تسجيل الدخول بالبريد الإلكتروني/رقم الهاتف
- إنشاء حساب جديد مع التحقق
- استعادة كلمة المرور
- ملفات شخصية مفصلة
- متابعة المستخدمين

### المنتجات (130+ منتج)
- عرض المنتجات في شبكة
- فئات متعددة (إلكترونيات، سيارات، عقارات، أزياء، إلخ)
- بحث متقدم وتصفية
- المفضلة
- تقييمات ومراجعات

### المحفظة الإلكترونية (22 خدمة)
- إيداع وسحب
- تحويلات مالية
- دفع فواتير
- شحن رصيد
- شراء بطاقات هدايا
- خدمات ترفيهية

### المحادثات
- محادثات فورية
- إرسال الصور
- إشعارات فورية

### الطلبات
- سلة تسوق
- إتمام الشراء
- تتبع الطلبات
- سجل الطلبات

## هيكل المشروع

```
lib/
├── main.dart
├── core/
│   ├── constants/
│   │   ├── app_constants.dart
│   │   ├── api_constants.dart
│   │   └── color_constants.dart
│   └── utils/
│       ├── validators.dart
│       ├── formatters.dart
│       └── helpers.dart
├── models/
│   ├── user_model.dart
│   ├── product_model.dart
│   ├── order_model.dart
│   ├── chat_model.dart
│   ├── wallet_model.dart
│   ├── notification_model.dart
│   ├── rating_model.dart
│   └── ad_model.dart
├── providers/
│   ├── auth_provider.dart
│   ├── theme_provider.dart
│   ├── product_provider.dart
│   ├── wallet_provider.dart
│   ├── chat_provider.dart
│   ├── order_provider.dart
│   └── notification_provider.dart
├── services/
│   ├── supabase_service.dart
│   ├── local_storage_service.dart
│   ├── location_service.dart
│   ├── notification_service.dart
│   └── payment_service.dart
├── screens/
│   ├── auth/
│   │   ├── splash_screen.dart
│   │   ├── login_screen.dart
│   │   ├── register_screen.dart
│   │   ├── forgot_password_screen.dart
│   │   └── reset_password_screen.dart
│   ├── home/
│   │   ├── main_navigation.dart
│   │   ├── home_screen.dart
│   │   ├── categories_screen.dart
│   │   ├── search_screen.dart
│   │   └── map_screen.dart
│   ├── product/
│   │   ├── products_screen.dart
│   │   ├── product_detail_screen.dart
│   │   ├── add_product_screen.dart
│   │   ├── my_products_screen.dart
│   │   ├── offers_screen.dart
│   │   ├── auctions_screen.dart
│   │   └── report_product_screen.dart
│   ├── wallet/
│   │   ├── wallet_screen.dart
│   │   ├── deposit_screen.dart
│   │   ├── transfer_screen.dart
│   │   ├── withdraw_screen.dart
│   │   ├── payments_screen.dart
│   │   ├── transactions_screen.dart
│   │   ├── transfer_network_screen.dart
│   │   ├── entertainment_services_screen.dart
│   │   ├── games_screen.dart
│   │   ├── apps_screen.dart
│   │   ├── gift_cards_screen.dart
│   │   ├── amazon_gift_cards_screen.dart
│   │   ├── banks_wallets_screen.dart
│   │   ├── money_transfers_screen.dart
│   │   ├── government_payments_screen.dart
│   │   ├── jib_screen.dart
│   │   ├── cash_withdrawal_screen.dart
│   │   ├── universities_screen.dart
│   │   ├── recharge_payment_screen.dart
│   │   ├── recharge_credit_screen.dart
│   │   ├── pay_bundles_screen.dart
│   │   ├── internet_landline_screen.dart
│   │   └── receive_transfer_request_screen.dart
│   ├── chat/
│   │   ├── chat_screen.dart
│   │   └── chat_detail_screen.dart
│   ├── order/
│   │   ├── cart_screen.dart
│   │   ├── checkout_screen.dart
│   │   ├── my_orders_screen.dart
│   │   └── order_detail_screen.dart
│   ├── profile/
│   │   ├── profile_screen.dart
│   │   ├── account_info_screen.dart
│   │   ├── favorites_screen.dart
│   │   ├── following_screen.dart
│   │   └── product_review_screen.dart
│   ├── seller/
│   │   ├── seller_profile_screen.dart
│   │   └── seller_dashboard.dart
│   ├── support/
│   │   ├── live_support_screen.dart
│   │   ├── faq_screen.dart
│   │   ├── contact_us_screen.dart
│   │   └── support_tickets_screen.dart
│   ├── notifications/
│   │   └── notifications_screen.dart
│   └── settings/
│       ├── settings_screen.dart
│       ├── notifications_settings_screen.dart
│       ├── security_settings_screen.dart
│       ├── language_screen.dart
│       ├── payment_methods_screen.dart
│       ├── about_screen.dart
│       ├── privacy_policy_screen.dart
│       └── help_support_screen.dart
├── theme/
│   └── app_theme.dart
├── widgets/
│   ├── common/
│   │   ├── custom_app_bar.dart
│   │   ├── custom_button.dart
│   │   ├── custom_text_field.dart
│   │   ├── loading_widget.dart
│   │   └── empty_state.dart
│   ├── cards/
│   │   ├── product_card.dart
│   │   ├── ad_card.dart
│   │   ├── order_card.dart
│   │   └── chat_card.dart
│   └── dialogs/
│       ├── confirmation_dialog.dart
│       ├── success_dialog.dart
│       └── error_dialog.dart
└── routes/
    └── app_routes.dart
```

## التثبيت والتشغيل

### المتطلبات
- Flutter SDK >= 3.0.0
- Dart SDK >= 3.0.0
- Android Studio / Xcode

### خطوات التثبيت

1. استنساخ المستودع:
```bash
git clone https://github.com/yourusername/flex_yemen.git
cd flex_yemen
```

2. تثبيت الحزم:
```bash
flutter pub get
```

3. تشغيل التطبيق:
```bash
flutter run
```

### بناء APK
```bash
flutter build apk --release
```

### بناء AAB
```bash
flutter build appbundle --release
```

## الإعدادات

### Supabase
1. أنشئ مشروع على Supabase
2. أضف الجداول المطلوبة (users, products, orders, etc.)
3. انسخ مفاتيح API إلى ملف `.env`

### Firebase
1. أنشئ مشروع على Firebase
2. فعل Cloud Messaging
3. حمل ملف `google-services.json` إلى `android/app/`

## التقنيات المستخدمة

- **Flutter**: إطار العمل الرئيسي
- **Dart**: لغة البرمجة
- **Provider**: إدارة الحالة
- **Supabase**: قاعدة البيانات والمصادقة
- **Hive**: التخزين المحلي
- **Flutter Animate**: التأثيرات الحركية
- **Google Maps**: الخرائط والموقع

## المساهمة

نرحب بمساهماتكم! يرجى اتباع الخطوات التالية:

1. Fork المستودع
2. أنشئ فرعاً جديداً (`git checkout -b feature/amazing-feature`)
3. Commit التغييرات (`git commit -m 'Add amazing feature'`)
4. Push إلى الفرع (`git push origin feature/amazing-feature`)
5. افتح Pull Request

## الترخيص

هذا المشروع مرخص بموجب [MIT License](LICENSE).

## التواصل

- البريد الإلكتروني: support@flexyemen.com
- الموقع: https://flexyemen.com
- فيسبوك: https://facebook.com/flexyemen
- تويتر: https://twitter.com/flexyemen

---

**Flex Yemen - نفخر بأننا يمنيون 🇾🇪**
# Kimi_Gama
