// presentation/views/ecg_analysis/ecg_history_view.dart
import 'package:flutter/material.dart';

class EcgHistoryView extends StatelessWidget {
  const EcgHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سجل تحاليل ECG'),
      ),
      body: const Center(
        child: Text('صفحة سجل تحاليل ECG - قيد التطوير'),
      ),
    );
  }
}