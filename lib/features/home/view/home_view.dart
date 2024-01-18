import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Box<String> _box;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _box = Hive.box<String>('testBox');
    _box.put('testValue', 'Burak');
    _box.put('testValue', 'Kızılay');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('${_box.get('testValue')}'),
      ),
    );
  }
}
