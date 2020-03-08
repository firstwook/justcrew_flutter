import 'package:flutter/material.dart';
import 'package:justcrew_flutter/repository/crew_repository.dart';
import 'package:justcrew_flutter/widgets/crew_tile.dart';
import 'package:logger/logger.dart';
import '../../../models/crew.dart';

class CrewHomePage extends StatefulWidget {
  @override
  _CrewHomePageState createState() => _CrewHomePageState();
}

class _CrewHomePageState extends State<CrewHomePage> {
  ScrollController _scrollController = ScrollController();

  bool _loadingCrews = true;
  bool _gettingMoreCrews = false;
  bool _moreCrewsAvailable = true;

  Crew _lastCrew;

  String _searchKeyword = '';
  static const int _perPage = 10;

  Logger logger = Logger();

  List<Crew> _crews = <Crew>[];

  final TextEditingController _textEditingController =
      new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listenForCrews(_searchKeyword);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          listenForCrews(_searchKeyword);
        });
      }
    });

//    _scrollController.addListener(() {
//      double maxScroll = _scrollController.position.maxScrollExtent;
//      double currentScroll = _scrollController.position.pixels;
//      double delta = MediaQuery.of(context).size.height * 0.25;
//
//      if (maxScroll - currentScroll <= delta) {
//        _current_page++;
//
//        setState(() {
//          listenForCrews(_current_page, _perPage, _searchKeyword);
//        });
//      }
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loadingCrews == true
          ? Container(
              child: Center(
                child: Text("Loading...."),
              ),
            )
          : Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
//                  child: Row(children: <Widget>[
//                    new Icon(Icons.search, color: _textEditingController.text.length>0?Colors.lightBlueAccent:Colors.grey,),
//                    new SizedBox(width: 10.0,),
//                    new Expanded(child: new Stack(
//                        alignment: const Alignment(1.0, 1.0),
//                        children: <Widget>[
//                          new TextField(
//                            decoration: InputDecoration(hintText: '크루명을 검색해 보세요.'),
//                            onChanged: (text){
//                                _handleSubmitted(text);
//                            },
//                            controller: _textEditingController,),
//                          _textEditingController.text.length>0?new IconButton(icon: new Icon(Icons.clear),
//                              onPressed: () {
//                            _textfieldClear();
//                          }):new Container(height: 0.0,)
//                        ]
//                    ),),
//                  ],),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: TextField(
                          controller: _textEditingController,
                          onSubmitted: _handleSubmitted,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(15.0),
                              hintText: '크루명을 검색해 보세요.',
                              suffixIcon: IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () {
                                    _textfieldClear();
                                  })),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () =>
                              _handleSubmitted(_textEditingController.text),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: _crews.length == 0
                      ? Center(
                          child: Text('No products to show'),
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          itemCount: _crews.length,
                          itemBuilder: (context, index) =>
                              CrewTile(_crews[index]),
                        ),
                )
              ],
            ),
    );
  }

  void listenForCrews(_searchKeyword) async {

    print('_searchKeyword : ${_searchKeyword}');

    if(_lastCrew == null) {

      print("First Crew List CALL");

      final Stream<Crew> stream =
      await getCrews( _searchKeyword, _perPage, null, null);

      List<Crew> _tmpCrews = <Crew>[];

      stream.listen((Crew crew) {
        print("DataReceived: ${crew}");
        _tmpCrews.add(crew);
      }, onDone: () {

        _crews.addAll(_tmpCrews);
        _lastCrew = _tmpCrews[_tmpCrews.length-1];

        print('_lastCrew.length : _lastCrew : ${_lastCrew.id} / ${_lastCrew.name} ');

        print('_temCrews : ${_tmpCrews}');
        print('_temCrews.length!! : ${_tmpCrews.length}');
        print('_crews.length!! : ${_crews.length}');

        print(' _perPage!! : ${_perPage}');
        print('_moreCrewsAvailable : ${_moreCrewsAvailable}');

        if (_tmpCrews.length < _perPage) {
          setState(() {
            print('_crews.length : ${_tmpCrews.length}');

            _moreCrewsAvailable = false;
          });
        }

        setState(() {
          _loadingCrews = false;
        });

      }, onError: (error) {
        print("error : ${error}");
      });

    }else{

      if (_moreCrewsAvailable == false) {
        print("No more products!!!");
        return;
      }

      if (_gettingMoreCrews == true) {
        return;
      }

      final Stream<Crew> stream =
      await getCrews( _searchKeyword, _perPage, 'id', _lastCrew.id);

      List<Crew> _tmpCrews = <Crew>[];

      stream.listen((Crew crew) {
        print("DataReceived: ${crew}");
        _tmpCrews.add(crew);
      }, onDone: () {
        _crews.addAll(_tmpCrews);
        _lastCrew = _tmpCrews[_tmpCrews.length-1];

        print('_lastCrew.length : _lastCrew : ${_lastCrew.id} / ${_lastCrew.name} ');

        print('_temCrews : ${_tmpCrews}');
        print('_temCrews.length!! : ${_tmpCrews.length}');
        print('_crews.length!! : ${_crews.length}');

        print(' _perPage!! : ${_perPage}');
        print('_moreCrewsAvailable : ${_moreCrewsAvailable}');

        if (_tmpCrews.length < _perPage) {
          _moreCrewsAvailable = false;
        }

        setState(() {});
      }, onError: (error) {
        print("error : ${error}");
      });

      _gettingMoreCrews = false;

    }


  }

  void _handleSubmitted(String text) {
    _searchKeyword = text;

    _crews.clear();
    _lastCrew = null;

    logger.d('_handleSubmitted : ${text}');

    listenForCrews(_searchKeyword);

//    setState(() {
//
//    });

//    _textEditingController.clear();
  }

  void _textfieldClear() {

    _gettingMoreCrews = false;
    _moreCrewsAvailable = true;

    _searchKeyword = '';
    _textEditingController.clear();

    _lastCrew = null;
    _crews.clear();

    listenForCrews('');

  }
}
