import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:justcrew_flutter/models/crew.dart';
import 'package:justcrew_flutter/ui/pages/crew/crew_home_page.dart';
import 'package:justcrew_flutter/ui/pages/crew/crew_session_page.dart';

class CrewDetailPage extends StatefulWidget {
  final Crew crew;

  CrewDetailPage(this.crew);

  @override
  _CrewDetailPageState createState() => _CrewDetailPageState();
}

class _CrewDetailPageState extends State<CrewDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.crew.name),
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
          print('aaaa ${widget.crew.id}');
        },
        child: Text('JOIN'),
      ),
    );
  }

  Container _getBackground() {
    return new Container(
      child: CachedNetworkImage(
        imageUrl: widget.crew.bgImageUrl,
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
      padding: new EdgeInsets.fromLTRB(0.0, 72.0, 0.0, 32.0),
      children: <Widget>[
        new CrewSummary(
          widget.crew,
          horizontal: false,
        ),
        new Container(
          padding: new EdgeInsets.symmetric(horizontal: 32.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(_overviewTile),
              new Separator(),
//              new Text(widget.crew.description)
            new Text(widget.crew.description)
            ],
          ),
        )
      ],
    );
  }

  _getJoinButton() {

    return Container(

    );

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

class CrewSummary extends StatelessWidget {
  final Crew crew;
  final bool horizontal;

  static Random random = Random();

  CrewSummary(this.crew, {this.horizontal = true});

  CrewSummary.vertical(this.crew) : horizontal = false;

  @override
  Widget build(BuildContext context) {
    final crewThumbnail = new Container(
      margin: new EdgeInsets.symmetric(vertical: 16.0),
      alignment:
          horizontal ? FractionalOffset.centerLeft : FractionalOffset.center,
      child: new Hero(
          tag: "crew-here-${crew.id}",
          child: CachedNetworkImage(
            imageUrl: crew.logoImageUrl,
            placeholder: (context, url) => new CircularProgressIndicator(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
            height: 92.0,
            width: 92.0,
          )),
    );

    Widget _crewValue({String value, String image}) {
      return new Container(
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
//            new Image.asset(
//              image,
//              height: 12.0,
//            ),
            new Container(
              width: 8.0,
            ),
            new Text(crew.catchPhrase)
          ],
        ),
      );
    }

    final crewCardContent = new Container(
        margin: new EdgeInsets.fromLTRB(
            horizontal ? 76.0 : 16.0, horizontal ? 16.0 : 42.0, 16.0, 16.0),
        constraints: new BoxConstraints.expand(),
        child: new Column(
          crossAxisAlignment:
              horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: <Widget>[
            new Container(
              height: 4.0,
            ),
            new Text(
              crew.name,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600),
            ),
            new Container(
              height: 10.0,
            ),
            new Text(crew.catchPhrase,
                style: TextStyle(
//                  color: Color(0xffb6b2df),
                  color: Colors.black54,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                )),
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
            new Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CrewSessionPage(),
                        ),
                      );},
                      child: Column(
                        children: <Widget>[
                          Text(
                            random.nextInt(10000).toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "SESSION",
                            style: TextStyle(),
                          )
                        ],
                      ),

                    )
                    ,
                    Column(
                      children: <Widget>[
                        Text(
                          random.nextInt(10000).toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "MEMBER",
                          style: TextStyle(),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          random.nextInt(10000).toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "NOTICE",
                          style: TextStyle(),
                        )
                      ],
                    )
                  ],
                )
            ),
          ],
        )
    );

    final crewCard = new Container(
      child: crewCardContent,
      height: horizontal ? 124.0 : 204.0,
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
          children: <Widget>[crewCard, crewThumbnail],
        ),
      ),
    );
  }
}
