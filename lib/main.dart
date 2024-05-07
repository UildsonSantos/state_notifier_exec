import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'package:state_notifier_exec/providers/providers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StateNotifierProvider<BgColor, BgColorState>(
            create: (context) => BgColor()),
        StateNotifierProvider<Counter, CounterState>(
            create: (context) => Counter()),
        StateNotifierProvider<CustomerLevel, Level>(
            create: (context) => CustomerLevel()),
      ],
      child: MaterialApp(
        title: 'StateNotifier',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyhomePage(),
      ),
    );
  }
}

class MyhomePage extends StatelessWidget {
  const MyhomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorState = context.watch<BgColorState>();
    final counterState = context.watch<CounterState>();
    final levelState = context.watch<Level>();

    return Scaffold(
      backgroundColor: levelState == Level.bronze
          ? Colors.white
          : levelState == Level.silver
              ? Colors.grey
              : Colors.yellow,
      appBar: AppBar(
        backgroundColor: colorState.color,
        title: const Text('StateNotifier'),
      ),
      body: Center(
        child: Text(
          '${counterState.counter}',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            tooltip: 'Increment',
            onPressed: () {
              context.read<Counter>().increment();
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10.0),
          FloatingActionButton(
            tooltip: 'Change Color',
            onPressed: () {
              context.read<BgColor>().changeColor();
            },
            child: const Icon(Icons.color_lens_outlined),
          ),
        ],
      ),
    );
  }
}
