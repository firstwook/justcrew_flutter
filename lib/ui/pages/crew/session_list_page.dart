import 'package:flutter/material.dart';
import 'package:justcrew_flutter/models/session_detail.dart';
import 'package:justcrew_flutter/repository/crew_repository.dart';
import 'package:justcrew_flutter/widgets/crew_tile.dart';
import 'package:justcrew_flutter/widgets/session_tile.dart';
import 'package:logger/logger.dart';
import '../../../models/crew.dart';

class SessionListPage extends StatefulWidget {

  final int crewId;
  final String durationType;
  final String status;
  final int type;
  final int allowableType;

  const SessionListPage({Key key, this.crewId, this.durationType, this.status, this.type, this.allowableType}) : super(key: key);

  @override
  _SessionListPageState createState() => _SessionListPageState();
}

class _SessionListPageState extends State<SessionListPage> {

  ScrollController _scrollController = ScrollController();

  bool _loadingSessions = true;
  bool _gettingMoreSessions = false;
  bool _moreSessionsAvailable = true;

  Session _lastSession;

  static const int _perPage = 20;

  Logger logger = Logger();

//  List<Crew> _crews = <Crew>[];
  List<Session> _sessions = <Session>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("crewId ; ${widget.crewId} / isUpcomming : ${widget.durationType}");

    listenForSessions();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          listenForSessions();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

//    print("crewId ; ${widget.crewId} / isUpcomming : ${widget.isUpcoming}");

    return Scaffold(
      body: _loadingSessions == true
          ? Container(
        child: Center(
          child: Text("Loading...."),
        ),
      )
          : Column(
        children: <Widget>[
          Expanded(
            child: _sessions.length == 0
                ? Center(
              child: Text('No products to show'),
            )
                : ListView.builder(
              controller: _scrollController,
              itemCount: _sessions.length,
              itemBuilder: (context, index) =>
                  SessionTile(_sessions[index]),
            ),
          )
        ],
      ),
    );
  }

//  void listenForSessions(_perPage, _crewId, _durationType, _status, _type, _allowableType) async {
  void listenForSessions() async {
    if(_lastSession == null){

      print("First Session List CALL");

      final Stream<Session> stream =
      await getCrewSessions(widget.crewId, widget.durationType, widget.status, widget.type, widget.allowableType, _perPage, null, null);

      print('stream : ${stream}');
      List<Session> _tmpSessions = <Session>[];

      stream.listen((Session session) {
        print("DataReceived: ${session}");
        _tmpSessions.add(session);
      }, onDone: () {

        _sessions.addAll(_tmpSessions);
        _lastSession = _tmpSessions[_tmpSessions.length-1];

        print('_tmpSessions.length : ${_tmpSessions.length} / _lastSession : ${_lastSession.id} / ${_lastSession.name} / ${_lastSession.date}');

        if (_tmpSessions.length < _perPage) {
          print('First _tmpSessions.length : ${_tmpSessions.length}');
          _moreSessionsAvailable = false;
        }
        setState(() {
          _loadingSessions = false;
        });
      }, onError: (error) {
        print("error : ${error}");
      });

    }else{

      print("More Session List CALL");

      if (_moreSessionsAvailable == false) {
        print("No more products!!!");
        return;
      }

      if (_gettingMoreSessions == true) {
        return;
      }

      final Stream<Session> stream =
      await getCrewSessions(widget.crewId, widget.durationType, widget.status, widget.type, widget.allowableType, _perPage, 'date', _lastSession.date);

      List<Session> _tmpSessions = <Session>[];

      stream.listen((Session session) {
        print("DataReceived: ${session}");
        _tmpSessions.add(session);
      }, onDone: () {
        _sessions.addAll(_tmpSessions);
        _lastSession = _tmpSessions[_tmpSessions.length-1];

        if (_tmpSessions.length < _perPage) {
          _moreSessionsAvailable = false;
        }
        setState(() {});

      }, onError: (error) {
        print("error : ${error}");
      });


      _gettingMoreSessions = false;

    }
  }
}