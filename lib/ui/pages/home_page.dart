import 'package:flutter/material.dart';
import 'package:justcrew_flutter/firebase_provider.dart';
import 'package:provider/provider.dart';

import 'chat/chat.dart';
import 'crew/crew_main_page.dart';
import 'event/event.dart';
import 'dashboard/dashboard.dart';
import 'my/my.dart';

HomePageState pageState;

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    pageState = HomePageState();
    return pageState;
  }
}

class HomePageState extends State<HomePage> {

  int _currentIndex = 0;

  final List<Widget> _children = [
    Dashboard(),
    Crew(),
    Event(),
    Chat(),
    My(),
  ]; // to store tab views

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],

      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
            canvasColor: Colors.green,
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            primaryColor: Colors.red,
            textTheme: Theme
                .of(context)
                .textTheme
                .copyWith(caption: new TextStyle(color: Colors.yellow))), // sets the inactive color of the `BottomNavigationBar`
        child: new BottomNavigationBar(
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
              logger.d("_currentIndex: ${_currentIndex}");
            });
          },
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              title: Text('dashboard'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_run),
              title: Text('crew'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event),
              title: Text('event'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              title: Text('chat'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('my'),
            ),
          ],
        ),
      ),

//      bottomNavigationBar: BottomNavigationBar(
//        onTap: (int index) {
//          setState(() {
//            _currentIndex = index;
//            logger.d("_currentIndex: ${_currentIndex}");
//          });
//        },
//        currentIndex: _currentIndex,
//        items: [
//          BottomNavigationBarItem(
//            icon: Icon(Icons.dashboard),
//            title: Text('dashboard'),
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.directions_run),
//            title: Text('crew'),
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.event),
//            title: Text('event'),
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.chat),
//            title: Text('chat'),
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.person),
//            title: Text('my'),
//          ),
//        ],
//      ),
    );
  }




//  FirebaseProvider fp;
//  TextStyle tsItem = const TextStyle(
//      color: Colors.blueGrey, fontSize: 13, fontWeight: FontWeight.bold);
//  TextStyle tsContent = const TextStyle(color: Colors.blueGrey, fontSize: 12);
//
//
////  @override
////  Widget build(BuildContext context) {
////    fp = Provider.of<FirebaseProvider>(context);
////
////    double propertyWith = 130;
////    return Scaffold(
////      appBar: AppBar(title: Text("Singed In Page")),
////      body: ListView(
////        children: <Widget>[
////          Container(
////            margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
////            child: Column(
////              children: <Widget>[
////                //Header
////                Container(
////                  height: 50,
////                  decoration: BoxDecoration(color: Colors.amber),
////                  child: Center(
////                    child: Text(
////                      "Signed In User Info",
////                      style: TextStyle(
////                          color: Colors.blueGrey,
////                          fontSize: 18,
////                          fontWeight: FontWeight.bold),
////                    ),
////                  ),
////                ),
////
////                // User's Info Area
////                Container(
////                  decoration: BoxDecoration(
////                    border: Border.all(color: Colors.amber, width: 1),
////                  ),
////                  child: Column(
////                    children: <Widget>[
////                      // UID
////                      Row(
////                        children: <Widget>[
////                          Container(
////                            width: propertyWith,
////                            child: Text("UID", style: tsItem),
////                          ),
////                          Expanded(
////                            child: Text(fp.getUser().uid, style: tsContent),
////                          )
////                        ],
////                      ),
////
////                      Divider(height: 1),
////
////                      // Email
////                      Row(
////                        children: <Widget>[
////                          Container(
////                            width: propertyWith,
////                            child: Text("Email", style: tsItem),
////                          ),
////                          Expanded(
////                            child: Text(fp.getUser().email, style: tsContent),
////                          )
////                        ],
////                      ),
////
////                      Divider(height: 1),
////
////                      //Name
////                      Row(
////                        children: <Widget>[
////                          Container(
////                            width: propertyWith,
////                            child: Text("Name", style: tsItem),
////                          ),
////                          Expanded(
////                            child: Text(fp.getUser().displayName ?? "",
////                                style: tsContent),
////                          )
////                        ],
////                      ),
////
////                      Divider(height: 1),
////
////                      //Phone Number
////                      Row(
////                        children: <Widget>[
////                          Container(
////                            width: propertyWith,
////                            child: Text("Phone Number", style: tsItem),
////                          ),
////                          Expanded(
////                            child: Text(fp.getUser().phoneNumber ?? "",
////                                style: tsContent),
////                          )
////                        ],
////                      ),
////
////                      Divider(height: 1),
////
////                      //isEmailVerified
////                      Row(
////                        children: <Widget>[
////                          Container(
////                            width: propertyWith,
////                            child: Text("isEmailVerified", style: tsItem),
////                          ),
////                          Expanded(
////                            child: Text(fp.getUser().isEmailVerified.toString(),
////                                style: tsContent),
////                          )
////                        ],
////                      ),
////
////                      Divider(height: 1),
////
////                      //Provider ID
////                      Row(
////                        children: <Widget>[
////                          Container(
////                            width: propertyWith,
////                            child: Text("Provider ID", style: tsItem),
////                          ),
////                          Expanded(
////                            child:
////                            Text(fp.getUser().providerId, style: tsContent),
////                          )
////                        ],
////                      ),
////                    ].map((c) {
////                      return Padding(
////                        padding: const EdgeInsets.symmetric(
////                            vertical: 10, horizontal: 10),
////                        child: c,
////                      );
////                    }).toList(),
////                  ),
////                )
////              ],
////            ),
////          ),
////
////          // Sign In Button
////          Container(
////            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
////            child: RaisedButton(
////              color: Colors.indigo[300],
////              child: Text(
////                "SIGN OUT",
////                style: TextStyle(color: Colors.white),
////              ),
////              onPressed: () {
////                fp.signOut();
////              },
////            ),
////          ),
////
////          // Send Password Reset Email by English
////          Container(
////            margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
////            child: RaisedButton(
////              color: Colors.orange[300],
////              child: Text(
////                "Send Password Reset Email by English",
////                style: TextStyle(color: Colors.white),
////              ),
////              onPressed: () {
////                fp.sendPasswordResetEmailByEnglish();
////              },
////            ),
////          ),
////
////          // Send Password Reset Email by Korean
////          Container(
////            margin: const EdgeInsets.only(left: 20, right: 20, top: 0),
////            child: RaisedButton(
////              color: Colors.orange[300],
////              child: Text(
////                "Send Password Reset Email by Korean",
////                style: TextStyle(color: Colors.white),
////              ),
////              onPressed: () {
////                fp.sendPasswordResetEmailByKorean();
////              },
////            ),
////          ),
////
////          // Send Password Reset Email by Korean
////          Container(
////            margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
////            child: RaisedButton(
////              color: Colors.red[300],
////              child: Text(
////                "Withdrawal (Delete Account)",
////                style: TextStyle(color: Colors.white),
////              ),
////              onPressed: () {
////                fp.withdrawalAccount();
////              },
////            ),
////          ),
////        ],
////      ),
////    );
////  }
}