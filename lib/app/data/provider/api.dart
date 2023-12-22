import 'dart:convert';
import 'dart:io';
import 'package:busca_empresa/app/data/models/enterprise.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';

class Api extends GetConnect {
  @override
  void onInit() {
    super.onInit();
  }

  Future<EnterpriseModel> getClient(String cnpj) async {
    try {
      final response = await http.get(
        Uri.parse('https://receitaws.com.br/v1/cnpj/$cnpj'),
      );
      print(cnpj);
      print(response.body);
      return EnterpriseModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw e.toString();
    }
  }
}
