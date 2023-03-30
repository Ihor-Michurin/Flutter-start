import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Counter with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class CounterModel extends ChangeNotifier {
  Counter _counter = Counter();

  Counter get counter => _counter;

  void resetCounter() {
    _counter = Counter();
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CounterModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<CounterModel>(
                builder: (context, counterModel, child) => Text(
                  'Count: ${counterModel.counter.count}',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final counterModel =
                  Provider.of<CounterModel>(context, listen: false);
                  counterModel.counter.increment();
                },
                child: const Text('Increment'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final counterModel =
                  Provider.of<CounterModel>(context, listen: false);
                  counterModel.resetCounter();
                },
                child: const Text('Reset'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CounterModel(),
      child: const MaterialApp(
        home: MyHomePage(),
      ),
    ),
  );
}
