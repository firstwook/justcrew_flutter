import 'package:http/http.dart' as http;
import 'package:justcrew_flutter/models/session-member.dart';
import 'package:query_params/query_params.dart';
import 'dart:convert';
import '../models/crew.dart';
import 'package:logger/logger.dart';


final String baseUrl = 'https://e2trrfgv7i.execute-api.ap-northeast-2.amazonaws.com/dev';

Future<Stream<SessionMember>> getSessionMembers(_sessionId) async {
//  final String url = 'https://api.punkapi.com/v2/beers';
////  final String url = 'api.punkapi.com';
//
  String apiPathUrl = baseUrl + '/sessions/${_sessionId}/members';

//  URLQueryParams queryParams = new URLQueryParams();
//  queryParams.append('perPage', _perPage);


  var requestUrl = apiPathUrl;

  print('requestUrl : ${requestUrl}');

  final client = new http.Client();
  final streamedRest = await client.send(
      http.Request('get', Uri.parse(requestUrl))
  );

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((data) => (data as List))
      .map((data) => SessionMember.fromJSON(data));
}