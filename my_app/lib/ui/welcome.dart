import 'package:flutter/material.dart';


class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Logo'),
        ),
        body: Center(
          child: Text('Welcome'),
        ),
      ),
    );
  }
}
