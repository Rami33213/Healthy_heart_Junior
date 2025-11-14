// presentation/views/heart_rate/heart_rate_history_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/heart_rate_controller.dart';

class HeartRateHistoryView extends StatelessWidget {
  const HeartRateHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سجل ضربات القلب'),
      ),
      body: const Center(
        child: Text('صفحة سجل ضربات القلب - قيد التطوير'),
      ),
    );
  }
}