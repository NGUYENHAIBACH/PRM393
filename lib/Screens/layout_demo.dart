import 'package:flutter/material.dart';
import 'package:prm393_project/Widgets/layout_content.dart';

class LayoutDemo extends StatelessWidget {
  const LayoutDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Layout Basics'),
      ),
      body: const LayoutContent(),
    );
  }
}
