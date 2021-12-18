import 'package:candella/app/data/models/success_base.dart';

class AuthResponse implements Success {
  final String body;
  @override
  int code;

  @override
  String message;

  @override
  String phrase;

  AuthResponse(this.body, this.code, this.message, this.phrase);
}
