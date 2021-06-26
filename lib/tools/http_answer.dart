import 'dart:convert';
import 'package:http/http.dart';

class HttpAnswer {
  Response answer;
  String reasonPhrase;
  bool ok;

  dynamic get body =>
      (answer?.body?.isEmpty ?? true) ? null : json.decode(answer.body);

  int get code => answer?.statusCode;

  HttpAnswer({
    this.answer,
    this.reasonPhrase,
    this.ok = false,
  });
}
