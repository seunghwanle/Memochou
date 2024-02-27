 ✨ _Summary of what I studied about Flutter Riverpod_ 

> ### Riverpod
> Flutterのパッケージの1つで、GetXやProvider、BLoCのような状態管理を行うためのパッケージ。（Providerの拡張版（？）と考えられる）


### Package 設定
```yaml
// pubspec.yaml
dependencies:
  
  // dart
  riverpod:
  
  // flutter
  flutter_riverpod:

  // flutter & flutter_hooks
  flutter_hooks: 
  hooks_riverpod: 
```

### 基本的な概念

### 1. Providers

Providerを定義する部分で、Widgetで共通に使用したいデータを定義する。

#### 1-1 Provider

```dart
final valueProvider = Provider<int>((ref) {
  return 0;
});
```

最も基本的なProviderの形式。読み取り専用であり、値を変更することはできない。

#### 1-2 StateProvider

```dart
final counterStateProvider = StateProvider<int>((ref) {
  return 0;
});
```

StateProviderは、状態を変更できるProvider。内部の状態には state を使ってアクセスできる。使用するWidgetからstateの値を直接変更できる。

#### 1-3 StateNotifierProvider

```dart
class Counter extends StateNotifier<int> {
  Counter() : super(0);

  void increment() => state++;
  void decrement() => state--;
}

final counterStateNotifierProvider = StateNotifierProvider<Counter, int>((ref) {
  return Counter();
});
```

StateNotifierProviderは、状態だけでなく一部のロジックも保存する際に使用される。例えば、他のProviderと組み合わせたり、内部で使用するロジックを定義したりすることができる。

### Reading a provider

#### ProviderScope

```dart
void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}
```
Providerを使用するためには、まずアプリ全体を ProviderScope で囲む必要がある。

#### WidgetRef

```dart
// Provider 정의
final valueProvider = Provider<int>((ref) {
  return 0;
});

// ConsumerWidget 사용
class MyHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(valueProvider);
    return Scaffold(
      body: Center(
        child: Text(
          'Value: $value',
        ),
      ),
    );
  }
}
```
riverpodで定義された WidgetRef を使用して、アクセスが可能であり、この WidgetRef はWidgetとProviderの間の相互作用をサポートする。つまり、 WidgetRef を介して、特定のWidgetで特定のProviderにアクセスできると考えることができる。

WidgetRef を使用するためには、 Consumer、ConsumerWidget、ConsumerStatefulWidget を介して使用できる。


#### WidgetRefを使用して読み取る

WidgetRefを使用してProviderにアクセスするには、大きく分けて3つの方法がある。watch、listen、readの3つのメソッドが提供されてるが、公式ドキュメントではほとんどの場合、watchの使用が推奨されてる。 3つのメソッドはすべて同じ値を読み取るが、読み取った後の動作が少し異なる。

**ref.watch**

- リアクティブにProviderの値が変更されると、自動的に再構築される。
- 非同期的に呼び出すか、onTab、initStateなどのライフサイクル内では使用しない。
- 他のProviderと組み合わせると非常に便利。

**ref.listen**

- Providerの値が変更されると、値を読み取るのではなく、定義した関数を実行する。
- ref.watchと同様に、build内またはProvider内でのみ使用する必要がある。
- SnackBarやDialogを処理するのに役立つ。

**ref.read**
- Providerの値を読み取りますが、値が変更されても特に動作しない。
- 公式ドキュメントによると、特別な場合を除いて使用しないそう。

> #### 参考 
>
> 公式ドキュメントによると、ref.readの使用は避けるべきであり、可能な限りref.watchを使用することを推奨しており、buildメソッド内でref.readを使用しないでくださいと記載されてる。また、buildの回数を減らすためにref.readを使用する場合、ref.watchを使用しても同じ効果が得られるとされている。
