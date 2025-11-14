// presentation/views/lab_analysis/lab_history_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/lab_controller.dart';

class LabHistoryView extends StatelessWidget {
  const LabHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سجل التحاليل المخبرية'),
      ),
      body: const Center(
        child: Text('صفحة سجل التحاليل المخبرية - قيد التطوير'),
      ),
    );
  }
}