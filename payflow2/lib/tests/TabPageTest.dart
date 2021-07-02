import 'package:flutter/material.dart';

class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: Text('Tabs Demo'),
          ),
          body: TabBarView(
            children: [
              new Container(
                color: Colors.deepOrangeAccent,
                child: new Center(
                  child: new Text(
                    "Primeira Guia",
                    style: TextStyle(),
                  ),
                ),
              ),
              new Container(
                color: Colors.blueGrey,
                child: new Center(
                  child: new Text(
                    "Segunda guia",
                    style: TextStyle(),
                  ),
                ),
              ),
              new Container(
                color: Colors.teal,
                child: new Center(
                  child: new Text(
                    "Terceira guia",
                    style: TextStyle(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
