import 'package:flutter/material.dart';


class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to RACP App',
      home: Scaffold(
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
              
              child: Column(
                children: <Widget>[
                  Text('Welcome to our RACP App, this app is very helpeful for refugees childrens')
                ],
              ),
            ),
          ),
          Card(
            child: Container(
              color: Colors.blue,
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
