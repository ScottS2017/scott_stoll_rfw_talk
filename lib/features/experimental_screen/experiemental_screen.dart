import 'package:flutter/material.dart';

/// A screen used to test Flutter code returned from the LLM.
@immutable
class ExperimentalScreen extends StatelessWidget {
  /// Creates an instance of [ExperimentalScreen].
  const ExperimentalScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Experimental Flutter Code'),
      ),
      body: const Placeholder(),
    );
  }
}