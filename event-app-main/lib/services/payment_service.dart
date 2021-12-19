import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stripe_payment/stripe_payment.dart';

class StripeTranSection {
  String message;
  bool success;
  String transectionId;

  StripeTranSection(
      {this.message = "", this.success = false, this.transectionId = ""});
}

class PaymentServices {
  static String secret =
      "sk_test_51JRVfULnAQYBCd6dHplAEoih5Cs54AveFjsf8rsstkKwDFo5ln0S6BnFFPsp0m1EfCtFxvpJqQkjyKR3fiRXerP900TdwQlemR";
  static String publicKey =
      "pk_test_51JRVfULnAQYBCd6dTRUYOARtyQhe5FtFtX6K0RdrYOtqotvTQk0JKEFGVG6t0UWCX5sxMuQNqbenqACAhSxqoKA200HGitacAT";

  static Map<String, String> headers = {
    'Authorization': "Bearer ${PaymentServices.secret}",
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  static init() {
    StripePayment.setOptions(StripeOptions(
        publishableKey: publicKey, merchantId: "Test", androidPayMode: 'test'));
  }

  static payViaExistingCard(String amount, String currency, card) {
    return StripeTranSection(message: "successFull", success: true);
  }

  static Future<StripeTranSection> payViaAndroid(
      String amount, String currency) async {
    try {
      var result = await StripePayment.paymentRequestWithNativePay(
        androidPayOptions: AndroidPayPaymentRequest(
          totalPrice: amount,
          currencyCode: currency,
        ),
        applePayOptions: ApplePayPaymentOptions(),
      );
      var paymentIntent =
          await PaymentServices.createPaymentIntent(amount, currency);

      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
          clientSecret: paymentIntent['client_secret'],
          paymentMethodId: result.tokenId));
      if (response.status == "succeeded") {
        return StripeTranSection(
            message: "Transaction Successful",
            transectionId: paymentIntent["id"],
            success: true);
      } else {
        return StripeTranSection(message: "failed", success: false);
      }
    } catch (e) {
      print(e.toString());
      return StripeTranSection(message: "failed", success: false);
    }
  }

  static Future<StripeTranSection> payViaIOS(
      String amount, String currency) async {
    try {
      var result = await StripePayment.paymentRequestWithNativePay(
        applePayOptions: ApplePayPaymentOptions(
          countryCode: 'US',
          currencyCode: currency,
          items: [
            ApplePayItem(
              label: 'Test',
              amount: amount,
            )
          ],
        ),
        androidPayOptions:
            AndroidPayPaymentRequest(currencyCode: "pkr", totalPrice: "50"),
      );
      var paymentIntent =
          await PaymentServices.createPaymentIntent(amount, currency);
      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
          clientSecret: paymentIntent['client_secret'],
          paymentMethodId: result.tokenId));
      if (response.status == "succeeded") {
        return StripeTranSection(
            message: "Transaction Successful",
            transectionId: paymentIntent["id"],
            success: true);
      } else {
        return StripeTranSection(message: "failed", success: false);
      }
    } catch (e) {
      print(e.toString());
      return StripeTranSection(message: "failed", success: false);
    }
  }

  static Future<StripeTranSection> payViaNewCard(
      String amount, String currency) async {
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());
      print(paymentMethod.customerId);
      var paymentIntent =
          await PaymentServices.createPaymentIntent(amount, currency);
      print(paymentIntent['client_secret']);
      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
          clientSecret: paymentIntent['client_secret'],
          paymentMethodId: paymentMethod.id));
      print(response);
      if (response.status == "succeeded") {
        return StripeTranSection(
            message: "Transaction Successful",
            transectionId: paymentIntent["id"],
            success: true);
      } else {
        return StripeTranSection(message: "failed", success: false);
      }
    } catch (e) {
      print(e.toString());
      return StripeTranSection(message: "Transaction Failed", success: false);
    }
  }

  static Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        // "payment_method_types[]": 'card',
      };

      var response = await http.post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: body,
          headers: {
            'Authorization': "Bearer ${PaymentServices.secret}",
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } catch (e) {
      print(e.toString());
      return {};
    }
  }
}
