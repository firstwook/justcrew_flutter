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

  bool _loadingProducts = true;
  bool _gettingMoreProducts = false;
  bool _moreProductsAvailable = true;

  String _searchKeyword = '';
  int _current_page = 1;
  static const int _per_page = 10;

  Logger logger = Logger();

  List<Crew> _crews = <Crew>[];

  final TextEditingController _textEditingController =
      new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listenForCrews(_current_page, _per_page, _searchKeyword);

    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.25;

      if (maxScroll - currentScroll <= delta) {
        _current_page++;

        setState(() {
          listenForCrews(_current_page, _per_page, _searchKeyword);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loadingProducts == true
          ? Container(
              child: Center(
                child: Text("Loading...."),
              ),
            )
          : Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: TextField(
                          controller: _textEditingController,
                          onSubmitted: _handleSubmitted,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(15.0),
                            hintText: '크루명을 검색해 보세요.',
                          ),
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

  void listenForCrews(_current_page, _per_page, _searchKeyword) async {
    logger.d(
        'listenForCrews : ${_current_page}, ${_per_page}, ${_searchKeyword}');

    if (_moreProductsAvailable == false) {
      print("No more products!!!");
      return;
    }

    if (_gettingMoreProducts == true) {
      return;
    }

    final Stream<Crew> stream =
        await getCrews(_current_page, _per_page, _searchKeyword);

    print('stream : ${stream}');

    List<Crew> _temCrews = <Crew>[];

    stream.listen((Crew crew) {
      print("DataReceived: ${crew}");
      _temCrews.add(crew);
    }, onDone: () {
      _crews.addAll(_temCrews);

      print('_temCrews : ${_temCrews}');
      print('_temCrews.length!! : ${_temCrews.length}');
      print('_crews.length!! : ${_crews.length}');

      print(' _per_page!! : ${_per_page}');
      print('_moreProductsAvailable : ${_moreProductsAvailable}');

      if (_temCrews.length < _per_page) {
        setState(() {
          print('_crews.length : ${_temCrews.length}');

          print('_current_page * _per_page : ${_per_page}');

          _moreProductsAvailable = false;
        });
      }

      setState(() {});
    }, onError: (error) {
      print("error : ${error}");
    });

    setState(() {
      _loadingProducts = false;
    });

    _gettingMoreProducts = false;
  }

  void _handleSubmitted(String text) {
    _searchKeyword = text;

    _current_page = 1;
    _crews.clear();
    logger.d('_handleSubmitted : ${text}');

    listenForCrews(_current_page, _per_page, _searchKeyword);

//    _textEditingController.clear();
  }
}
