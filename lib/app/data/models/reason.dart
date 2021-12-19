class Reason {
  Reason({
    required this.field,
    required this.message,
  });

  String? field;
  String? message;

  factory Reason.fromJson(Map<String, dynamic> json) => Reason(
        field: json["field"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "field": field,
        "message": message,
      };
}
