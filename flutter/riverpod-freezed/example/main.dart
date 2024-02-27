import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/provider/counter_provider.dart';
import 'package:riverpod_test/provider/user_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Riverpod & Freezed Tutorial",
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey,
        appBarTheme: const AppBarTheme(shadowColor: Colors.amber, backgroundColor: Colors.blueGrey),
      ),
      home: const Home(),
    );
  }
}

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riverpod & Freezed Tutorial')),
      body: Center(
        child: Consumer(
          builder: (context, ref, _) {
            final count = ref.watch(counterStateNotifierProvider);
            final user = ref.watch(userStateNotifierProvider);

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    _showEditModal(context, ref);
                  },
                  child: Text('${user.name} / ${user.age}'),
                ),
                Text('$count'),
              ],
            );
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => ref.read(counterStateNotifierProvider.notifier).increment(),
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () => ref.read(counterStateNotifierProvider.notifier).decrement(),
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () => ref.read(counterStateNotifierProvider.notifier).reset(),
            child: const Icon(Icons.replay_outlined),
          ),
        ],
      ),
    );
  }

  void _showEditModal(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final ageController = TextEditingController();
    final person = ref.watch(userStateNotifierProvider);

    nameController.text = person.name ?? '';
    ageController.text = person.age?.toString() ?? '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Person'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: ageController,
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                ref.read(userStateNotifierProvider.notifier).updateUserName(name: nameController.text);
                ref.read(userStateNotifierProvider.notifier).updateUserAge(age: int.tryParse(ageController.text) ?? 0);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () {
                ref.read(userStateNotifierProvider.notifier).resetUserName();
                Navigator.of(context).pop();
              },
              child: const Text('Reset'),
            ),
          ],
        );
      },
    );
  }
}
