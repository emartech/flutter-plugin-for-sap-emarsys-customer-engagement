class RecommendationFilter extends _Filter {
  @override
  late FilterType filterType;
  @override
  late String field;
  @override
  late Comparison comparison;
  @override
  late List<String> values;
  static _Filter exclude(String field) {
    return Exclude._(field);
  }

  static _Filter include(String field) {
    return Include._(field);
  }

  RecommendationFilter._create(
      this.filterType, this.field, this.comparison, this.values);
}

class _Filter {
  late FilterType filterType;
  late String field;
  late Comparison comparison;
  late List<String> values;

  RecommendationFilter isValue(String value) {
    return RecommendationFilter._create(
        filterType, field, Comparison.IS, [value]);
  }

  RecommendationFilter hasValue(String value) {
    return RecommendationFilter._create(
        filterType, field, Comparison.HAS, [value]);
  }

  RecommendationFilter inValues(List<String> list) {
    return RecommendationFilter._create(filterType, field, Comparison.IN, list);
  }

  RecommendationFilter overlapsValues(List<String> list) {
    return RecommendationFilter._create(
        filterType, field, Comparison.OVERLAPS, list);
  }
}

class Exclude extends _Filter {
  @override
  FilterType filterType = FilterType.EXCLUDE;

  @override
  late String field;

  Exclude._(this.field);
}

class Include extends _Filter {
  @override
  FilterType filterType = FilterType.INCLUDE;

  @override
  late String field;

  Include._(this.field);
}

enum FilterType { EXCLUDE, INCLUDE }
enum Comparison { IS, IN, HAS, OVERLAPS }
