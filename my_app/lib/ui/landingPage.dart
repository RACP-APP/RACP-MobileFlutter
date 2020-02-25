import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Landing',
      home: Scaffold(
        backgroundColor: Colors.grey[800],
        appBar: AppBar(
          title: const Text('Landing Page'),
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
                alignment: Alignment.centerLeft,
                color: Colors.blue,
                icon: const Icon(
                  Icons.notifications_active,
                ),
                onPressed: null),
            Image.asset('assets/racpLogo.png'),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                // margin: EdgeInsetsGeometry(

                // ),
                child: Text('RACP.',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
              ),
            ),
            Card(
              child: Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(8.0),
                color: Colors.amber[600],
                width: 400,
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  
                  children: <Widget>[
                    Text(
                        'Welcome to our RACP App, this app is very helpeful for refugees childrens.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800])),
                    RaisedButton(
                      onPressed: ()=>print('Start is working'),
                      child: Text(
                        'Start Learning',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blue,
                        
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
