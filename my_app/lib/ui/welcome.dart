import 'package:flutter/material.dart';


class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to RACP App',
      home: Scaffold(
        body: Column(  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [
            Image.asset('assets/racpLogo.png'),
            Text('Welcome to our RACP App, this app is very helpeful for refugees childrens',
            style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w800,
          fontFamily: 'Roboto',
          letterSpacing: 0.5,
          fontSize: 20,
        ),),
            const SizedBox(height: 30),
        RaisedButton(
          onPressed: () {},
          textColor: Colors.white,
          padding: const EdgeInsets.all(0.0),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Color(0xFF0D47A1),
                  Color(0xFF1976D2),
                  Color(0xFF42A5F5),
                ],
              ),
            ),
            padding: const EdgeInsets.all(10.0),
            child: const Text(
              'Start',
              style: TextStyle(fontSize: 20)
            ),
          ),
        ),

          ]
        ),
      ),
    );
  }
}
