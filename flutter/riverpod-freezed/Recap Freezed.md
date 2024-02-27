 ✨ _Summary of what I studied about Flutter Freezed_ 

> ### What is freezed ?
> モデルを効率的に管理および使用するのを支援するパッケージ。
> Riverpodを開発したチームからの発言によれば、Providerと組み合わせて使用するとさらに輝くと述べている。


### Why we need freezed ?

title, price, thumbnailのみを持つシンプルなモデルクラスだが、よく使用されるメソッドを定義するためにコードの量が長くなりすぎている。
```dart
// freezed 未使用
@immutable
class EventModel {
  final String title;
  final int price;
  final String thumbnail;
 
  const EventModel({
    required this.title,
    required this.price,
    required this.thumbnail,
  });
 
  EventModel copyWith({
    String? title,
    int? price,
    String? thumbnail,
  }) {
    return EventModel(
      title: title ?? this.title,
      price: price ?? this.price,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }
 
  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      title: json['title'] as String,
      price: json['price'] as int,
      thumbnail: json['thumbnail'] as String,
    );
  }
 
 　、、、省略、、、 
```

```dart
// freezed 使用
part 'event_model.freezed.dart';
part 'event_model.g.dart';
 
@freezed
class EventModel with _$EventModel {
  const factory EventModel({
    required String title,
    required int price,
    required String thumbnail,
  }) = _EventModel;
 
  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);
}
```

Freezedを使用すると、以前のコードを上記のように簡潔に書くことができる。


### How to use freezed

### Package 設定
```yaml
// pubspec.yaml
dependencies:
  freezed_annotation: ^2.4.1

  # if using freezed to generate fromJson/toJson, also add:
  json_annotation: ^4.8.1

dev_dependencies:
  build_runner: ^2.4.8
  freezed: ^2.4.7

  # if using freezed to generate fromJson/toJson, also add:
  json_serializable: ^6.7.1
```

### Model クラス作成

```dart
part 'event_model.freezed.dart';
part 'event_model.g.dart';
 
@freezed
class EventModel with _$EventModel {
  const factory EventModel({
    required String title,
    required int price,
    required String thumbnail,
  }) = _EventModel;
 
  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);
}
```
- @freezed アノテーションを使用してクラスを作成する。
- factoryのconstructorに必要なpropertyを記述する。
- JSON機能を使用する場合は、fromJsonメソッドを記述します。

### Code Generator 実行

ターミナルで flutter pub run build_runner build を実行する。

> 既存のbuild_runnerで作成したコードがある場合、エラーが発生します。
> その場合は、ファイルを1つずつ削除して再度実行せずに、下記のコマンドを実行。
> flutter pub run build_runner build --delete-conflicting-outputs
