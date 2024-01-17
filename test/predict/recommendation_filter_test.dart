import 'package:emarsys_sdk/model/predict/recommendation_filter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {});

  test('isValue should create RecommendationFilter', () async {
    var result = RecommendationFilter.exclude("testField").isValue("testValue");
    expect(result.comparison, Comparison.IS);
    expect(result.field, "testField");
    expect(result.filterType, FilterType.EXCLUDE);
    expect(result.values, ["testValue"]);
  });

  test('hasValue should create RecommendationFilter', () async {
    var result =
        RecommendationFilter.include("testField").hasValue("testValue");
    expect(result.comparison, Comparison.HAS);
    expect(result.field, "testField");
    expect(result.filterType, FilterType.INCLUDE);
    expect(result.values, ["testValue"]);
  });

  test('inValue should create RecommendationFilter', () async {
    var result = RecommendationFilter.include("testField")
        .inValues(["testValue1", "testValue2"]);
    expect(result.comparison, Comparison.IN);
    expect(result.field, "testField");
    expect(result.filterType, FilterType.INCLUDE);
    expect(result.values, ["testValue1", "testValue2"]);
  });

  test('overlapsValues should create RecommendationFilter', () async {
    var result = RecommendationFilter.include("testField")
        .overlapsValues(["testValue1", "testValue2"]);
    expect(result.comparison, Comparison.OVERLAPS);
    expect(result.field, "testField");
    expect(result.filterType, FilterType.INCLUDE);
    expect(result.values, ["testValue1", "testValue2"]);
  });
}
