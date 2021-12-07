import 'package:emarsys_sdk/emarsys_sdk.dart';
import 'package:emarsys_sdk/model/predict/cart_item.dart';
import 'package:emarsys_sdk/model/predict/logic.dart';
import 'package:emarsys_sdk/model/predict/recommendation_logic.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:emarsys_sdk/api/emarsys.dart';

void main() {
  const MethodChannel channel = MethodChannel('com.emarsys.methods');

  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return null;
    });
  });

  test('trackItemView should delegate to the Platform with correct parameters',
      () async {
    final itemId = "testItemId";
    MethodCall? actualMethodCall;
    channel.setMockMethodCallHandler((MethodCall methodCall) {
      actualMethodCall = methodCall;
    });

    await Emarsys.predict.trackItemView(itemId);
    expect(actualMethodCall != null, true);
    if (actualMethodCall != null) {
      expect(actualMethodCall!.method, 'predict.trackItemView');
      expect(actualMethodCall!.arguments, {"itemId": itemId});
    }
  });

  test('trackItemView should throw error', () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      throw PlatformException(
          code: '42',
          message: 'Test error message',
          details: 'Test detail',
          stacktrace: 'Test stacktrace');
    });

    expect(
        Emarsys.predict.trackItemView("testItemId"),
        throwsA(isA<PlatformException>().having(
            (error) => error.message, 'message', 'Test error message')));
  });

  test(
      'trackSearchTerm should delegate to the Platform with correct parameters',
      () async {
    final searchTerm = "testSearchTerm";
    MethodCall? actualMethodCall;
    channel.setMockMethodCallHandler((MethodCall methodCall) {
      actualMethodCall = methodCall;
    });
    await Emarsys.predict.trackSearchTerm(searchTerm);

    expect(actualMethodCall != null, true);
    if (actualMethodCall != null) {
      expect(actualMethodCall!.method, 'predict.trackSearchTerm');
      expect(actualMethodCall!.arguments, {"searchTerm": searchTerm});
    }
  });

  test(
      'trackCategoryView should delegate to the Platform with correct parameters',
      () async {
    final categoryPath = "testCategoryPath";
    MethodCall? actualMethodCall;
    channel.setMockMethodCallHandler((MethodCall methodCall) {
      actualMethodCall = methodCall;
    });
    await Emarsys.predict.trackCategoryView(categoryPath);

    expect(actualMethodCall != null, true);
    if (actualMethodCall != null) {
      expect(actualMethodCall!.method, 'predict.trackCategoryView');
      expect(actualMethodCall!.arguments, {"categoryPath": categoryPath});
    }
  });
  test('trackTag should delegate to the Platform with correct parameters',
      () async {
    final eventName = "eventName";
    Map<String, String> attributes = {"testKey": "testValue"};
    MethodCall? actualMethodCall;
    channel.setMockMethodCallHandler((MethodCall methodCall) {
      actualMethodCall = methodCall;
    });
    await Emarsys.predict.trackTag(eventName, attributes);

    expect(actualMethodCall != null, true);
    if (actualMethodCall != null) {
      expect(actualMethodCall!.method, 'predict.trackTag');
      expect(actualMethodCall!.arguments,
          {"eventName": eventName, "attributes": attributes});
    }
  });

  test('trackCartItem should delegate to the Platform with correct parameters',
      () async {
    final cartItems = [
      TestCartItem("item1", 0.0, 0.0),
      TestCartItem("item2", 0.5, 1.0)
    ];
    MethodCall? actualMethodCall;
    channel.setMockMethodCallHandler((MethodCall methodCall) {
      actualMethodCall = methodCall;
    });
    await Emarsys.predict.trackCart(cartItems);

    expect(actualMethodCall != null, true);
    if (actualMethodCall != null) {
      expect(actualMethodCall!.method, 'predict.trackCart');
      expect(actualMethodCall!.arguments, {
        "items": [
          {"itemId": "item1", "price": 0.0, "quantity": 0.0},
          {"itemId": "item2", "price": 0.5, "quantity": 1.0}
        ]
      });
    }
  });

  test('trackPurchase should delegate to the Platform with correct parameters',
      () async {
    final orderId = 'testOrderId';
    final items = [
      TestCartItem("item1", 0.0, 0.0),
      TestCartItem("item2", 0.5, 1.0)
    ];
    MethodCall? actualMethodCall;
    channel.setMockMethodCallHandler((MethodCall methodCall) {
      actualMethodCall = methodCall;
    });
    await Emarsys.predict.trackPurchase(orderId, items);

    expect(actualMethodCall != null, true);
    if (actualMethodCall != null) {
      expect(actualMethodCall!.method, 'predict.trackPurchase');
      expect(actualMethodCall!.arguments, {
        "orderId": "testOrderId",
        "items": [
          {"itemId": "item1", "price": 0.0, "quantity": 0.0},
          {"itemId": "item2", "price": 0.5, "quantity": 1.0}
        ]
      });
    }
  });

  test('trackPurchase should throw exception when items is an empty list',
      () async {
    final orderId = 'testOrderId';
    final List<TestCartItem> items = [];
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      throw PlatformException(
          code: '42',
          message: 'Items list should not be empty!'
        );
    });

    expect(
        Emarsys.predict.trackPurchase(orderId, items),
        throwsA(isA<PlatformException>().having(
            (error) => error.message, 'message', 'Items list should not be empty!')));
  });

  test('recommendProducts with only Logic should delegate to the Platform',
      () async {
    MethodCall? actualMethodCall;
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      actualMethodCall = methodCall;
      final map = <String, dynamic>{};
      return [map];
    });

    Logic recommendationLogic = RecommendationLogic.search();
    await Emarsys.predict.recommendProducts(logic: recommendationLogic);

    expect(actualMethodCall != null, true);
    if (actualMethodCall != null) {
      expect(actualMethodCall!.arguments["logic"],
          {"name": "SEARCH", "data": {}, "variants": []});
      expect(actualMethodCall!.arguments["recommendationFilter"], null);
      expect(actualMethodCall!.arguments["limit"], null);
      expect(actualMethodCall!.arguments["availabilityZone"], null);
      expect(actualMethodCall!.method, 'predict.recommendProducts');
    }
  });

  test('recommendProducts with all properties should delegate to the Platform',
      () async {
    MethodCall? actualMethodCall;
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      actualMethodCall = methodCall;
      final map = <String, dynamic>{};
      return [map];
    });

    Logic recommendationLogic = RecommendationLogic.search();
    var recommendationFilter =
        RecommendationFilter.exclude("testField").isValue("testValue");
    await Emarsys.predict.recommendProducts(
        logic: recommendationLogic,
        filters: [recommendationFilter],
        limit: 5,
        availabilityZone: "HU");

    expect(actualMethodCall != null, true);
    if (actualMethodCall != null) {
      expect(actualMethodCall!.arguments["logic"],
          {"name": "SEARCH", "data": {}, "variants": []});

      expect(actualMethodCall!.arguments["recommendationFilter"], [
        {
          "filterType": "EXCLUDE",
          "field": "testField",
          "comparison": "IS",
          "values": ["testValue"]
        }
      ]);
      expect(actualMethodCall!.arguments["limit"], 5);
      expect(actualMethodCall!.arguments["availabilityZone"], "HU");
      expect(actualMethodCall!.method, 'predict.recommendProducts');
    }
  });
}

class TestCartItem implements CartItem {
  @override
  String itemId;
  @override
  double price;
  @override
  double quantity;
  TestCartItem(String itemId2, double price2, double quantity2)
      : this.itemId = itemId2,
        this.price = price2,
        this.quantity = quantity2;
}
