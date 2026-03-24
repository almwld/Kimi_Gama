import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flex_yemen/core/constants/app_constants.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();

  // التحقق من تفعيل خدمة الموقع
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  // التحقق من صلاحيات الموقع
  Future<LocationPermission> checkPermission() async {
    return await Geolocator.checkPermission();
  }

  // طلب صلاحيات الموقع
  Future<LocationPermission> requestPermission() async {
    return await Geolocator.requestPermission();
  }

  // الحصول على الموقع الحالي
  Future<Position?> getCurrentLocation() async {
    try {
      // التحقق من تفعيل خدمة الموقع
      bool serviceEnabled = await isLocationServiceEnabled();
      if (!serviceEnabled) {
        return null;
      }

      // التحقق من الصلاحيات
      LocationPermission permission = await checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await requestPermission();
        if (permission == LocationPermission.denied) {
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return null;
      }

      // الحصول على الموقع
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      print('Error getting location: $e');
      return null;
    }
  }

  // الحصول على آخر موقع معروف
  Future<Position?> getLastKnownLocation() async {
    try {
      return await Geolocator.getLastKnownPosition();
    } catch (e) {
      print('Error getting last known location: $e');
      return null;
    }
  }

  // متابعة تغيرات الموقع
  Stream<Position> getPositionStream({
    LocationAccuracy accuracy = LocationAccuracy.high,
    int distanceFilter = 10,
  }) {
    return Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: accuracy,
        distanceFilter: distanceFilter,
      ),
    );
  }

  // تحويل الإحداثيات إلى عنوان
  Future<String?> getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return '${place.street}, ${place.subLocality}, ${place.locality}, ${place.country}';
      }
      return null;
    } catch (e) {
      print('Error getting address: $e');
      return null;
    }
  }

  // تحويل عنوان إلى إحداثيات
  Future<Map<String, double>?> getLatLngFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);

      if (locations.isNotEmpty) {
        Location location = locations[0];
        return {
          'latitude': location.latitude,
          'longitude': location.longitude,
        };
      }
      return null;
    } catch (e) {
      print('Error getting coordinates: $e');
      return null;
    }
  }

  // حساب المسافة بين نقطتين
  double calculateDistance(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    return Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }

  // حساب المسافة بالكيلومتر
  double calculateDistanceInKm(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    return calculateDistance(
          startLatitude,
          startLongitude,
          endLatitude,
          endLongitude,
        ) /
        1000;
  }

  // فتح خرائط Google
  Future<void> openGoogleMaps(
    double latitude,
    double longitude, {
    String? label,
  }) async {
    final url = label != null
        ? 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude&query_place_id=$label'
        : 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    
    // يمكن استخدام url_launcher هنا
    // await launchUrl(Uri.parse(url));
  }

  // الحصول على أقرب مدينة
  String? getNearestCity(double latitude, double longitude) {
    String? nearestCity;
    double minDistance = double.infinity;

    for (var city in AppConstants.yemeniCities) {
      double distance = calculateDistance(
        latitude,
        longitude,
        city['lat'] as double,
        city['lng'] as double,
      );

      if (distance < minDistance) {
        minDistance = distance;
        nearestCity = city['id'] as String;
      }
    }

    return nearestCity;
  }

  // التحقق من وجود المستخدم داخل نطاق معين
  bool isWithinRadius(
    double centerLatitude,
    double centerLongitude,
    double userLatitude,
    double userLongitude,
    double radiusInKm,
  ) {
    double distance = calculateDistanceInKm(
      centerLatitude,
      centerLongitude,
      userLatitude,
      userLongitude,
    );
    return distance <= radiusInKm;
  }

  // الحصول على إحداثيات المدينة
  Map<String, double>? getCityCoordinates(String cityId) {
    final city = AppConstants.yemeniCities.firstWhere(
      (c) => c['id'] == cityId,
      orElse: () => {},
    );

    if (city.isEmpty) return null;

    return {
      'latitude': city['lat'] as double,
      'longitude': city['lng'] as double,
    };
  }
}
