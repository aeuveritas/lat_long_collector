import 'dart:convert';

import 'package:draccoon_logger/draccoon_logger.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:kakao_address_handler/src/models/barrel.dart';
import 'package:kakao_address_handler/src/models/location_info_chunk.dart';

class KakaoAddressHandler with MixInLogger {
  KakaoAddressHandler._create(this.apiKey, this.blockIntervalSeconds)
      : lastRequested = DateTime.fromMillisecondsSinceEpoch(0);

  final String apiKey;
  final int blockIntervalSeconds;

  DateTime lastRequested;

  static KakaoAddressHandler create(String apiKey, String blockIntervalSeconds) {
    return KakaoAddressHandler._create(apiKey, int.parse(blockIntervalSeconds));
  }

  Future<LocationInfoChunk> getCandidates(String query, int page) async {
    if (page < 1 || 3 < page) {
      info("out of page range, page: $page");
      return const LocationInfoChunk(locationInfoList: [], responseHashCode: 0, tooEarly: false);
    }

    if (DateTime.now().difference(lastRequested).inSeconds < blockIntervalSeconds) {
      info("too early requested");
      return const LocationInfoChunk(locationInfoList: [], responseHashCode: 0, tooEarly: true);
    }

    final response = await requestAndResponse(query, page);

    lastRequested = DateTime.now();

    if (response.statusCode == 200) {
      return await handleResponse(response);
    } else {
      warn("unexpected status code: ${response.statusCode}");
      return const LocationInfoChunk(locationInfoList: [], responseHashCode: 0, tooEarly: false);
    }
  }

  Future<Response> requestAndResponse(String query, int page) async {
    var url = Uri.https(
      "dapi.kakao.com",
      '/v2/local/search/keyword.json',
      {
        "query": query,
        "page": page.toString(),
      },
    );
    return await http.get(
      url,
      headers: <String, String>{
        "Authorization": "KakaoAK $apiKey",
      },
    );
  }

  Future<LocationInfoChunk> handleResponse(Response response) async {
    Map<String, dynamic> responseMap = jsonDecode(response.body);
    final documents = responseMap["documents"] as List<dynamic>?;

    if (documents == null || documents.length == 0) {
      warn("empty documents from response");
      return LocationInfoChunk(locationInfoList: [], responseHashCode: 0, tooEarly: false);
    }

    final result = documents.map((dynamic element) {
      final document = element as Map<String, dynamic>;
      return LocationInfo.fromDocument(document);
    }).toList();

    info("result count: ${result.length}");
    return LocationInfoChunk(locationInfoList: result, responseHashCode: response.body.hashCode, tooEarly: false);
  }
}
