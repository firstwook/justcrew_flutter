import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:justcrew_flutter/models/session_detail.dart';
import 'package:justcrew_flutter/ui/pages/crew/session_detail_page.dart';

class SessionTile extends StatelessWidget {
  final Session _session;

  SessionTile(this._session);

  final df = new DateFormat('yyyy-MM-dd hh:mm a');


  @override
  Widget build(BuildContext context) => Column(
    children: <Widget>[
      ListTile(
        title: Text(
            _session.name,
        style: TextStyle(
          fontSize: 20,
            fontWeight: FontWeight.bold),
        ),
//        subtitle: Text(_session.date),
        subtitle: Container(
//          padding: EdgeInsets.all(10.0),
          child: new Column(
            children: <Widget>[
              Container(
                child: new Row(
                  children: <Widget>[
                    Icon(Icons.place, size: 15,),
                    Text(_session.gatheringPlace),
                  ],
                ),
              ),Container(
                child: new Row(
                  children: <Widget>[
                    Icon(Icons.date_range, size: 15,),
                    Text(df.format(DateTime.parse(_session.date))),
                  ],
                ),
              )
            ],
          ),
        ),
        leading: Container(
          margin: EdgeInsets.only(left: 6.0),
          child: CachedNetworkImage(
            imageUrl: _session.logoImageUrl,
            placeholder: (context, url) => new CircularProgressIndicator(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
//            height: 70.0,
            fit: BoxFit.fill,
          ),
        ),
        onTap: () {
          print('aaaaaaaaaaaaaa');

          Navigator.push(
              context, new MaterialPageRoute(builder: (context) =>
              SessionDetailPage(_session))
          );

        },
      ),
      Divider()
    ],
  );
}
