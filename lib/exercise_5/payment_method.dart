enum PaymentErrorType {
  userCanceled,
  insufficientBalance,
  unknown;
}

class PaymentException implements Exception {
  final PaymentErrorType errorType;
  final String message;

  PaymentException(this.errorType, this.message);
}

abstract class PaymentGateway {
  Future<void> processPayment(double amount);

  Future<bool> verifyPayment(String transactionId) async {
    try {
      // Fake API Call to backend for verification
      return true;
    } catch (e) {
      throw "throw a PaymentException";
    }
  }
}

class StripePayment extends PaymentGateway {
  @override
  Future<void> processPayment(double amount) async {
    try {
      // Call Stripe API
      await verifyPayment("stripe_transaction_id");
    } catch (e) {
      // throw a PaymentException;
    }
  }
}

class PayPalPayment extends PaymentGateway {
  @override
  Future<void> processPayment(double amount) async {
    try {
      // Call PayPal API
      await verifyPayment("paypal_transaction_id");
    } catch (e) {
      throw PaymentException(
          PaymentErrorType.insufficientBalance, "PayPal Payment Failed: $e");
    }
  }
}

enum PaymentMethod {
  stripe,
  paypal;
}

class PaymentFactory {
  static PaymentGateway create(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.stripe:
        return StripePayment();
      case PaymentMethod.paypal:
        return PayPalPayment();
    }
  }
}

void onProcessPayment(PaymentMethod method) async {
  final paymentGateway = PaymentFactory.create(method);
  try {
    await paymentGateway.processPayment(100);
    showSuccess();
  } on PaymentException catch (e) {
    if (e.errorType == PaymentErrorType.userCanceled) {
      // showToast("Payment was canceled by user.");
    } else if (e.errorType == PaymentErrorType.insufficientBalance) {
      // showError("Network issue, please try again.");
    } else {
      // showError(e.message);
    }
  }
}

void showSuccess() {}
