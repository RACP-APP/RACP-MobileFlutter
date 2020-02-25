import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to the first screen by popping the current route
            // off the stack.
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}

 // Column(
            //   children: <Widget>[
            //     Card(
            //       child: Container(
            //         margin: const EdgeInsets.all(10.0),
            //         padding: const EdgeInsets.all(8.0),
            //         color: Colors.amber[600],
            //         width: 400,
            //         height: 300,
            //         child: RaisedButton(
            //           onPressed: () {},
            //           child: Text('Start '),
            //         ),
            //       ),
            //     )
            //   ],
            // )