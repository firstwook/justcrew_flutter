import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:justcrew_flutter/models/session_member.dart';
import 'package:toast/toast.dart';

class SessionMemberTile extends StatefulWidget {
  final SessionMember _sessionMember;

  SessionMemberTile(this._sessionMember);

  @override
  _SessionMemberTileState createState() => _SessionMemberTileState();
}

class _SessionMemberTileState extends State<SessionMemberTile> {
  final df = new DateFormat('yyyy-MM-dd hh:mm a');

  bool _isAttended = false;

  @override
  void initState() {

    _isAttended = (widget._sessionMember.isAttended == 1) ? true : false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Card(
        elevation: 1.5,
        margin: new EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          leading: Container(
            margin: EdgeInsets.only(left: 6.0),
            child: CachedNetworkImage(
              imageUrl: widget._sessionMember.profileImage,
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) => new Icon(Icons.error),
//            height: 70.0,
              fit: BoxFit.fill,
            ),
          ),
          title: Text(
            widget._sessionMember.memberName,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          subtitle: Container(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: new Row(
              children: <Widget>[_getRoleLabel(widget._sessionMember.crewRoleId)],
            ),
          ),
//      trailing: Icon(Icons.check_circle),
          trailing: IconButton(
            icon: Icon(
              (_isAttended) ? Icons.check_circle : Icons.check_circle_outline,
              size: 30,
            ),
            onPressed: () {
              setState(() {
                _isAttended = !_isAttended;
                (_isAttended)
                    ? Toast.show("출석 처리되었습니다.", context)
                    : Toast.show("출석 해제 처리되었습니다.", context);
              });
            },
          ),
        ),
      );

  _getRoleLabel(crwRoleId) {
//    Icon icon;
    Color bgColor;
    Color textColor;
    String labelText;

    switch (crwRoleId) {
      case 2:
        labelText = '크루장';
        bgColor = Colors.blueGrey;
        textColor = Colors.white;
        break;
      case 3:
        labelText = '스텝';
        bgColor = Colors.blueGrey;
        textColor = Colors.white;
        break;
      case 99:
        labelText = '크루원';
        bgColor = Colors.teal;
        textColor = Colors.white;
        break;
      default:
        labelText = '게스트';
        bgColor = Colors.white;
        textColor = Colors.black;
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.black, width: 1.0),
        color: bgColor,
      ),
      width: 60.0,
      height: 20.0,
      child: Text(
        labelText,
        style: TextStyle(
            color: textColor, fontSize: 15, fontWeight: FontWeight.bold),
      ),
      alignment: Alignment(0.0, 0.0),
    );
  }
}
