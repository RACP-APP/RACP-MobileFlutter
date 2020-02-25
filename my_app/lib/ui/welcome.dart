import 'package:flutter/material.dart';

// import './secondpage.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to RACP App',
    
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    // initialRoute: '/',
    // routes: {
    //   // When navigating to the "/" route, build the FirstScreen widget.
    //   // '/': (context) => Welcome(),
    //   // When navigating to the "/second" route, build the SecondScreen widget.
    //   // '/second': (context) => SecondScreen(),
    //   '/second': (BuildContext context) => new SecondScreen(),

    // },
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
                margin: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.blueGrey[100],

                  // width: 1,
                )),
                child: Column(
                  children: <Widget>[
                    Text(
                        'Welcome to our RACP App, this app is very helpeful for refugees childrens.',
                        style: TextStyle(
                            fontSize: 16,
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
                      // onPressed: () {
                      //     Navigator.pushNamed(context, '/second');
                      // },
                      //  onPressed: () => Navigator.of(context).pushNamed('/second')
                      onPressed: (){
                        
                      },
                       

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
