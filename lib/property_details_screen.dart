import 'package:flutter/material.dart';

class PropertyDetailsScreen extends StatelessWidget {
  const PropertyDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل العقار'),
      ),
      body: const Center(
        child: Text('صفحة تفاصيل العقار'),
      ),
    );
  }
}

