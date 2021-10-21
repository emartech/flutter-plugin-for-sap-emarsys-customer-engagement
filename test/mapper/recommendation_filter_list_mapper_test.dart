import 'package:emarsys_sdk/emarsys_sdk.dart';
import 'package:emarsys_sdk/mappers/recommendation_filter_list_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final RecommendationFilterListMapper mapper =
      RecommendationFilterListMapper();

  test('map should not crash when inputFilter is empty', () async {
    final List<RecommendationFilter> testFilters = [];
    final List<Map<String, dynamic>> result = mapper.map(testFilters);

    expect(result.length, 0);
  });
  test('map should map list of RecommendationFilter', () async {
    final List<RecommendationFilter> testFilters = [];

    final List<Map<String, dynamic>> expectedResult = [];
    expectedResult.add({
      "filterType": "EXCLUDE",
      "field": "testField1",
      "comparison": "IS",
      "values": ["testValue1"]
    });
    expectedResult.add({
      "filterType": "INCLUDE",
      "field": "testField2",
      "comparison": "IN",
      "values": ["testValue2", "testValue3"]
    });
    testFilters
        .add(RecommendationFilter.exclude("testField1").isValue("testValue1"));
    testFilters.add(RecommendationFilter.include("testField2")
        .inValues(["testValue2", "testValue3"]));

    final List<Map<String, dynamic>> result = mapper.map(testFilters);

    expect(result.length, 2);
    expect(result, expectedResult);
  });
}
