import 'package:in_app_purchase/in_app_purchase.dart';

class PurchaseService {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  Future<void> init() async {
    final available = await _inAppPurchase.isAvailable();
    if (!available) {
      throw Exception("In-app purchases not available.");
    }
  }

  Future<void> buyPremium() async {
    // Trigger purchase flow
  }

  Future<bool> isPremiumUser() async {
    // Check subscription/purchase status
    return false;
  }
}
