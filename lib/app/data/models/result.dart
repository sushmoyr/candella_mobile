class Result {
  final bool status;
  final String message;
  dynamic body;

  Result(this.status, this.message);

  Result.withBody({required this.status, required this.message, this.body});
}
