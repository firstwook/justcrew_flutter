import 'package:flutter/material.dart';
import 'package:justcrew_flutter/ui/pages/crew/beer_home_page.dart';
import 'package:justcrew_flutter/ui/pages/crew/session_home_page.dart';
import 'package:justcrew_flutter/ui/pages/crew/session_list_page.dart';

import 'crew_home_page.dart';

class CrewSessionPage extends StatefulWidget {
  @override
  _CrewSessionPageState createState() => _CrewSessionPageState();
}

class _CrewSessionPageState extends State<CrewSessionPage> {
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
  Choice(title: 'UPCOMMING', icon: Icons.directions_run),
  Choice(title: 'LAST', icon: Icons.directions_run),
];

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
              SessionListPage(),
//              BeerHomePage(),
              SessionListPage(),
            ],
          ),
        ),
      ),
    );
  }
}

