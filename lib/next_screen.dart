import 'package:flutter/material.dart';

class NextScreen extends StatelessWidget {
  const NextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text(
          'Next Screen here....',
          style: TextStyle(
            fontSize: 100,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
