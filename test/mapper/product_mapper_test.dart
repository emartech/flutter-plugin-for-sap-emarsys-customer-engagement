import 'package:emarsys_sdk/emarsys_sdk.dart';
import 'package:emarsys_sdk/mappers/product_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final ProductMapper mapper = ProductMapper();

  test('map should not crash when inputList is empty', () async {
    final List<Map<String, dynamic>> emptyList = [];
    final List<Product> result = mapper.map(emptyList);

    expect(result.length, 0);
  });

  test('map should return with correct result', () async {
    final List<Map<String, dynamic>> input = [
      {
        "productId": "test_productId",
        "title": "test_title",
        "linkUrlString": "test_link",
        "feature": "test_feature",
        "cohort": "test_cohort",
        "customFields": {"field1": "value1", "field2": "value2"},
        "imageUrlString": "test_imageUrlString",
        "zoomImageUrlString": "test_zoomImageUrlString",
        "categoryPath": "test_categoryPath",
        "available": true,
        "productDescription": "test_productDescription",
        "price": 12.3,
        "msrp": 45.6,
        "album": "test_album",
        "actor": "test_actor",
        "artist": "test_artist",
        "author": "test_author",
        "brand": "test_brand",
        "year": 1990
      },
      {
        "productId": "test_productId2",
        "title": "test_title2",
        "linkUrlString": "test_link2",
        "feature": "test_feature2",
        "cohort": "test_cohort2",
        "customFields": {"field3": "value3", "field4": "value4"},
        "imageUrlString": "test_imageUrlString2",
        "zoomImageUrlString": "test_zoomImageUrlString2",
        "categoryPath": "test_categoryPath2",
        "available": false,
        "productDescription": "test_productDescription2",
        "price": 45.6,
        "msrp": 78.9,
        "album": "test_album2",
        "actor": "test_actor2",
        "artist": "test_artist2",
        "author": "test_author2",
        "brand": "test_brand2",
        "year": 2000
      }
    ];

    Product prod1 = Product(
        productId: "test_productId",
        title: "test_title",
        linkUrlString: "test_link",
        feature: "test_feature",
        cohort: "test_cohort",
        customFields: {"field1": "value1", "field2": "value2"},
        imageUrlString: "test_imageUrlString",
        zoomImageUrlString: "test_zoomImageUrlString",
        categoryPath: "test_categoryPath",
        available: true,
        productDescription: "test_productDescription",
        price: 12.3,
        msrp: 45.6,
        album: "test_album",
        actor: "test_actor",
        artist: "test_artist",
        author: "test_author",
        brand: "test_brand",
        year: 1990);
    Product prod2 = Product(
        productId: "test_productId2",
        title: "test_title2",
        linkUrlString: "test_link2",
        feature: "test_feature2",
        cohort: "test_cohort2",
        customFields: {"field3": "value3", "field4": "value4"},
        imageUrlString: "test_imageUrlString2",
        zoomImageUrlString: "test_zoomImageUrlString2",
        categoryPath: "test_categoryPath2",
        available: false,
        productDescription: "test_productDescription2",
        price: 45.6,
        msrp: 78.9,
        album: "test_album2",
        actor: "test_actor2",
        artist: "test_artist2",
        author: "test_author2",
        brand: "test_brand2",
        year: 2000);

    final List<Product> result = mapper.map(input);

    expect(result.length, 2);
    expect(result, [prod1, prod2]);
  });
}
