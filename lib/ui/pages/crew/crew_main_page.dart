import 'package:flutter/material.dart';
import 'package:justcrew_flutter/ui/pages/crew/beer_home_page.dart';
import 'package:justcrew_flutter/ui/pages/crew/session_home_page.dart';

import 'crew_home_page.dart';

class Crew extends StatefulWidget {
  @override
  _CrewState createState() => _CrewState();
}

class _CrewState extends State<Crew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text('Chat'),
//      ),
      body: MyApp(),
    );
  }
}

class Choice {
  final String title;
  final IconData icon;
  const Choice({this.title, this.icon});

}

const List<Choice> choices = <Choice>[
  Choice(title: 'CREW', icon: Icons.directions_run),
  Choice(title: 'SESSION', icon: Icons.directions_run),
];


class Crew1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: choices.length,
        child: Scaffold(
          appBar: AppBar(
            title : Text('aaa'),
            bottom: TabBar(
              tabs: choices.map<Widget>((Choice choice) {
                return Tab(
                  text: choice.title,
                  icon: Icon(choice.icon),
                );
              }).toList(),
            ),
          ),
          body: TabBarView(
            children: <Widget>[
//              CrewHomePage(),
              BeerHomePage(),
              SessionHomePage(),
            ],
          )
        ),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'msc',
      home: DefaultTabController(
        length: choices.length,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
              color: Colors.green,
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    Expanded(child: new Container()),
                    TabBar(
//                      tabs: [new Text("Lunches"), new Text("Cart")],
                      tabs: choices.map<Widget>((Choice choice) {
                        return Tab(
                          text: choice.title,
//                          icon: Icon(choice.icon),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              CrewHomePage(),
//              BeerHomePage(),
              SessionHomePage(),
            ],
          ),
        ),
      ),
    );
  }
}

