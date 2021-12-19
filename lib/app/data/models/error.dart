import 'dart:convert';

import 'package:candella/app/data/models/reason.dart';

import 'interfaces/api_result.dart';

class Error implements ApiResult {
  @override
  int code;

  @override
  String message;

  @override
  String phrase;

  List<Reason> reasons;

  Error(this.code, this.message, this.phrase, this.reasons);

  factory Error.fromJson(Map<String, dynamic> json) {
    return Error(json['code'], json['message'], json['phrase'],
        List<Reason>.from(json["reasons"].map((x) => Reason.fromJson(x))));
  }

  Map<String, dynamic> toJson() =>
      {"code": code, "message": message, "phrase": phrase, "reasons": reasons};
}
