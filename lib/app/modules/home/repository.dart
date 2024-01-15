import 'package:busca_empresa/app/data/models/enterprise.dart';
import 'package:busca_empresa/app/data/provider/api.dart';

class HomeRepository {
  final Api _api;

  HomeRepository(this._api);

  Future<EnterpriseModel> getClient(String cnpj) => _api.getClient(cnpj);
}
