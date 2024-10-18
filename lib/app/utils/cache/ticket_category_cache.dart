import '../../models/facility.dart';
import '../../models/subfacility.dart';

class TicketCategoryCache {
  static final TicketCategoryCache _cache = TicketCategoryCache();

  final Map<String, Facility> _facilityCache = {};
  final Map<String, SubFacility> _subFacilityCache = {};

  TicketCategoryCache();

  _update(List<SubFacility> tickets) {
    for (var element in tickets) {
      _subFacilityCache.update(element.id, (value) => element,
          ifAbsent: () => element);
    }
  }

  update(List<Facility> facilities) {
    for (var element in facilities) {
      _facilityCache.update(element.id, (value) => element,
          ifAbsent: () => element);
      _update(element.subfacilities);
    }
  }

  getSubFacility(String subFacilityId) {
    return _subFacilityCache[subFacilityId];
  }

  getSubFacilityName(String subFacilityId) {
    return _subFacilityCache[subFacilityId]?.name;
  }

  getFacility(String facilityId) {
    return _facilityCache[facilityId];
  }

  getFacilityName(String facilityId) {
    return _facilityCache[facilityId]?.name;
  }

  factory TicketCategoryCache.get() {
    return _cache;
  }
}
