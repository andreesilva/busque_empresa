class PartnerModel {
  String? name;
  String? qual;

  PartnerModel({
    this.name,
    this.qual,
  });

  factory PartnerModel.fromJson(Map<String, dynamic> json) => PartnerModel(
        name: json["nome"],
        qual: json["qual"],
      );
}
