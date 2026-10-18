import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class SubscriptionPurchaseErrorService {
  const SubscriptionPurchaseErrorService._();

  static bool isCancelled(Object error) {
    if (error is PlatformException) {
      final details = error.details;
      if (details is Map) {
        final userCancelled = details['userCancelled'];
        final readableCode =
            details['readable_error_code'] ?? details['readableErrorCode'];
        if (userCancelled == true) return true;
        if (readableCode == 'PURCHASE_CANCELLED') return true;
      }
    }

    if (error is PurchasesErrorCode) {
      return error == PurchasesErrorCode.purchaseCancelledError;
    }

    final message = error.toString();
    return message.contains('PURCHASE_CANCELLED') ||
        message.contains('userCancelled: true') ||
        message.contains('purchaseCancelledError');
  }
}
