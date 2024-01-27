import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SampleView extends StatefulWidget {
  const SampleView({super.key});

  @override
  State<SampleView> createState() => _SampleViewState();
}

class _SampleViewState extends State<SampleView> {
  int _counter = 0;
  late Future<Box> _boxFuture;

  @override
  void initState() {
    super.initState();
    _boxFuture = Hive.openBox('testBox');
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future<void> _saveCount() async {
    var box = await _boxFuture;
    box.put('counter', _counter);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Box>(
      future: _boxFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          var box = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text(box.get('counter', defaultValue: '0').toString()),
            ),
            floatingActionButton: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  onPressed: _incrementCounter,
                  child: const Icon(Icons.add),
                ),
                FloatingActionButton(
                  onPressed: _saveCount,
                  child: const Icon(Icons.save),
                ),
              ],
            ),
            body: Center(
              child: Text('$_counter'),
            ),
          );
        } else {
          // Yükleme sırasında gösterilecek widget
          return Scaffold(
            appBar: AppBar(
              title: const Text('Yükleniyor...'),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
