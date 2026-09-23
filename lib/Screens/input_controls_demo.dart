import 'package:flutter/material.dart';
import 'package:prm393_project/Widgets/input_controls_content.dart';

class InputControlsDemo extends StatelessWidget {
  const InputControlsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Controls'),
      ),
      body: const InputControlsContent(),
    );
  }
}
