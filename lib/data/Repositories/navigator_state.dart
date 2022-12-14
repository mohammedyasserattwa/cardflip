import "package:flutter_riverpod/flutter_riverpod.dart";

final NavigatorState = StateProvider<List<bool>>((ref) {
  return [true,false,false];
});
