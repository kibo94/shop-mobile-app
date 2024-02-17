import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

@override
void initState() {
  initState();
  print('test page rendered');
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    print('test page rendered');
    return Scaffold(
      appBar: AppBar(
        title: Text('test page 2'),
      ),
      body: Container(child: Text('testr page')),
    );
  }
}
