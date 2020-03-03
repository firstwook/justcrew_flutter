import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:justcrew_flutter/models/crew.dart';
import 'package:justcrew_flutter/ui/pages/crew/crew_detail_page.dart';

class CrewTile extends StatelessWidget {
  final Crew _crew;

  CrewTile(this._crew);

  @override
  Widget build(BuildContext context) => Column(
    children: <Widget>[
      ListTile(
        title: Text(_crew.name),
        subtitle: Text(_crew.catchPhrase),
        leading: Container(
          margin: EdgeInsets.only(left: 6.0),
          child: CachedNetworkImage(
            imageUrl: _crew.logoImageUrl,
            placeholder: (context, url) => new CircularProgressIndicator(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
            height: 50.0,
            fit: BoxFit.fill,
          ),
//              child: CachedNetworkImage(
//                imageUrl: 'https://picsum.photos/250?image=7',
//                placeholder: (context, url) => new CircularProgressIndicator(),
//                errorWidget: (context, url, error) => new Icon(Icons.error),
//                height: 50.0,
//                fit: BoxFit.fill,
//              ),
//            child: Image.network(_crew.image_url, height: 50.0, fit: BoxFit.fill,)
        ),
        onTap: () {
          print('aaaaaaaaaaaaaa');

          Navigator.push(
              context, new MaterialPageRoute(builder: (context) =>
              CrewDetailPage(_crew))
          );

        },
      ),
      Divider()
    ],
  );
}
