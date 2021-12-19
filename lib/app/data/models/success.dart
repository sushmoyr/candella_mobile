import 'dart:convert';

import 'package:candella/app/data/models/interfaces/api_result.dart';

class Success implements ApiResult {
  @override
  int code;

  @override
  String message;

  @override
  String phrase;

  dynamic body;

  Success(this.code, this.message, this.phrase, this.body);

  factory Success.fromJson(Map<String, dynamic> json) {
    return Success(json['code'], json['message'], json['phrase'], json['body']);
  }

  Map<String, dynamic> toJson() {
    return {"code": code, "message": message, "phrase": phrase, "body": body};
  }
}
