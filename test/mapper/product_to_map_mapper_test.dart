import 'package:emarsys_sdk/emarsys_sdk.dart';
import 'package:emarsys_sdk/mappers/product_to_map_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final ProductToMapMapper mapper = ProductToMapMapper();

  test('map should return with correct result', () async {
    final Map<String, dynamic> expected = {
      "productId": "test_productId",
      "title": "test_title",
      "linkUrl": "test_link",
      "feature": "test_feature",
      "cohort": "test_cohort",
      "customFields": {"field1": "value1", "field2": "value2"},
      "imageUrlString": "test_imageUrl",
      "zoomImageUrlString": "test_zoomImageUrl",
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
    };

    Product prod = Product(
        productId: "test_productId",
        title: "test_title",
        linkUrlString: "test_link",
        feature: "test_feature",
        cohort: "test_cohort",
        customFields: {"field1": "value1", "field2": "value2"},
        imageUrlString: "test_imageUrl",
        zoomImageUrlString: "test_zoomImageUrl",
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

    final Map<String, dynamic> result = mapper.map(prod);

    expect(result, expected);
  });
}
