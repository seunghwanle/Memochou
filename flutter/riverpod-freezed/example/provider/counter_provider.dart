import 'package:flutter_riverpod/flutter_riverpod.dart';

class Counter extends StateNotifier<int> {
  Counter() : super(0);

  void increment() => state++;
  void decrement() => state--;
  void reset() => state = 0;
}

final counterStateNotifierProvider = StateNotifierProvider<Counter, int>((ref) {
  return Counter();
});
