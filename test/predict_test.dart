import 'package:emarsys_sdk/emarsys_sdk.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const MethodChannel channel = MethodChannel('com.emarsys.methods');

  TestWidgetsFlutterBinding.ensureInitialized();

  test('trackItemView should delegate to the Platform with correct parameters',
      () async {
    const itemId = "testItemId";
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      expect(methodCall.method, 'predict.trackItemView');
      expect(methodCall.arguments, {"itemId": itemId});
      return null;
    });

    await Emarsys.predict.trackItemView(itemId);
  });

  test('trackItemView should throw error', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
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
    const searchTerm = "testSearchTerm";
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      expect(methodCall.method, 'predict.trackSearchTerm');
      expect(methodCall.arguments, {"searchTerm": searchTerm});
      return null;
    });

    await Emarsys.predict.trackSearchTerm(searchTerm);
  });

  test(
      'trackCategoryView should delegate to the Platform with correct parameters',
      () async {
    const categoryPath = "testCategoryPath";
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      expect(methodCall.method, 'predict.trackCategoryView');
      expect(methodCall.arguments, {"categoryPath": categoryPath});
      return null;
    });

    await Emarsys.predict.trackCategoryView(categoryPath);
  });

  test('trackTag should delegate to the Platform with correct parameters',
      () async {
    const eventName = "eventName";
    Map<String, String> attributes = {"testKey": "testValue"};
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      expect(methodCall.method, 'predict.trackTag');
      expect(methodCall.arguments,
          {"eventName": eventName, "attributes": attributes});
      return null;
    });

    await Emarsys.predict.trackTag(eventName, attributes);
  });

  test('trackCartItem should delegate to the Platform with correct parameters',
      () async {
    final cartItems = [
      TestCartItem("item1", 0.0, 0.0),
      TestCartItem("item2", 0.5, 1.0)
    ];
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      expect(methodCall.method, 'predict.trackCart');
      expect(methodCall.arguments, {
        "items": [
          {"itemId": "item1", "price": 0.0, "quantity": 0.0},
          {"itemId": "item2", "price": 0.5, "quantity": 1.0}
        ]
      });
      return null;
    });

    await Emarsys.predict.trackCart(cartItems);
  });

  test('trackPurchase should delegate to the Platform with correct parameters',
      () async {
    const orderId = 'testOrderId';
    final items = [
      TestCartItem("item1", 0.0, 0.0),
      TestCartItem("item2", 0.5, 1.0)
    ];
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      expect(methodCall.method, 'predict.trackPurchase');
      expect(methodCall.arguments, {
        "orderId": "testOrderId",
        "items": [
          {"itemId": "item1", "price": 0.0, "quantity": 0.0},
          {"itemId": "item2", "price": 0.5, "quantity": 1.0}
        ]
      });
      return null;
    });

    await Emarsys.predict.trackPurchase(orderId, items);
  });

  test('trackPurchase should throw exception when items is an empty list',
      () async {
    const orderId = 'testOrderId';
    final List<TestCartItem> items = [];
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      throw PlatformException(
          code: '42', message: 'Items list should not be empty!');
    });

    expect(
        Emarsys.predict.trackPurchase(orderId, items),
        throwsA(isA<PlatformException>().having((error) => error.message,
            'message', 'Items list should not be empty!')));
  });

  test('recommendProducts with only Logic should delegate to the Platform',
      () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      expect(methodCall.arguments["logic"],
          {"name": "SEARCH", "data": {}, "variants": []});
      expect(methodCall.arguments["limit"], null);
      expect(methodCall.arguments["recommendationFilter"], null);
      expect(methodCall.arguments["availabilityZone"], null);
      expect(methodCall.method, 'predict.recommendProducts');
      return [<String, dynamic>{}];
    });

    Logic recommendationLogic = RecommendationLogic.search();
    await Emarsys.predict.recommendProducts(logic: recommendationLogic);
  });

  test('recommendProducts with all properties should delegate to the Platform',
      () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      expect(methodCall.arguments["logic"],
          {"name": "SEARCH", "data": {}, "variants": []});

      expect(methodCall.arguments["recommendationFilter"], [
        {
          "filterType": "EXCLUDE",
          "field": "testField",
          "comparison": "IS",
          "values": ["testValue"]
        }
      ]);
      expect(methodCall.arguments["limit"], 5);
      expect(methodCall.arguments["availabilityZone"], "HU");
      expect(methodCall.method, 'predict.recommendProducts');
      return [<String, dynamic>{}];
    });

    Logic recommendationLogic = RecommendationLogic.search();
    var recommendationFilter =
        RecommendationFilter.exclude("testField").isValue("testValue");
    await Emarsys.predict.recommendProducts(
        logic: recommendationLogic,
        filters: [recommendationFilter],
        limit: 5,
        availabilityZone: "HU");
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
      : itemId = itemId2,
        price = price2,
        quantity = quantity2;
}
