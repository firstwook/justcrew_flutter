import 'package:http/http.dart' as http;
import 'package:query_params/query_params.dart';
import 'dart:convert';
import '../models/crew.dart';
import 'package:logger/logger.dart';


final String baseUrl = 'https://jmzcfz5w7l.execute-api.ap-northeast-2.amazonaws.com/dev';

Future<Stream<Crew>> getSessions(_perPage, _crewId, _durationType, _status, _type, _allowableType) async {
//  final String url = 'https://api.punkapi.com/v2/beers';
////  final String url = 'api.punkapi.com';
//
  String callUrl = baseUrl + '/crews';

  URLQueryParams queryParams = new URLQueryParams();

  queryParams.append('perPage', _perPage);

//  var queryParameters = {
//    'page' : _current_page,
//    'per_page' : _per_page
//  };

//  var uri = Uri.https(url, '/v2/beers', queryParameters);

//  var aa = callUrl + '?'+ queryParams.toString();

  var aa = callUrl;

  print('aa : ${aa}');

  final client = new http.Client();
  final streamedRest = await client.send(
      http.Request('get', Uri.parse(aa))
  );

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((data) => (data as List))
      .map((data) => Crew.fromJSON(data));
}