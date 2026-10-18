import 'package:notch_app/features/feature/premium/models/subscription_plan.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class SubscriptionRuntimeState {
  bool initialized = false;
  bool isConfigured = false;
  bool customerInfoListenerAttached = false;
  bool isPremium = false;
  bool isStoreAvailable = false;
  bool isLoadingProducts = false;
  bool isPurchaseInProgress = false;
  String? lastError;
  List<SubscriptionPlan> plans = const [];
  final Map<String, Package> packageByProductId = {};
}
