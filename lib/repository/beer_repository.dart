import 'package:http/http.dart' as http;
import 'package:query_params/query_params.dart';
import 'dart:convert';
import '../models/beer.dart';
import 'package:logger/logger.dart';


Future<Stream<Beer>> getBeers(_current_page, _per_page, _searchKeyword) async {
  final String url = 'https://api.punkapi.com/v2/beers';
//  final String url = 'api.punkapi.com';
  Logger logger = Logger();
  logger.d("aa aa: ${_searchKeyword}");

  URLQueryParams queryParams = new URLQueryParams();

  queryParams.append('page', _current_page);
  queryParams.append('per_page', _per_page);

//  var queryParameters = {
//    'page' : _current_page,
//    'per_page' : _per_page
//  };

//  var uri = Uri.https(url, '/v2/beers', queryParameters);

  var aa = url + '?'+ queryParams.toString();

  print('aa : ${aa}');

  final client = new http.Client();
  final streamedRest = await client.send(
      http.Request('get', Uri.parse(aa))
  );

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((data) => (data as List))
      .map((data) => Beer.fromJSON(data));
}