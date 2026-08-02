import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'dari_yemen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('تطبيق داري اليمن'),
        ),
        body: const Center(
          child: Text(
            'أهلاً بك في تطبيق داري اليمن',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}

