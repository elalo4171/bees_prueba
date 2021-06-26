import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'http_answer.dart';

enum RequestMethod { POST, GET, DELETE, PATCH, NONE, PUT }

class RequestProvider {
  static final RequestProvider _instance = RequestProvider._();

  static const useSecureProtocol = true;

  factory RequestProvider() => _instance;

  RequestProvider._();

  Map<String, String> get _headers {
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
    };
    return header;
  }

  Future<HttpAnswer> request(
    String api,
    String path, {
    RequestMethod method = RequestMethod.POST,
    Map<String, String> params,
    body,
    bool useSecureProtocol = useSecureProtocol,
    Map<String, String> customHeaders = const {},
  }) async {
    print("[@Go Fitness] < $method > request: $api$path\n");

    const timeout = Duration(seconds: 30);

    var request = HttpAnswer();
    var headers = customHeaders.isNotEmpty ? customHeaders : _headers;

    try {
      if (method == RequestMethod.GET || method == RequestMethod.DELETE) {
        Uri uri = useSecureProtocol
            ? Uri.https(api, path, params)
            : Uri.http(api, path, params);

        request.answer = (method == RequestMethod.GET)
            ? await http.get(uri, headers: headers).timeout(timeout)
            : await http.delete(uri, headers: headers).timeout(timeout);
      } else {
        Uri uri =
            useSecureProtocol ? Uri.https(api, path) : Uri.http(api, path);

        request.answer = (method == RequestMethod.POST)
            ? await http
                .post(uri, body: body, headers: headers)
                .timeout(timeout)
            : await http
                .put(uri, body: body, headers: headers)
                .timeout(timeout);
      }

      _handleHttpCodeOf(request);
    } on TimeoutException catch (_) {
      request.reasonPhrase = "Exceeded timeout";
    } catch (e) {
      if (e is SocketException) {
        request.reasonPhrase = "Server connection fail";
      } else {
        request.reasonPhrase = "Intern error [Atgo] ${e?.message}";
      }
    }

    return request;
  }

  void _handleHttpCodeOf(HttpAnswer response) {
    var statusCode = response.answer.statusCode;

    if (statusCode == 503) {
      response.reasonPhrase = "Unavailable service ";
    }

    if (statusCode >= 500) {
      response.reasonPhrase = "Intern server error "
          "[$statusCode] ${response.answer.reasonPhrase}.";
    } else if (statusCode >= 400) {
      response.reasonPhrase = "Request client error "
          "[$statusCode] ${response.answer.reasonPhrase}.";
    } else if (statusCode >= 200 || statusCode <= 204) {
      response.ok = true;
    } else {
      response.reasonPhrase = "Unexpected error "
          "[$statusCode] ${response.answer.reasonPhrase}.";
    }
  }
}
