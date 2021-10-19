import 'package:emarsys_sdk/model/predict/cart_item.dart';
import 'package:emarsys_sdk/model/predict/predict_cart_item.dart';
import 'package:emarsys_sdk/model/predict/recommendation_logic.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {});

  test(
      'search should create RecommendationLogic with empty data when no searchTerm provided',
      () async {
    RecommendationLogic result = RecommendationLogic.search();

    expect(result.name, "SEARCH");
    expect(result.data.isEmpty, true);
  });
  test('search should create RecommendationLogic with searchTerm', () async {
    RecommendationLogic result =
        RecommendationLogic.search(searchTerm: "testSearchTerm");

    expect(result.name, "SEARCH");
    expect(result.data["searchTerm"], "testSearchTerm");
  });

  test(
      'cart should create RecommendationLogic with empty data when no cartItems provided',
      () async {
    RecommendationLogic result = RecommendationLogic.cart();

    expect(result.name, "CART");
    expect(result.data.isEmpty, true);
  });

  test(
      'cart should create RecommendationLogic with cartItem data when cartItems are provided',
      () async {
    CartItem cartItem1 =
        new PredictCartItem(itemId: "item1", price: 12, quantity: 24);
    CartItem cartItem2 =
        new PredictCartItem(itemId: "item2", price: 23, quantity: 33);
    List<CartItem> items = [cartItem1, cartItem2];
    RecommendationLogic result = RecommendationLogic.cart(cartItems: items);

    expect(result.name, "CART");
    expect(result.data["cartItems"], items);
  });

  test(
      'related should create RecommendationLogic with empty data when no itemId provided',
      () async {
    RecommendationLogic result = RecommendationLogic.related();

    expect(result.name, "RELATED");
    expect(result.data.isEmpty, true);
  });
  test('related should create RecommendationLogic with itemId', () async {
    RecommendationLogic result =
        RecommendationLogic.related(itemId: "testItemId");

    expect(result.name, "RELATED");
    expect(result.data["itemId"], "testItemId");
  });

  test(
      'category should create RecommendationLogic with empty data when no categoryPath provided',
      () async {
    RecommendationLogic result = RecommendationLogic.category();

    expect(result.name, "CATEGORY");
    expect(result.data.isEmpty, true);
  });
  test('category should create RecommendationLogic with categoryPath',
      () async {
    RecommendationLogic result =
        RecommendationLogic.category(categoryPath: "testCategoryPath");

    expect(result.name, "CATEGORY");
    expect(result.data["categoryPath"], "testCategoryPath");
  });

  test(
      'alsoBought should create RecommendationLogic with empty data when no itemId provided',
      () async {
    RecommendationLogic result = RecommendationLogic.alsoBought();

    expect(result.name, "ALSO_BOUGHT");
    expect(result.data.isEmpty, true);
  });

  test('alsoBought should create RecommendationLogic with itemId', () async {
    RecommendationLogic result =
        RecommendationLogic.alsoBought(itemId: "testItemId");

    expect(result.name, "ALSO_BOUGHT");
    expect(result.data["itemId"], "testItemId");
  });

  test(
      'popular should create RecommendationLogic with empty data when no categoryPath provided',
      () async {
    RecommendationLogic result = RecommendationLogic.popular();

    expect(result.name, "POPULAR");
    expect(result.data.isEmpty, true);
  });
  test('popular should create RecommendationLogic with categoryPath', () async {
    RecommendationLogic result =
        RecommendationLogic.popular(categoryPath: "testCategoryPath");

    expect(result.name, "POPULAR");
    expect(result.data["categoryPath"], "testCategoryPath");
  });

  test(
      'personal should create RecommendationLogic with empty variants, when no variant provided',
      () async {
    RecommendationLogic result = RecommendationLogic.personal();

    expect(result.name, "PERSONAL");
    expect(result.data.isEmpty, true);
    expect(result.variants.length, 0);
  });

  test('personal should create RecommendationLogic with variants', () async {
    List<String> variants = ["variant1", "variant2"];
    RecommendationLogic result =
        RecommendationLogic.personal(variants: variants);

    expect(result.name, "PERSONAL");
    expect(result.variants, variants);
  });

  test(
      'home should create RecommendationLogic with empty variants, when no variant provided',
      () async {
    RecommendationLogic result = RecommendationLogic.home();

    expect(result.name, "HOME");
    expect(result.data.isEmpty, true);
    expect(result.variants.length, 0);
  });

  test('home should create RecommendationLogic with variants', () async {
    List<String> variants = ["variant1", "variant2"];
    RecommendationLogic result = RecommendationLogic.home(variants: variants);

    expect(result.name, "HOME");
    expect(result.variants, variants);
  });
}
