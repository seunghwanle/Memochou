import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({required String? name, required int? age}) = _User;

  // not mandatory
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

// .g , .freezed 파일 생성하는 커맨드
// command: flutter pub run build_runner build 