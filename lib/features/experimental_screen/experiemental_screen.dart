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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.purple[800],
        title: const Text(
          'hi there',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 200.0,
              height: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://image.petmd.com/files/styles/863x625/public/2023-03/pit-bull.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: 200.0,
              height: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://kenneltocouch.org/wp-content/uploads/2019/09/iStock-1143880146-1080x675.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: 200.0,
              height: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://assets3.thrillist.com/v1/image/3082123/792x446/scale;webp=auto;jpeg_quality=60;progressive.jpg'),
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