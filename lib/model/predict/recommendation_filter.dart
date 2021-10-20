class RecommendationFilter extends _Filter {
  static _Filter exclude(String field) {
    return Exclude._(field);
  }

  static _Filter include(String field) {
    return Include._(field);
  }
}

class _Filter {
  late FilterType filterType;
  late String field;
  late Comparison comparison;
  late List<String> values;

  _Filter();
  _Filter._create(this.filterType, this.field, this.comparison, this.values);

  _Filter isValue(String value) {
    return _Filter._create(filterType, field, Comparison.IS, [value]);
  }

  _Filter hasValue(String value) {
    return _Filter._create(filterType, field, Comparison.HAS, [value]);
  }

  _Filter inValues(List<String> list) {
    return _Filter._create(filterType, field, Comparison.IN, list);
  }

  _Filter overlapsValues(List<String> list) {
    return _Filter._create(filterType, field, Comparison.OVERLAPS, list);
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
