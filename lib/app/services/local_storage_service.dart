import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import '../models/facility.dart';
import '../models/ticket.dart';

class LocalStorageService {
  final facilityStore = GetStorage("facilities");
  final ticketStore = GetStorage("tickets");

  LocalStorageService() {}

  factory LocalStorageService.instance() {
    return LocalStorageService();
  }

  static init() async {
    await GetStorage.init("facilities");
    await GetStorage.init("tickets");
  }

  _save(String key, dynamic value, GetStorage storage) async {
    storage.write(key, jsonEncode(value));
  }

  dynamic _get(String key, GetStorage storage) {
    return jsonDecode(storage.read(key));
  }

  saveFacilities(List<Facility> facilities) {
    _save("facilities", facilities, facilityStore);
  }

  getFacilities() {
    var facilities = _get("facilities", facilityStore);
    if (null == facilities) {
      return [];
    }

    return (facilities as List<dynamic>)
        .map((e) => Facility.fromJson(e))
        .toList();
  }

  saveTicket(Ticket ticket) {
    _save(ticket.id, ticket, ticketStore);
  }

  getTicket(String id) {
    return Ticket.fromJson(_get(id, ticketStore));
  }

  getAllTickets() {
    return jsonDecode(this.ticketStore.getValues());
  }

  Future<void> removeFacility() async {
    await facilityStore.remove('facilities');
    // user = null;
  }
}
