import 'package:emarsys_sdk/emarsys_sdk.dart';
import 'package:emarsys_sdk/mappers/cart_item_list_mapper.dart';
import 'package:emarsys_sdk/mappers/logic_mapper.dart';
import 'package:emarsys_sdk/model/predict/predict_cart_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final LogicMapper mapper = LogicMapper(CartItemListMapper());

  test('map with search logic should return a map with correct name and data', () async {
    final Logic testLogic = RecommendationLogic.search(searchTerm: "abc123");
    final Map<String, dynamic> result = mapper.map(testLogic);

    expect(result["name"], "SEARCH");
    expect(result["data"]["searchTerm"], "abc123");
  });

  test('map with cart logic should return a map with correct name and data', () async {
    List<CartItem> testItems = [
      PredictCartItem(itemId: "id1", price: 1, quantity: 1),
      PredictCartItem(itemId: "id2", price: 2, quantity: 2)
    ];

    final Logic testLogic = RecommendationLogic.cart(cartItems: testItems);
    final Map<String, dynamic> result = mapper.map(testLogic);

    expect(result["name"], "CART");
    expect(result["data"]["cartItems"][0]["itemId"], "id1");
    expect(result["data"]["cartItems"][0]["price"], 1);
    expect(result["data"]["cartItems"][0]["quantity"], 1);
    expect(result["data"]["cartItems"][1]["itemId"], "id2");
    expect(result["data"]["cartItems"][1]["price"], 2);
    expect(result["data"]["cartItems"][1]["quantity"], 2);
  });

  test('map with category logic should return a map with correct name and data', () async {
    final Logic testLogic =
        RecommendationLogic.category(categoryPath: "abc123");
    final Map<String, dynamic> result = mapper.map(testLogic);

    expect(result["name"], "CATEGORY");
    expect(result["data"]["categoryPath"], "abc123");
  });

  test('map with alsoBought logic should return a map with correct name and data',
      () async {
    final Logic testLogic = RecommendationLogic.alsoBought(itemId: "abc123");
    final Map<String, dynamic> result = mapper.map(testLogic);

    expect(result["name"], "ALSO_BOUGHT");
    expect(result["data"]["itemId"], "abc123");
  });

  test('map with popular logic should return a map with correct name and data', () async {
    final Logic testLogic = RecommendationLogic.popular(categoryPath: "abc123");
    final Map<String, dynamic> result = mapper.map(testLogic);

    expect(result["name"], "POPULAR");
    expect(result["data"]["categoryPath"], "abc123");
  });

  test('map with related logic should return a map with correct name and data', () async {
    final Logic testLogic = RecommendationLogic.related(itemId: "abc123");
    final Map<String, dynamic> result = mapper.map(testLogic);

    expect(result["name"], "RELATED");
    expect(result["data"]["itemId"], "abc123");
  });

  test('map with personal logic should return a map with correct name and variants',
      () async {
    final Logic testLogic =
        RecommendationLogic.personal(variants: ["variant1", "variant2"]);
    final Map<String, dynamic> result = mapper.map(testLogic);

    expect(result["name"], "PERSONAL");
    expect(result["variants"], ["variant1", "variant2"]);
  });

  test('map with home logic should return a map with correct name and variants', () async {
    final Logic testLogic =
        RecommendationLogic.home(variants: ["variant1", "variant2"]);
    final Map<String, dynamic> result = mapper.map(testLogic);

    expect(result["name"], "HOME");
    expect(result["variants"], ["variant1", "variant2"]);
  });
}
