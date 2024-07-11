import 'package:emarsys_sdk/emarsys_sdk.dart';
import 'package:emarsys_sdk/mappers/mapper.dart';

class RecommendationFilterListMapper
    extends Mapper<List<RecommendationFilter>, List<Map<String, dynamic>>> {
  @override
  List<Map<String, dynamic>> map(List<RecommendationFilter> input) {
    return input
        .map((recommendationFilter) =>
            mapRecommendationFilter(recommendationFilter))
        .toList();
  }

  Map<String, dynamic> mapRecommendationFilter(RecommendationFilter input) {
    return {
      "filterType": input.filterType.toShortString(),
      "field": input.field,
      "comparison": input.comparison.toShortString(),
      "values": input.values
    };
  }
}

extension ParseToString on Enum {
  String toShortString() {
    return toString().split('.').last;
  }
}
