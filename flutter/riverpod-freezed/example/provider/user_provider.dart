import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/freezed/user.dart';

class UserNotifier extends StateNotifier<User> {
  final String defaultUserName = "guest";
  final int defaultUserAge = 99;
  UserNotifier() : super(const User(name: defaultUserName, age: defaultUserAge));

  void updateUserName({required String name}) {
    state = state.copyWith(name: name);
  }

  void updateUserAge({required int age}) {
    state = state.copyWith(age: age);
  }

  void resetUserName() {
    state = state.copyWith(name: defaultUserName);
    state = state.copyWith(age: defaultUserAge);
  }
}

final userStateNotifierProvider = StateNotifierProvider<UserNotifier, User>((ref) {
  return UserNotifier();
});
