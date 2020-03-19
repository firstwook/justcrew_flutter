import 'package:http/http.dart' as http;
import 'package:justcrew_flutter/models/session_detail.dart';
import 'package:query_params/query_params.dart';
import 'dart:convert';
import '../models/crew.dart';
import 'package:logger/logger.dart';


final String baseUrl = 'https://jmzcfz5w7l.execute-api.ap-northeast-2.amazonaws.com/dev';

Future<Stream<Crew>> getCrews(_searchKeyword, _perPage,  _cursorType, _cursorValue) async {
//  final String url = 'https://api.punkapi.com/v2/beers';
////  final String url = 'api.punkapi.com';
//
  String apiPathUrl = baseUrl + '/crews';

  Logger logger = Logger();
  logger.d("aa aa: ${_searchKeyword}");

  URLQueryParams queryParams = new URLQueryParams();

  if(_searchKeyword != null)
    queryParams.append('searchKeyword', _searchKeyword);

  if(_cursorValue != null){
    queryParams.append('cursorType', _cursorType);
    queryParams.append('cursorValue', _cursorValue);
  }

  queryParams.append('perPage', _perPage);

  var requestUrl = apiPathUrl + '?'+ queryParams.toString();;

  print('requestUrl : ${requestUrl}');

  final client = new http.Client();
  final streamedRest = await client.send(
      http.Request('get', Uri.parse(requestUrl))
  );

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((data) => (data as List))
      .map((data) => Crew.fromJSON(data));
}

Future<Stream<Session>> getCrewSessions(_crewId, _durationType, _status, _type, _allowableType, _perPage, _cursorType, _cursorValue) async {
//  final String url = 'https://api.punkapi.com/v2/beers';
////  final String url = 'api.punkapi.com';
//
  String callUrl = baseUrl + '/crews/${_crewId}/sessions';

  URLQueryParams queryParams = new URLQueryParams();

  queryParams.append('perPage', _perPage);

  if(_cursorValue != null){
    queryParams.append('cursorType', _cursorType);
    queryParams.append('cursorValue', _cursorValue);
  }

  queryParams.append('crewId', _crewId);
  queryParams.append('durationType', _durationType);
  queryParams.append('status', _status);
  queryParams.append('type', _type);
  queryParams.append('allowableType', _allowableType);

//  var queryParameters = {
//    'page' : _current_page,
//    'per_page' : _per_page
//  };

//  var uri = Uri.https(url, '/v2/beers', queryParameters);

  var aa = callUrl + '?'+ queryParams.toString();

  print('aa : ${aa}');

  final client = new http.Client();
  final streamedRest = await client.send(
      http.Request('get', Uri.parse(aa))
  );

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((data) => (data as List))
      .map((data) => Session.fromJSON(data));
}