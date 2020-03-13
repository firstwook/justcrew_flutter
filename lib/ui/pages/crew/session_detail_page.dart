import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:justcrew_flutter/models/crew.dart';
import 'package:justcrew_flutter/models/session_member.dart';
import 'package:justcrew_flutter/models/session.dart';
import 'package:justcrew_flutter/repository/session_repository.dart';
import 'package:justcrew_flutter/ui/pages/crew/crew_session_page.dart';
import 'package:justcrew_flutter/widgets/session_member_tile.dart';

class SessionDetailPage extends StatefulWidget {
  final Session session;

  SessionDetailPage(this.session);

  @override
  _SessionDetailPageState createState() => _SessionDetailPageState();
}

class _SessionDetailPageState extends State<SessionDetailPage> {

  List<SessionMember> _sessionMembers = <SessionMember>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    listenForSessionMembers();

    print("sessionId : ${widget.session.id} ");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.session.name),
      ),
      body: new Container(
        constraints: new BoxConstraints.expand(),
//        color: new Color(0xFF736AB7),
        color: Colors.white,
        child: new Stack(
          children: <Widget>[
            _getBackground(),
            _getGradient(),
            _getContent(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          _getJoinButton();
        },
        child: Text('JOIN'),
      ),
    );
  }

  void listenForSessionMembers() async {

    final Stream<SessionMember> stream =
    await getSessionMembers(widget.session.id);

    stream.listen((SessionMember sessionMember) => setState(() => _sessionMembers.add(sessionMember)));

  }

  Container _getBackground() {
    return new Container(
      child: CachedNetworkImage(
        imageUrl: widget.session.logoImageUrl,
        placeholder: (context, url) => new CircularProgressIndicator(),
        errorWidget: (context, url, error) => new Icon(Icons.error),
        height: 300.0,
        fit: BoxFit.cover,
      ),
      constraints: new BoxConstraints.expand(height: 250.0),
    );
  }

  Container _getGradient() {
    return new Container(
      margin: new EdgeInsets.only(top: 160.0),
      height: 110.0,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: <Color>[new Color(0x00736AB7), Colors.white],
          stops: [0.0, 0.9],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
        ),
      ),
    );
  }

  Widget _getContent() {
    final _overviewTile = "Overview".toUpperCase();

    return new ListView(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      padding: new EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 32.0),
      children: <Widget>[
        new SessionSummary(
          widget.session,
          horizontal: false,
        ),
        new Container(
          padding: new EdgeInsets.symmetric(horizontal: 32.0, vertical: 20),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(_overviewTile),
              new Separator(),
//              new Text(widget.session.description)
              new Text(widget.session.description + widget.session.description +widget.session.description),
            ],
          ),
        ),
        _getParticipant()
      ],
    );
  }

  Widget _getParticipant() {
    print('_sessionMembers.length ; ${_sessionMembers.length}');

    return Container(

      padding: new EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          Container(

            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  padding:
                      new EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                  child: Center(
                      child: Text(
                        '참가자',
                        style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                ),
                (_sessionMembers.length > 0)
                ?
                Container(
                  height: 400,
                  color: Colors.grey.withOpacity(0.1),
                  child: ListView.builder(
                    itemCount: _sessionMembers.length,
                    itemBuilder: (context, index) =>
                        SessionMemberTile(_sessionMembers[index]),
                  ),
                )
//                Container(
//                  height: 400,
//                  color: Colors.grey.withOpacity(0.1),
//                  child: GroupedListView<dynamic, String>(
//                    physics: ClampingScrollPhysics(),
//                    shrinkWrap: true,
//                    groupBy: (element) => element['sessionMemberType'],
//                    elements: _elements,
//                    sort: true,
//                    groupSeparatorBuilder: (String value) => Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: Center(
//                          child: Text(
//                            value,
//                            style:
//                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                          )),
//                    ),
//                    itemBuilder: (c, element) {
//                      return Card(
//                        elevation: 0.5,
//                        margin: new EdgeInsets.symmetric(
//                            horizontal: 20.0, vertical: 6.0),
//                        child: Container(
//                          child: ListTile(
//                            contentPadding: EdgeInsets.symmetric(
//                                horizontal: 10.0, vertical: 10.0),
//                            leading: Icon(Icons.account_circle),
//                            title: Text(element['memberNickName']),
//                            trailing: Icon(Icons.arrow_forward),
//                          ),
//                        ),
//                      );
//                    },
//                  ),
//                )
//                Container(
//                  child: Center(
//                    child: Text("참가자가 있습니다."),
//                  ),
//                )
                    :
                Container(
                  child: Center(
                    child: Text("참가자가 없습니다."),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }



  _getJoinButton() {

    print('aaaa ${widget.session.id}');
  }
}

class Separator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: new EdgeInsets.symmetric(vertical: 8.0),
        height: 2.0,
        width: 18.0,
        color: new Color(0xff00c6ff));
  }
}

class SessionTypeToggle extends StatelessWidget {

  final String _typeName;
  final bool _isActive;

  const SessionTypeToggle(this._typeName, this._isActive);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: (_isActive) ? Colors.white : Colors.grey,
      ),
      width: 60.0,
      height: 25.0,
      child: Text(
        _typeName,
        style: TextStyle(
            color: (_isActive) ? Colors.blueGrey : Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold),
      ),
      alignment: Alignment(0.0,0.0),
    );
  }
}

class SessionSimpleDescription extends StatelessWidget {

  final Icon _icon;
  final String _description;

  const SessionSimpleDescription(this._icon, this._description);

  @override
  Widget build(BuildContext context) {
    return Container(
//      width: 1000,
//      padding: const EdgeInsets.all(1.0),
      child: new Row(
        children: <Widget>[
          _icon,
          new Container(
            width: 5.0,
          ),
          Flexible(
            child: Text(_description, textAlign: TextAlign.left,),
          ),
        ],
      ),
    );
  }
}



class SessionSummary extends StatelessWidget {
  final Session session;
  final bool horizontal;

  static Random random = Random();

  SessionSummary(this.session, {this.horizontal = true});

  SessionSummary.vertical(this.session) : horizontal = false;

  final df = new DateFormat('yyyy-MM-dd hh:mm a');

  @override
  Widget build(BuildContext context) {

    final sessionCardContent = new Container(
        margin: new EdgeInsets.fromLTRB(
            horizontal ? 76.0 : 16.0, horizontal ? 16.0 : 42.0, 16.0, 16.0),
        constraints: new BoxConstraints.expand(),
        child: new Column(
          crossAxisAlignment:
          horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: <Widget>[
            new Text(
              session.name,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600),
            ),
            new Container(
              height: 5.0,
            ),
            new Container(
              margin: new EdgeInsets.symmetric(vertical: 8.0),
              height: 1.0,
              width: 300,
              color: Colors.grey,
            ),
            new Container(
              height: 5.0,
            ),
            Container(
//          padding: EdgeInsets.all(10.0),
              child: new Column(
                children: <Widget>[
//                  Container(
//                    child: Row(
//                      children: <Widget>[
//                        SessionSimpleDescription(Icon(Icons.date_range), df.format(DateTime.parse(session.date))),
//                        SessionSimpleDescription(Icon(Icons.people), (session.maximumOccupancy).toString() + ' 명'),
//                      ],
//                    ),
//                  ),
                  SessionSimpleDescription(Icon(Icons.place), session.gatheringPlace + '\n(서울특별시 어디어디 어디어디 어디어디 어디어디 버닞 123)'),
                  new Container(
                    height: 5.0,
                  ),
                  SessionSimpleDescription(Icon(Icons.date_range), df.format(DateTime.parse(session.date))),
                  new Container(
                    height: 5.0,
                  ),
                  SessionSimpleDescription(Icon(Icons.people), (session.maximumOccupancy).toString() + ' 명'),
                  new Container(
                    height: 5.0,
                  ),
//                  SessionSimpleDescription(Icon(Icons.golf_course), (session.maximumOccupancy).toString() + ' 명'),
//                  new Container(
//                    height: 5.0,
//                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.grey,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: (session.type == 'regular') ?
                              <Widget>[
                                SessionTypeToggle('정기', true),
                                SessionTypeToggle('번개', false),
                              ] : <Widget>[
                                SessionTypeToggle('정기', false),
                                SessionTypeToggle('번개', true),
                              ]
                              ,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.grey,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: (session.allowableType == 'public') ?
                              <Widget>[
                                SessionTypeToggle('모두', true),
                                SessionTypeToggle('멤버', false),
                              ] : <Widget>[
                                SessionTypeToggle('모두', false),
                                SessionTypeToggle('멤버', true),
                              ]
                              ,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        )
    );

    final sessionCard = new Container(
      child: sessionCardContent,
      height: horizontal ? 124.0 : 280.0,
      margin: horizontal
          ? new EdgeInsets.only(left: 46.0)
          : new EdgeInsets.only(top: 72.0),
      decoration: new BoxDecoration(
//          color: new Color(0xFF333366),
          color: Colors.white70,
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.circular(8.0),
          boxShadow: <BoxShadow>[
            new BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              offset: new Offset(0.0, 10.0),
            )
          ]),
    );

    return new GestureDetector(
//      onTap: horizontal
//      ? () => Navigator.of(context).push(
//        new PageRouteBuilder(
//            pageBuilder: (_, __, ___) => new)
//      ),
      child: new Container(
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: new Stack(
          children: <Widget>[
            sessionCard,
          ],
        ),
      ),
    );
  }
}
