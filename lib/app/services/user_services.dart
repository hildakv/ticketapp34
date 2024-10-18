import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user.dart';

class UserServices extends GetxService {
  final box = GetStorage();
  User? user;

  Future<UserServices> init() async {
    user = await getUser();

    return this;
  }

  Future<User?> getUser() async {
    try {
      final jsonUser = await box.read('user');

      return user = jsonUser != null
          ? User.fromJson(jsonUser as Map<String, dynamic>)
          : null;
    } catch (e) {
      if (kDebugMode) rethrow;
      // logger.e(e);

      return null;
    }
  }

  Future<void> saveUser(User savableUser) async {
    await box.write('user', savableUser.toJson());
    user = savableUser;
  }

  Future<void> removeUser() async {
    await box.remove('user');
    user = null;
  }
}
// class UserServices extends GetxService {
//   final box = GetStorage();
//   User? user;

//   Future<UserServices> init() async {
//     user = await getUser();

//     return this;
//   }

//   Future<User?> getUser() async {
//     try {
//       final jsonUser = await box.read('user');

//       return jsonUser != null
//           ? User.fromJson(jsonUser as Map<String, dynamic>)
//           : null;
//     } catch (e) {
//       if (kDebugMode) rethrow;

//       return null;
//     }
//   }

//   Future<void> saveUser(User savableUser) async {
//     await box.write('user', savableUser.toJson());
//     user = savableUser;
//   }

//   Future<void> removeUser() async {
//     await box.remove('user');
//     user = null;
//   }
// }
