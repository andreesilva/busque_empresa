import 'package:busca_empresa/app/data/models/mainActivity.dart';
import 'package:busca_empresa/app/data/models/partner.dart';
import 'package:busca_empresa/app/data/models/secondaryActivity.dart';

class EnterpriseModel {
  String? opening;
  String? situation;
  String? name;
  String? fantasy;
  String? size;
  String? type;
  String? legalNature;
  String? publicPlace;
  String? number;
  String? complement;
  String? county;
  String? neighborhood;
  String? uf;
  String? cep;
  String? email;
  String? phone;
  String? cnpj;
  String? status;
  String? shareCapital;
  List<MainActivityModel> mainActivity;
  List<SecondaryActivityModel> secondaryActivity;
  List<PartnerModel> partners;

  EnterpriseModel({
    this.opening,
    this.situation,
    required this.name,
    this.fantasy,
    this.size,
    this.type,
    this.legalNature,
    this.publicPlace,
    this.number,
    this.complement,
    this.county,
    this.neighborhood,
    this.uf,
    this.cep,
    this.email,
    this.phone,
    this.cnpj,
    this.status,
    this.shareCapital,
    required this.mainActivity,
    required this.secondaryActivity,
    required this.partners,
  });

  factory EnterpriseModel.fromJson(Map<String, dynamic> json) =>
      EnterpriseModel(
          opening: json["abertura"],
          situation: json["situacao"],
          name: json["nome"],
          fantasy: json["fantasia"],
          size: json["porte"],
          type: json["tipo"],
          legalNature: json["natureza_juridica"],
          publicPlace: json["logradouro"],
          number: json["numero"],
          complement: json["complemento"],
          county: json["municipio"],
          neighborhood: json["bairro"],
          uf: json["uf"],
          cep: json["cep"],
          email: json["email"],
          phone: json["telefone"],
          cnpj: json["cnpj"],
          status: json["status"],
          shareCapital: json["capital_social"],
          mainActivity: json['atividade_principal'] == null
              ? []
              : List<MainActivityModel>.from(json["atividade_principal"]
                  .map((activity) => MainActivityModel.fromJson(activity))),
          secondaryActivity: json['atividades_secundarias'] == null
              ? []
              : List<SecondaryActivityModel>.from(json["atividades_secundarias"]
                  .map((secondary) =>
                      SecondaryActivityModel.fromJson(secondary))),
          partners: json['qsa'] == null
              ? []
              : List<PartnerModel>.from(json["qsa"]
                  .map((partner) => PartnerModel.fromJson(partner))));
}
