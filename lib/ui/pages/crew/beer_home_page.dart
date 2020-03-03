import 'package:flutter/material.dart';
import 'package:justcrew_flutter/widgets/beer_tile.dart';
import 'package:logger/logger.dart';
import '../../../models/beer.dart';
import '../../../repository/beer_repository.dart';

class BeerHomePage extends StatefulWidget {
  @override
  _BeerHomePageState createState() => _BeerHomePageState();
}

class _BeerHomePageState extends State<BeerHomePage> {

  ScrollController _scrollController = ScrollController();

  bool _loadingProducts = true;
  bool _gettingMoreProducts = false;
  bool _moreProductsAvailable = true;

  String _searchKeyword = '';
  int _current_page = 1;
  static const int _per_page = 10;

  Logger logger = Logger();

  List<Beer> _beers = <Beer>[];

  final TextEditingController _textEditingController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listenForBeers(_current_page, _per_page, _searchKeyword);

    _scrollController.addListener(() {

      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.25;

      if(maxScroll - currentScroll <= delta){

        _current_page++;

        setState(() {
          listenForBeers(_current_page, _per_page, _searchKeyword);
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
                   child:
                     TextField(
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
                     onPressed: () => _handleSubmitted(_textEditingController.text),
                   ),
                 )
               ],
             ),
           ),

           Expanded(
             child:
             _beers.length == 0 ? Center(
               child: Text('No products to show'),
             ): ListView.builder(
               controller: _scrollController,
               itemCount: _beers.length,
               itemBuilder: (context, index) => BeerTile(_beers[index]),
             ),
           )
         ],
       ),
    );
  }

  void listenForBeers(_current_page, _per_page, _searchKeyword) async {

    logger.d('listenForBeers : ${_current_page}, ${_per_page}, ${_searchKeyword}');

    if(_moreProductsAvailable == false){
      print("No more products!!!");
      return;
    }

    if(_gettingMoreProducts == true){
      return;
    }

//    final Stream<Beer> stream = await getBeers(param);
//    stream.listen((Beer beer) => setState(() => _beers.add(beer)));


    final Stream<Beer> stream = await getBeers(_current_page, _per_page, _searchKeyword);

    print('stream : ${stream}');

//    stream.listen((Beer beer) => setState(() => _beers.add(beer)));

//    stream.listen((Beer beer) => setState(() => _beers.add(beer)));



//    stream.listen((Beer beer) => setState(() => _beers.add(beer) ));


    List<Beer> _temBeers = <Beer>[];

    stream.listen((Beer beer) {
      print("DataReceived: ${beer}");
      _temBeers.add(beer);
    }, onDone: () {

      _beers.addAll(_temBeers);

      print('_temBeers : ${_temBeers}');
      print('_temBeers.length!! : ${_temBeers.length}');
      print('_beers.length!! : ${_beers.length}');

      print(' _per_page!! : ${_per_page}');
      print('_moreProductsAvailable : ${_moreProductsAvailable}');

      if(_temBeers.length < _per_page){

        setState(() {
          print('_beers.length : ${_temBeers.length}');

          print('_current_page * _per_page : ${ _per_page}');

          _moreProductsAvailable = false;
        });

      }

      setState(() {

      });

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
    _beers.clear();
    logger.d('_handleSubmitted : ${text}');

    listenForBeers(_current_page, _per_page, _searchKeyword);

//    _textEditingController.clear();
  }
}
