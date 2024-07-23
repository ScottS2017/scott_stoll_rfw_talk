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
      body: Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 300.0,
          height: 200.0,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
            image: DecorationImage(
              image: NetworkImage("https://kenneltocouch.org/wp-content/uploads/2019/09/iStock-1143880146-1080x675.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: 300.0,
          height: 200.0,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
            image: DecorationImage(
              image: NetworkImage("https://image.petmd.com/files/styles/863x625/public/2023-03/pit-bull.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    ),
    ),
    );
  }
}