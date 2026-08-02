import 'package:flutter/material.dart';

class AddPropertyScreen extends StatelessWidget {
  const AddPropertyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة عقار جديد'),
      ),
      body: const Center(
        child: Text('صفحة إضافة العقار'),
      ),
    );
  }
}
