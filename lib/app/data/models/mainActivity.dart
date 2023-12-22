class MainActivityModel {
  String? code;
  String? text;

  MainActivityModel({
    this.code,
    this.text,
  });

  factory MainActivityModel.fromJson(Map<String, dynamic> json) =>
      MainActivityModel(
        code: json["code"],
        text: json["text"],
      );
}
