import 'package:flutter/material.dart';
import './landingPage.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.grey[800],
      //  appBar: AppBar(
      //   // title: Text('Welcome to RACP App'),
      
      // ),
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
                    child: Text('Get Started'),
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                         '/first'
                        );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
