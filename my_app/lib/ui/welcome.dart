import 'package:flutter/material.dart';

// import './secondpage.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to RACP App',
      home: Scaffold(
        backgroundColor: Colors.grey[800],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Card(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Image.asset('assets/racpLogo.png'),
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(8.0),
                width: 400,
                height: 50,
                color: Colors.amber[200],
                child: Column(
                  children: <Widget>[
                    Text('Welcome to our RACP App.',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey))
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                color: Colors.blue[300],
                child: Column(
                  children: <Widget>[
                    FlatButton(
                      child: Text('Start'),
                      textColor: Colors.white,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
