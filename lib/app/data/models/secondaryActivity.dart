class SecondaryActivityModel {
  String? code;
  String? text;

  SecondaryActivityModel({
    this.code,
    this.text,
  });

  factory SecondaryActivityModel.fromJson(Map<String, dynamic> json) =>
      SecondaryActivityModel(
        code: json["code"],
        text: json["text"],
      );
}
