import 'package:flutter/material.dart';
import 'package:prm393_project/Widgets/core_widgets_content.dart';

class CoreWidgetsDemo extends StatelessWidget {
  const CoreWidgetsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Core Widgets'),
      ),
      body: const CoreWidgetsContent(),
    );
  }
}
