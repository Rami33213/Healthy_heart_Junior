// presentation/views/expert_system/expert_history_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/expert_controller.dart';

class ExpertHistoryView extends StatelessWidget {
  const ExpertHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سجل الاستشارات'),
      ),
      body: const Center(
        child: Text('صفحة سجل الاستشارات - قيد التطوير'),
      ),
    );
  }
}